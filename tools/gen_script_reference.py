#!/usr/bin/env python3
"""
Generate a script-function reference for the THUG QB scripting engine.

Sources of truth:
  * @script / @parm / @parmopt / @flag autodoc annotations in Code/**/*.cpp|.h
  * CFunctionLookupTable[] and ppMemberFunctionNames[] in Code/Sk/Scripting/ftables.cpp
  * real call examples grepped from the compiled-alongside .q scripts

Output: docs/scripting-engine/function-reference/  (index + per-area pages)

Run from the kisak-thug-claude tools dir; paths are resolved relative to the
sibling kisak-thug working copy that holds the source + Data/scripts.
"""
import os, re, sys, html
from collections import defaultdict

# --- paths -------------------------------------------------------------------
HERE = os.path.dirname(os.path.abspath(__file__))
CLAUDE_ROOT = os.path.dirname(HERE)                       # kisak-thug-claude
SRC_ROOT = os.path.join(os.path.dirname(CLAUDE_ROOT), "kisak-thug")  # kisak-thug
CODE = os.path.join(SRC_ROOT, "Code")
FTABLES = os.path.join(CODE, "Sk", "Scripting", "ftables.cpp")
SCRIPTS_DIR = os.path.join(SRC_ROOT, "build", "Debug", "Data", "scripts")
OUT_DIR = os.path.join(CLAUDE_ROOT, "docs", "scripting-engine", "function-reference")

# --- text sanitising (sources are cp1252 with smart quotes) ------------------
_CP1252_FIX = {
    "‘": "'", "’": "'", "“": '"', "”": '"',
    "–": "-", "—": "-", "…": "...", "•": "*",
    "�": "'", "\xa0": " ",
}
def clean(s):
    for k, v in _CP1252_FIX.items():
        s = s.replace(k, v)
    return s.strip()

def read_text(path):
    with open(path, "r", encoding="cp1252", errors="replace") as f:
        return f.read()

# --- area bucketing ----------------------------------------------------------
def area_for(relpath):
    p = relpath.replace("\\", "/")
    if p.endswith("Sk/Scripting/cfuncs.cpp"):  return ("01-global-commands", "Global Commands (cfuncs)")
    if p.endswith("Sk/Scripting/skfuncs.cpp"): return ("02-skater-career", "Skater / Career / Profile (skfuncs)")
    if p.endswith("Sk/Scripting/mcfuncs.cpp"): return ("03-memory-card", "Memory Card (mcfuncs)")
    if "/Components/" in p:                     return ("04-components", "Object Components (member commands)")
    if "/Gel/Scripting/" in p:                  return ("05-engine-scripting", "Engine Scripting Core (Gel)")
    if "/Sk/Objects/" in p or "/Sk/Modules/" in p: return ("06-objects-modules", "Objects & Modules")
    if "/Gfx/" in p or "/Nx" in p:              return ("07-gfx", "Graphics / Nx")
    return ("08-misc", "Miscellaneous")

# --- parse @script annotation blocks -----------------------------------------
TAG_RE = re.compile(r'^\s*//\s*@(script|parm|parmopt|flag|uses|return|name)\b(.*)$', re.I)
COMMENT_RE = re.compile(r'^\s*//(.*)$')
FUNC_RE = re.compile(r'^\s*bool\s+(?:([A-Za-z_]\w*)::)?(\w+)\s*\(')

class Entry:
    __slots__ = ("name","rettype","desc","parms","flags","file","line","cfunc")
    def __init__(self):
        self.name=""; self.rettype=""; self.desc=[]; self.parms=[]
        self.flags=[]; self.file=""; self.line=0; self.cfunc=""

