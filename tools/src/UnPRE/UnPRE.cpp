//****************************************************************************
//* MODULE:         Tools/UnPRE
//* FILENAME:       UnPRE.cpp
//* DESCRIPTION:    Modern, self-contained extractor for Neversoft .PRE / .PRX
//*                 archives (Tony Hawk's Underground & related THPS-engine
//*                 games). Supports command-line use and Windows
//*                 drag-and-drop onto the .exe.
//*
//* The .PRE container format and the LZSS codec are reverse-engineered from
//* the original engine source (Code/Sys/File/PRE.cpp) and the build tool
//* (tools/src/MakePRE). This tool has NO dependency on the game engine.
//****************************************************************************

#include <cstdio>
#include <cstdint>
#include <cstring>
#include <cstdlib>
#include <string>
#include <vector>
#include <filesystem>
#include <fstream>
#include <system_error>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

namespace fs = std::filesystem;

//============================================================================
// PRE format constants
//============================================================================

// Magic / version stamp written by MakePRE and checked by the engine.
static const uint32_t kPreVersion   = 0xabcd0003u;
static const int      kNameOffset   = 16;   // PRE_NAME_OFFSET: dataSize(4)+compSize(4)+nameSize(4)+checksum(4)

//============================================================================
// LZSS decoder
//
// Byte-for-byte port of File::DecodeLZSS() from the engine (USE_BUFFER path).
// N=4096 ring buffer seeded with spaces; flags byte gates 8 literal/match
// tokens; a match token is (12-bit offset, 4-bit length+THRESHOLD).
//============================================================================

static const int kRingSize  = 4096;   // N
static const int kMatchMax  = 18;     // F
static const int kThreshold = 2;

// Decompress `inLen` bytes at `in` into `out` (expected to hold exactly
// `outCap` = original uncompressed size). Returns bytes actually written.
static size_t DecodeLZSS(const uint8_t *in, size_t inLen, uint8_t *out, size_t outCap)
{
    std::vector<uint8_t> text_buf(kRingSize + kMatchMax - 1, 0);
    for (int i = 0; i < kRingSize - kMatchMax; i++)
        text_buf[i] = ' ';

    int    r     = kRingSize - kMatchMax;
    unsigned flags = 0;
    size_t ip = 0, op = 0;

    for (;;)
    {
        if (((flags >>= 1) & 256) == 0)
        {
            if (ip >= inLen) break;
            unsigned c = in[ip++];
            flags = c | 0xff00u;          // high byte counts the 8 tokens
        }

        if (flags & 1)
        {
            // literal byte
            if (ip >= inLen) break;
            uint8_t c = in[ip++];
            if (op < outCap) out[op++] = c;
            text_buf[r++] = c;
            r &= (kRingSize - 1);
        }
        else
        {
            // back-reference (offset, length)
            if (ip >= inLen) break;
            int i = in[ip++];
            if (ip >= inLen) break;
            int j = in[ip++];
            i |= ((j & 0xf0) << 4);                 // 12-bit offset
            j  = (j & 0x0f) + kThreshold;           // length-1
            for (int k = 0; k <= j; k++)
            {
                uint8_t c = text_buf[(i + k) & (kRingSize - 1)];
                if (op < outCap) out[op++] = c;
                text_buf[r++] = c;
                r &= (kRingSize - 1);
            }
        }
    }
    return op;
}

//============================================================================
// Endian helpers (PS2/PC/Xbox PRE files are little-endian; GameCube is big)
//============================================================================

static inline uint32_t swap32(uint32_t v)
{
    return ((v & 0x000000ffu) << 24) | ((v & 0x0000ff00u) << 8) |
           ((v & 0x00ff0000u) >> 8)  | ((v & 0xff000000u) >> 24);
}

struct Reader
{
    const uint8_t *p;
    size_t         size;
    bool           bigEndian;

    uint32_t u32(size_t off) const
    {
        uint32_t v;
        std::memcpy(&v, p + off, 4);
        return bigEndian ? swap32(v) : v;
    }
};

//============================================================================
// Path safety + output helpers
//============================================================================

