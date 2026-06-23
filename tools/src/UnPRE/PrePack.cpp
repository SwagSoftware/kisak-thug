//****************************************************************************
//* MODULE:         Tools/UnPRE
//* FILENAME:       PrePack.cpp
//* DESCRIPTION:    Modern, self-contained *packer* for Neversoft .PRE / .PRX
//*                 archives. The inverse of UnPRE: give it a folder and it
//*                 builds a .PRE from everything inside, preserving the
//*                 relative directory structure as internal file names.
//*
//* Container layout and the compress/keep heuristic are taken from the
//* original build tool (tools/src/MakePRE/MakePRE.cpp); the LZSS encoder is
//* the game's own Encode() from MakePRE/lzss.cpp, linked in unchanged.
//****************************************************************************

#include <cstdio>
#include <cstdint>
#include <cstring>
#include <cstdlib>
#include <string>
#include <vector>
#include <filesystem>
#include <fstream>
#include <algorithm>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

namespace fs = std::filesystem;

// The game's real LZSS encoder (MakePRE/lzss.cpp), linked unchanged.
extern int Encode(char *pIn, char *pOut, int bytes_to_read, bool print_progress);

//============================================================================
// Format constants (match MakePRE / the engine)
//============================================================================
static const uint32_t kPreVersion = 0xabcd0003u;
static const float    kCompressLimit = 0.85f;   // keep packed only if it helps

//============================================================================
// CRC (verbatim from MakePRE.cpp) — lowercased, '/' -> '\' normalized.
//============================================================================
static uint32_t CRCTable[256];
static void InitCRC()
{
    for (uint32_t n = 0; n < 256; n++)
    {
        uint32_t c = n;
        for (int k = 0; k < 8; k++)
            c = (c & 1) ? (0xedb88320u ^ (c >> 1)) : (c >> 1);
        CRCTable[n] = c;
    }
}
static uint32_t GenerateCRCFromString(const char *pName)
{
    if (!pName) return 0;
    uint32_t rc = 0xffffffffu;
    for (const char *p = pName; *p; ++p)
    {
        char ch = *p;
        if (ch >= 'A' && ch <= 'Z') ch = 'a' + ch - 'A';
        if (ch == '/') ch = '\\';
        rc = CRCTable[(rc ^ ch) & 0xff] ^ ((rc >> 8) & 0x00ffffffu);
    }
    return rc;
}

//============================================================================
// Little-endian writer helpers
//============================================================================
static void put32(std::vector<uint8_t> &b, size_t at, uint32_t v)
{
    b[at + 0] = (uint8_t)(v);
    b[at + 1] = (uint8_t)(v >> 8);
    b[at + 2] = (uint8_t)(v >> 16);
    b[at + 3] = (uint8_t)(v >> 24);
}

//============================================================================
struct Options
{
    fs::path root;          // folder to pack
    fs::path outFile;       // -o
    bool     forceStore = false;
    bool     quiet = false;
};

static bool ReadWholeFile(const fs::path &p, std::vector<uint8_t> &buf)
{
    std::ifstream f(p, std::ios::binary | std::ios::ate);
    if (!f) return false;
    std::streamsize n = f.tellg();
    if (n < 0) return false;
    f.seekg(0);
    buf.resize((size_t)n);
    if (n > 0 && !f.read(reinterpret_cast<char *>(buf.data()), n)) return false;
    return true;
}