def parse_file(path, rel):
    lines = read_text(path).splitlines()
    entries = []
    i = 0
    n = len(lines)
    while i < n:
        m = TAG_RE.match(lines[i])
        if not (m and m.group(1).lower() == "script"):
            i += 1; continue
        e = Entry(); e.file = rel; e.line = i + 1
        rest = m.group(2).strip()
        if rest.startswith(":"):
            # component/member form: "@script : Name | desc..."  (no return type)
            parts = [clean(x) for x in rest[1:].split("|")]
            e.name = parts[0]
            if len(parts) >= 2:
                e.desc.append("|".join(parts[1:]).strip())
        else:
            # global form: "@script [type] | Name | desc..."
            parts = [clean(x) for x in rest.split("|")]
            if len(parts) >= 2:
                e.rettype = parts[0]
                e.name = parts[1]
                if len(parts) >= 3:
                    e.desc.append("|".join(parts[2:]).strip())
            elif len(parts) == 1:
                e.name = parts[0]
        e.name = e.name.lstrip(":").strip()   # defensive
        cur_field = "desc"   # where continuation comment lines append
        i += 1
        while i < n:
            line = lines[i]
            tag = TAG_RE.match(line)
            if tag:
                t = tag.group(1).lower(); body = tag.group(2)
                if t == "script":
                    break  # next entry starts
                seg = [clean(x) for x in body.split("|")]
                if t == "parm":
                    typ = seg[0] if len(seg) > 0 else ""
                    nm  = seg[1] if len(seg) > 1 else ""
                    d   = "|".join(seg[2:]).strip() if len(seg) > 2 else ""
                    e.parms.append(("parm", typ, nm, "", d)); cur_field = ("parm", len(e.parms)-1)
                elif t == "parmopt":
                    typ = seg[0] if len(seg) > 0 else ""
                    nm  = seg[1] if len(seg) > 1 else ""
                    dflt= seg[2] if len(seg) > 2 else ""
                    d   = "|".join(seg[3:]).strip() if len(seg) > 3 else ""
                    e.parms.append(("parmopt", typ, nm, dflt, d)); cur_field = ("parm", len(e.parms)-1)
                elif t == "flag":
                    nm = seg[0] if len(seg) > 0 else ""
                    d  = "|".join(seg[1:]).strip() if len(seg) > 1 else ""
                    e.flags.append((nm, d)); cur_field = ("flag", len(e.flags)-1)
                # @uses/@return/@name: ignore for now
                i += 1; continue
            cm = COMMENT_RE.match(line)
            if cm:
                txt = clean(cm.group(1).replace("<nl>", "\n"))
                if txt:
                    if cur_field == "desc":
                        e.desc.append(txt)
                    elif isinstance(cur_field, tuple) and cur_field[0] == "parm":
                        p = list(e.parms[cur_field[1]]); p[4] = (p[4] + " " + txt).strip(); e.parms[cur_field[1]] = tuple(p)
                    elif isinstance(cur_field, tuple) and cur_field[0] == "flag":
                        f = list(e.flags[cur_field[1]]); f[1] = (f[1] + " " + txt).strip(); e.flags[cur_field[1]] = tuple(f)
                i += 1; continue
            # non-comment line: try to grab the C function name, then stop
            fm = FUNC_RE.match(line)
            if fm:
                e.cfunc = (fm.group(1) + "::" if fm.group(1) else "") + fm.group(2)
            # blank line right after annotations is allowed; keep scanning a couple lines for the func sig
            if line.strip() == "":
                i += 1; continue
            break
        if e.name:
            entries.append(e)
    return entries

# --- parse ftables.cpp -------------------------------------------------------
def parse_ftables():
    txt = read_text(FTABLES)
    cfuncs = {}   # name_lower -> (name, cfunc)
    members = []
    mfunc = re.search(r'CFunctionLookupTable\s*\[\]\s*=\s*\{(.*?)\n\};', txt, re.S)
    if mfunc:
        for m in re.finditer(r'\{\s*"([^"]+)"\s*,\s*([^}]+?)\s*\}', mfunc.group(1)):
            nm = m.group(1).strip(); fn = m.group(2).strip()
            cfuncs[nm.lower()] = (nm, fn)
    mmem = re.search(r'ppMemberFunctionNames\s*\[\]\s*=\s*\{(.*?)\n\};', txt, re.S)
    if mmem:
        for m in re.finditer(r'"([^"]+)"', mmem.group(1)):
            members.append(m.group(1))
    return cfuncs, members