// Turn a stored archive name (e.g. "levels\\sk5ed\\sk5ed.tex.xbx") into a
// safe relative path: normalize separators, drop drive/leading slashes and
// any ".." components so nothing escapes the output root.
static fs::path SanitizeRelative(const char *raw)
{
    std::string s(raw);
    for (char &c : s) if (c == '\\') c = '/';

    fs::path clean;
    fs::path in = fs::path(s);
    for (const auto &part : in)
    {
        std::string seg = part.string();
        if (seg.empty() || seg == "/" || seg == "." || seg == "..")
            continue;
        if (seg.size() == 2 && seg[1] == ':')   // strip "C:" style drive
            continue;
        clean /= seg;
    }
    if (clean.empty())
        clean = "unnamed_file";
    return clean;
}

//============================================================================
// Core: open one PRE and walk its entries
//============================================================================

struct Options
{
    fs::path outRoot;       // explicit -o root, or empty for auto
    bool     listOnly = false;
    bool     quiet    = false;
};

static bool ReadWholeFile(const fs::path &path, std::vector<uint8_t> &buf)
{
    std::ifstream f(path, std::ios::binary | std::ios::ate);
    if (!f) return false;
    std::streamsize n = f.tellg();
    if (n < 0) return false;
    f.seekg(0);
    buf.resize((size_t)n);
    if (n > 0 && !f.read(reinterpret_cast<char *>(buf.data()), n))
        return false;
    return true;
}

// Returns number of files extracted (or listed), or -1 on hard error.
static long ProcessPre(const fs::path &prePath, const Options &opt, int &outErrors)
{
    std::vector<uint8_t> data;
    if (!ReadWholeFile(prePath, data))
    {
        std::fprintf(stderr, "ERROR: cannot open %s\n", prePath.string().c_str());
        return -1;
    }
    if (data.size() < 12)
    {
        std::fprintf(stderr, "ERROR: %s is too small to be a PRE\n", prePath.string().c_str());
        return -1;
    }

    Reader rd{ data.data(), data.size(), false };

    // Detect endianness via the version stamp at offset 4.
    uint32_t version = rd.u32(4);
    if (version != kPreVersion)
    {
        rd.bigEndian = true;
        version = rd.u32(4);
        if (version != kPreVersion)
        {
            std::fprintf(stderr,
                "ERROR: %s is not a recognized PRE (version 0x%08x, expected 0x%08x)\n",
                prePath.string().c_str(), rd.u32(4), kPreVersion);
            return -1;
        }
        if (!opt.quiet)
            std::printf("  (big-endian / GameCube PRE detected)\n");
    }

    uint32_t storedSize = rd.u32(0);
    uint32_t numFiles   = rd.u32(8);

    if (!opt.quiet)
    {
        std::printf("PRE: %s\n", prePath.filename().string().c_str());
        std::printf("  version 0x%08x, %u file(s), %u bytes",
                    version, numFiles, storedSize);
        if (storedSize != data.size())
            std::printf("  [note: on-disk size is %zu]", data.size());
        std::printf("\n");
    }

    // Determine output root.
    fs::path root;
    if (!opt.listOnly)
    {
        if (!opt.outRoot.empty())
            root = opt.outRoot;
        else
            root = prePath.parent_path() / prePath.stem();   // e.g. cutscenes/
        std::error_code ec;
        fs::create_directories(root, ec);
    }

    long count   = 0;
    int  errors  = 0;
    size_t off   = 12;   // first entry

    for (uint32_t i = 0; i < numFiles; i++)
    {
        if (off + kNameOffset > data.size())
        {
            std::fprintf(stderr, "ERROR: entry %u header runs past end of file\n", i);
            errors++;
            break;
        }

        uint32_t dataSize = rd.u32(off + 0);
        uint32_t compSize = rd.u32(off + 4);
        // nameSize is a 32-bit field but the engine reads it as a 16-bit short.
        uint32_t nameSize = rd.u32(off + 8) & 0xffffu;

        uint32_t actual   = compSize ? compSize : dataSize;
        size_t   nameOff  = off + kNameOffset;
        size_t   dataOff  = nameOff + nameSize;
        size_t   padded   = (actual + 3u) & ~3u;

        if (dataOff + actual > data.size())
        {
            std::fprintf(stderr, "ERROR: entry %u data runs past end of file\n", i);
            errors++;
            break;
        }

        // The stored name is null-terminated inside its (padded) buffer.
        const char *rawName = reinterpret_cast<const char *>(data.data() + nameOff);
        size_t maxName = nameSize ? nameSize : 0;
        std::string name(rawName, strnlen(rawName, maxName));

        if (opt.listOnly)
        {
            std::printf("  %8u  %s%s\n", dataSize,
                        name.c_str(), compSize ? "  [packed]" : "");
            count++;
            off = dataOff + padded;
            continue;
        }

        // Decode / copy into the output buffer.
        std::vector<uint8_t> outBuf(dataSize);
        if (compSize)
        {
            size_t written = DecodeLZSS(data.data() + dataOff, compSize,
                                        outBuf.data(), dataSize);
            if (written != dataSize && !opt.quiet)
                std::fprintf(stderr,
                    "  WARNING: %s decompressed to %zu bytes, expected %u\n",
                    name.c_str(), written, dataSize);
        }
        else
        {
            std::memcpy(outBuf.data(), data.data() + dataOff, dataSize);
        }

        fs::path dest = root / SanitizeRelative(name.c_str());
        std::error_code ec;
        fs::create_directories(dest.parent_path(), ec);

        std::ofstream out(dest, std::ios::binary);
        if (!out || !out.write(reinterpret_cast<const char *>(outBuf.data()), dataSize))
        {
            std::fprintf(stderr, "  ERROR: failed to write %s\n", dest.string().c_str());
            errors++;
        }
        else
        {
            if (!opt.quiet)
                std::printf("  extracted  %s  (%u bytes)%s\n",
                            name.c_str(), dataSize, compSize ? "" : "  [stored]");
            count++;
        }

        off = dataOff + padded;
    }

    outErrors += errors;
    if (!opt.quiet && !opt.listOnly)
        std::printf("  -> %ld file(s) to %s\n", count, root.string().c_str());
    return count;
}

