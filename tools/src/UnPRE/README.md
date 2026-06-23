# PRE tools — modern Neversoft `.PRE` / `.PRX` extractor, packer & GUI

A small, self-contained toolkit for the `.PRE` (and Xbox `.PRX`) archives used
by Tony Hawk's Underground and other THPS-engine games. It fills the gaps left
by the original `MakePRE` build tool (which only *creates* archives via a
`PROJ_ROOT`/asset-list workflow).

| Tool | What it is |
|------|------------|
| **`UnPRE.exe`** | Command-line **extractor** (+ Windows drag-and-drop) |
| **`PrePack.exe`** | Command-line **packer** — turn a folder back into a `.PRE` |
| **`PreExplorer.exe`** | **7-Zip-style GUI** to browse, open and extract archives |
| `install_shell.bat` | Add right-click menu entries (Extract here / Pack / Open) |
| `uninstall_shell.bat` | Remove those menu entries |
| `build_all.bat` | Build all three executables |

None of these depend on the game engine. The container layout, the LZSS codec
and the compress/keep heuristic were ported from the engine source
(`Code/Sys/File/PRE.cpp`) and the build tool (`tools/src/MakePRE`). The
decompressor is verified as the exact inverse of the game's own encoder
(`roundtrip_test.cpp`), and a full pack→unpack round-trip reproduces every
file byte-for-byte.

---

## UnPRE — extract

```
UnPRE [options] <file.pre> [more.pre ...]

  -o, --out <dir>   extract everything under <dir>
                    (default: a folder named after each .pre, beside it)
  -l, --list        list contents without extracting
  -q, --quiet       only print warnings/errors
  -h, --help        help
```

* **Command line:** `UnPRE Bits.pre` → extracts into `.\Bits\`, internal
  directory structure preserved.
* **Drag & drop:** drop one or more `.pre`/`.prx` files onto `UnPRE.exe`.
  Each is extracted into its own folder next to the original; the window
  pauses at the end so you can read the log.

## PrePack — repack (the inverse of UnPRE)

```
PrePack [options] <folder>

  -o, --out <file>  output .pre path (default: <folder>.pre beside it)
      --store       store everything uncompressed (no LZSS)
  -q, --quiet       only print warnings/errors
  -h, --help        help
```

`PrePack Bits` packs everything under `Bits\` into `Bits.pre`; each file's path
relative to the folder becomes its internal name. By default it LZSS-compresses
each file and keeps the packed version only when it actually shrinks it
(≤ 85 %), matching the original tool.

## PreExplorer — GUI

Double-click `PreExplorer.exe`, then **Open…**, or drag a `.pre`/`.prx` onto the
window (or pass it on the command line). You get a folder tree on the left and a
file list (name / size / packed size / ratio / type) on the right — like 7-Zip.

* Double-click a folder to drill in; **Up** to go back.
* Double-click a file to extract it to a temp folder and open it with its
  default app.
* **Extract All…** or select files/folders and **Extract Selected…**.

It's a .NET Framework WinForms app, so it runs on any Windows 10/11 machine
with no runtime to install.

## Right-click menu (shell integration)

Run **`install_shell.bat`** (no admin needed — it only writes to your own
`HKCU`). It adds:

* `.pre` / `.prx` files → **PRE: Extract here**, **PRE: List contents**, and
  (if the GUI is present) **Open with PRE Explorer** as the double-click action.
* Folders → **Pack folder to .PRE**.

Run **`uninstall_shell.bat`** to remove everything cleanly.

> The menu entries point at the `.exe` files sitting next to the scripts, so
> keep this folder where it is (or re-run the installer after moving it).

---

## Building

* **All at once:** run **`build_all.bat`** (needs Visual Studio with the
  "Desktop development with C++" workload; the GUI uses the always-present
  in-box .NET Framework compiler). Produces all three `.exe` files here.
* **Just the C++ extractor:** `build.bat`.
* **CMake:** `UnPRE` and `PrePack` are wired into the `tools/` CMake project
  (`add_subdirectory(src/UnPRE)`); a normal tools build produces both. The C#
  GUI is built separately (see above).
* **Any C++17 compiler:** `UnPRE.cpp` is a single standalone file, e.g.
  `g++ -O2 -std=c++17 UnPRE.cpp -o UnPRE`. `PrePack.cpp` additionally needs
  `../MakePRE/lzss.cpp`.

## Format notes

A `.PRE` is a 12-byte header (`size`, `version 0xabcd0003`, `numFiles`) followed
by 4-byte-aligned entries. Each entry is a 16-byte record
(`dataSize`, `compressedSize`, `nameSize`, `checksum`), then the null-terminated
name (with `\` separators), then the payload. `compressedSize == 0` means the
payload is stored uncompressed; otherwise it's LZSS-packed and inflates to
`dataSize` bytes. Little-endian (PS2 / PC / Xbox) is the norm; big-endian
(GameCube) files are detected and read automatically.