# --- index .q scripts for examples -------------------------------------------
def index_examples():
    ex = {}   # name_lower -> example source line
    word = re.compile(r'[A-Za-z_]\w*')
    if not os.path.isdir(SCRIPTS_DIR):
        return ex
    for root, _, files in os.walk(SCRIPTS_DIR):
        for fn in files:
            if not fn.endswith(".q"):
                continue
            try:
                for raw in read_text(os.path.join(root, fn)).splitlines():
                    line = raw.strip()
                    if not line or line.startswith("//"):
                        continue
                    seen = set()
                    for w in word.findall(line):
                        wl = w.lower()
                        if wl in seen:
                            continue
                        seen.add(wl)
                        if wl not in ex and 2 < len(line) < 160:
                            ex[wl] = line
            except Exception:
                pass
    return ex

# --- emit markdown -----------------------------------------------------------
def md_escape(s):
    return s.replace("|", "\\|")

def emit():
    os.makedirs(OUT_DIR, exist_ok=True)
    cfuncs, members = parse_ftables()

    all_entries = []
    for root, _, files in os.walk(CODE):
        for fn in files:
            if not (fn.endswith(".cpp") or fn.endswith(".h")):
                continue
            path = os.path.join(root, fn)
            rel = os.path.relpath(path, SRC_ROOT).replace("\\", "/")
            try:
                txt = read_text(path)
            except Exception:
                continue
            if "@script" not in txt:
                continue
            all_entries.extend(parse_file(path, rel))

    examples = index_examples()

    # dedupe by (name, file, line)
    seen = set(); entries = []
    for e in all_entries:
        k = (e.name.lower(), e.file, e.line)
        if k in seen:
            continue
        seen.add(k); entries.append(e)

    documented = {e.name.lower() for e in entries}

    by_area = defaultdict(list)
    for e in entries:
        by_area[area_for(e.file)].append(e)

    area_order = sorted(by_area.keys())
    page_links = []
    total = 0
    for (slug, title) in area_order:
        es = sorted(by_area[(slug, title)], key=lambda x: x.name.lower())
        total += len(es)
        page_links.append((slug, title, len(es)))
        write_area_page(slug, title, es, cfuncs, examples)

    # undocumented registered cfuncs
    undoc = [(nm, fn) for low, (nm, fn) in sorted(cfuncs.items()) if low not in documented]
    write_undocumented(undoc, members)
    write_index(page_links, total, len(cfuncs), len(members), len(undoc))
    print(f"Wrote {total} documented functions across {len(page_links)} pages; "
          f"{len(undoc)} registered-but-undocumented; {len(members)} member-function names.")

def fmt_entry(e, cfuncs, examples):
    out = []
    out.append(f"### `{e.name}`")
    meta = []
    if e.rettype:
        meta.append(f"returns **{e.rettype}**")
    reg = cfuncs.get(e.name.lower())
    if reg:
        meta.append(f"C: `{reg[1]}`")
    meta.append(f"[`{e.file}:{e.line}`](../../../../kisak-thug/{e.file}#L{e.line})")
    out.append("  \n".join(["_" + " · ".join(meta) + "_"]) if meta else "")
    desc = " ".join(d for d in e.desc if d).replace("<nl>", " ")
    desc = re.sub(r"\s+", " ", desc).strip()
    if desc:
        out.append("")
        out.append(desc)
    if e.parms:
        out.append("")
        out.append("| Param | Type | Req | Default | Description |")
        out.append("|-------|------|-----|---------|-------------|")
        for kind, typ, nm, dflt, d in e.parms:
            req = "yes" if kind == "parm" else "opt"
            out.append(f"| {md_escape(nm or '_(positional)_')} | {md_escape(typ or '')} | {req} | "
                       f"{md_escape(dflt or '')} | {md_escape(d or '')} |")
    if e.flags:
        out.append("")
        out.append("**Flags:** " + ", ".join(f"`{md_escape(nm)}`" + (f" - {md_escape(d)}" if d else "")
                                              for nm, d in e.flags))
    ex = examples.get(e.name.lower())
    if ex:
        out.append("")
        out.append("```")
        out.append(ex)
        out.append("```")
    out.append("")
    return "\n".join(out)