//============================================================================
// CLI
//============================================================================

static void PrintUsage(const char *exe)
{
    std::printf(
        "UnPRE - extract Neversoft .PRE / .PRX archives (THUG/THPS engine)\n\n"
        "Usage:\n"
        "  %s [options] <file.pre> [more.pre ...]\n\n"
        "Options:\n"
        "  -o, --out <dir>   extract everything under <dir>\n"
        "                    (default: a folder named after each .pre, beside it)\n"
        "  -l, --list        list contents without extracting\n"
        "  -q, --quiet       only print warnings/errors\n"
        "  -h, --help        show this help\n\n"
        "Drag & drop:\n"
        "  Drop one or more .pre/.prx files onto %s to extract each into\n"
        "  its own folder next to the original.\n",
        exe, exe);
}

#ifdef _WIN32
// True when the process owns its console (double-clicked / drag-and-drop),
// so we should pause before the window vanishes.
static bool LaunchedFromExplorer()
{
    DWORD pids[2];
    DWORD n = GetConsoleProcessList(pids, 2);
    return n <= 1;
}
#endif

int main(int argc, char *argv[])
{
    Options opt;
    std::vector<fs::path> inputs;

    for (int i = 1; i < argc; i++)
    {
        std::string a = argv[i];
        if (a == "-h" || a == "--help")
        {
            PrintUsage(argv[0]);
            return 0;
        }
        else if (a == "-l" || a == "--list")  opt.listOnly = true;
        else if (a == "-q" || a == "--quiet") opt.quiet = true;
        else if (a == "-o" || a == "--out")
        {
            if (i + 1 >= argc)
            {
                std::fprintf(stderr, "ERROR: %s needs a directory argument\n", a.c_str());
                return 2;
            }
            opt.outRoot = argv[++i];
        }
        else if (!a.empty() && a[0] == '-')
        {
            std::fprintf(stderr, "ERROR: unknown option %s\n", a.c_str());
            return 2;
        }
        else
        {
            inputs.push_back(a);
        }
    }

    int rc = 0;

    if (inputs.empty())
    {
        PrintUsage(argv[0]);
        rc = 1;
    }
    else
    {
        int errors = 0;
        for (const auto &in : inputs)
        {
            long r = ProcessPre(in, opt, errors);
            if (r < 0) rc = 1;
        }
        if (errors > 0)
        {
            std::fprintf(stderr, "\nCompleted with %d error(s).\n", errors);
            rc = 1;
        }
    }

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