static int Pack(const Options &opt)
{
    if (!fs::is_directory(opt.root))
    {
        std::fprintf(stderr, "ERROR: %s is not a folder\n", opt.root.string().c_str());
        return 1;
    }

    // Collect files (sorted for stable, reproducible output).
    std::vector<fs::path> files;
    for (auto &e : fs::recursive_directory_iterator(opt.root))
        if (e.is_regular_file()) files.push_back(e.path());
    std::sort(files.begin(), files.end());

    if (files.empty())
    {
        std::fprintf(stderr, "ERROR: no files under %s\n", opt.root.string().c_str());
        return 1;
    }

    fs::path out = opt.outFile.empty()
        ? (opt.root.parent_path() / (opt.root.filename().string() + ".pre"))
        : opt.outFile;

    std::vector<uint8_t> buf;
    buf.resize(12, 0);                  // header, filled in at the end
    uint64_t rawTotal = 0, packTotal = 0;
    uint32_t numFiles = 0;

    std::vector<char> compBuf;

    for (const auto &path : files)
    {
        // Internal name = path relative to root, backslash-separated.
        std::string name = fs::relative(path, opt.root).generic_string();
        for (char &c : name) if (c == '/') c = '\\';

        std::vector<uint8_t> data;
        if (!ReadWholeFile(path, data))
        {
            std::fprintf(stderr, "  WARNING: skipping unreadable %s\n", path.string().c_str());
            continue;
        }

        uint32_t dataSize = (uint32_t)data.size();
        uint32_t nameSize = (uint32_t)((name.size() + 4) & ~size_t(3)); // null + 4-byte pad

        // Try compression unless told to store.
        uint32_t compressedSize = 0;
        std::vector<uint8_t> payload;
        if (!opt.forceStore && dataSize > 0)
        {
            compBuf.resize((size_t)dataSize * 2 + 4096);
            int cs = Encode(reinterpret_cast<char *>(data.data()),
                            compBuf.data(), (int)dataSize, false);
            float ratio = dataSize ? (float)cs / dataSize : 1.0f;
            if (cs > 0 && ratio <= kCompressLimit)
            {
                compressedSize = (uint32_t)cs;
                payload.assign(compBuf.begin(), compBuf.begin() + cs);
            }
        }
        if (compressedSize == 0)
            payload = data;             // stored

        uint32_t actual = compressedSize ? compressedSize : dataSize;
        uint32_t padded = (actual + 3u) & ~3u;

        // Append entry: 16-byte record + name(padded) + payload(padded).
        size_t entryStart = buf.size();
        buf.resize(entryStart + 16 + nameSize + padded, 0);
        put32(buf, entryStart + 0, dataSize);
        put32(buf, entryStart + 4, compressedSize);
        put32(buf, entryStart + 8, nameSize);
        put32(buf, entryStart + 12, GenerateCRCFromString(name.c_str()));
        std::memcpy(&buf[entryStart + 16], name.data(), name.size()); // rest stays 0
        std::memcpy(&buf[entryStart + 16 + nameSize], payload.data(), actual);

        rawTotal  += dataSize;
        packTotal += actual;
        numFiles++;

        if (!opt.quiet)
            std::printf("  added  %s  (%u bytes%s)\n", name.c_str(), dataSize,
                        compressedSize ? " -> packed" : ", stored");
    }

    // Fill in header.
    put32(buf, 0, (uint32_t)buf.size());
    put32(buf, 4, kPreVersion);
    put32(buf, 8, numFiles);

    std::ofstream of(out, std::ios::binary);
    if (!of || !of.write(reinterpret_cast<const char *>(buf.data()), buf.size()))
    {
        std::fprintf(stderr, "ERROR: cannot write %s\n", out.string().c_str());
        return 1;
    }

    if (!opt.quiet)
    {
        std::printf("\nWrote %s\n", out.string().c_str());
        std::printf("  %u file(s), %llu bytes of data packed into %llu (ratio %.3f)\n",
                    numFiles, (unsigned long long)rawTotal, (unsigned long long)packTotal,
                    rawTotal ? (double)packTotal / rawTotal : 0.0);
    }
    return 0;
}

static void PrintUsage(const char *exe)
{
    std::printf(
        "PrePack - build a Neversoft .PRE archive from a folder (THUG/THPS engine)\n\n"
        "Usage:\n"
        "  %s [options] <folder>\n\n"
        "Options:\n"
        "  -o, --out <file>  output .pre path (default: <folder>.pre beside it)\n"
        "      --store       store everything uncompressed (no LZSS)\n"
        "  -q, --quiet       only print warnings/errors\n"
        "  -h, --help        show this help\n\n"
        "All files under <folder> are packed; their paths relative to <folder>\n"
        "become the internal names. PrePack is the inverse of UnPRE.\n",
        exe);
}

#ifdef _WIN32
static bool LaunchedFromExplorer()
{
    DWORD pids[2];
    return GetConsoleProcessList(pids, 2) <= 1;
}
#endif

int main(int argc, char *argv[])
{
    InitCRC();
    Options opt;
    bool haveRoot = false;

    for (int i = 1; i < argc; i++)
    {
        std::string a = argv[i];
        if (a == "-h" || a == "--help") { PrintUsage(argv[0]); return 0; }
        else if (a == "--store") opt.forceStore = true;
        else if (a == "-q" || a == "--quiet") opt.quiet = true;
        else if (a == "-o" || a == "--out")
        {
            if (i + 1 >= argc) { std::fprintf(stderr, "ERROR: %s needs an argument\n", a.c_str()); return 2; }
            opt.outFile = argv[++i];
        }
        else if (!a.empty() && a[0] == '-')
        {
            std::fprintf(stderr, "ERROR: unknown option %s\n", a.c_str()); return 2;
        }
        else { opt.root = a; haveRoot = true; }
    }

    int rc;
    if (!haveRoot) { PrintUsage(argv[0]); rc = 1; }
    else rc = Pack(opt);

#ifdef _WIN32
    if (LaunchedFromExplorer())
    {
        std::printf("\nPress Enter to close...");
        std::fflush(stdout);
        std::getchar();
    }
#endif
    return rc;
}