def write_area_page(slug, title, entries, cfuncs, examples):
    lines = [f"# {title}", "",
             f"{len(entries)} documented script commands. "
             "Generated from `@script` autodoc annotations in the source "
             "(see [`tools/gen_script_reference.py`](../../../tools/gen_script_reference.py)).",
             "",
             "Each entry: purpose, parameters (`@parm` required / `@parmopt` optional / `@flag` keyword), "
             "the C function it binds to, a source link, and a real call pulled from the `.q` scripts where one exists.",
             ""]
    # quick alpha index
    lines.append("**Commands:** " + ", ".join(f"[`{e.name}`](#{e.name.lower().replace(' ','-')})" for e in entries))
    lines.append("")
    lines.append("---")
    lines.append("")
    for e in entries:
        lines.append(fmt_entry(e, cfuncs, examples))
    with open(os.path.join(OUT_DIR, slug + ".md"), "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

def write_undocumented(undoc, members):
    lines = ["# Registered but Undocumented", "",
             "Commands present in `CFunctionLookupTable[]` (so callable from script) that have **no** "
             "`@script` annotation in the source. Name -> C function. Behaviour must be read from the C code.",
             "", f"{len(undoc)} commands.", "",
             "| Command | C function |", "|---------|-----------|"]
    for nm, fn in undoc:
        lines.append(f"| `{md_escape(nm)}` | `{md_escape(fn)}` |")
    lines += ["", "---", "",
              "## Member-function names", "",
              "Methods dispatched by object class via the `object:Method` syntax "
              "(`ppMemberFunctionNames[]`). The implementation depends on the receiving object's "
              "component; search `CallMemberFunction` in the relevant component for behaviour.",
              "", f"{len(members)} names.", "", "<sub>"]
    lines.append(", ".join(f"`{md_escape(m)}`" for m in sorted(members, key=str.lower)))
    lines.append("</sub>")
    with open(os.path.join(OUT_DIR, "09-undocumented.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

def write_index(page_links, total, n_cfunc, n_member, n_undoc):
    lines = ["# Script Function Reference", "",
             "Complete catalogue of script-callable commands in this THUG port - their purpose, "
             "parameters, the C function each binds to, and real usage examples.", "",
             "Generated by [`tools/gen_script_reference.py`](../../../tools/gen_script_reference.py) from "
             "the `@script` autodoc annotations, the `CFunctionLookupTable[]` / `ppMemberFunctionNames[]` "
             "tables in [`ftables.cpp`](../../../../kisak-thug/Code/Sk/Scripting/ftables.cpp), and the "
             "`.q` scripts. Re-run it after editing bindings to refresh.", "",
             "See [../README.md](../README.md) for how the scripting engine works end-to-end.", "",
             "## Coverage", "",
             f"- **{n_cfunc}** global commands registered in `CFunctionLookupTable[]` "
             f"({n_cfunc - n_undoc} documented, {n_undoc} not)",
             f"- **{total}** total documented commands catalogued below - the documented global commands "
             "plus component member commands that also carry `@script` docs",
             f"- **{n_undoc}** registered global commands have no annotation - listed in "
             "[09-undocumented.md](09-undocumented.md)",
             f"- **{n_member}** member-function names (`object:Method` dispatch) - listed in "
             "[09-undocumented.md](09-undocumented.md#member-function-names)", "",
             "## Pages", "",
             "| Page | Area | Commands |", "|------|------|----------|"]
    for slug, title, cnt in page_links:
        lines.append(f"| [{slug}.md]({slug}.md) | {title} | {cnt} |")
    lines.append(f"| [09-undocumented.md](09-undocumented.md) | Registered w/o docs + member names | {n_undoc} |")
    lines += ["", "## How to read an entry", "",
              "```",
              "### `CommandName`",
              "_returns bool · C: `Namespace::ScriptCommandName` · source:line_",
              "",
              "<purpose text from @script>",
              "",
              "| Param | Type | Req | Default | Description |   <- from @parm / @parmopt",
              "**Flags:** `keyword` - meaning                  <- from @flag",
              "",
              "<a real call from the .q scripts>",
              "```",
              "",
              "**Req** = `yes` (`@parm`, required) or `opt` (`@parmopt`, optional with a default). "
              "Flags are bare keywords toggled by presence."]
    with open(os.path.join(OUT_DIR, "README.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

if __name__ == "__main__":
    emit()
