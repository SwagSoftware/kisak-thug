#!/usr/bin/env python3
"""
qbeautify.py - re-indent THUG QB script (.q / .qn) source.

ONLY leading whitespace is rewritten. Everything after the leading whitespace on
each line is preserved byte-for-byte, so the compiled output is unchanged (the QB
language is whitespace-insensitive). Verify with:  diff -w original beautified
(must be empty).

Indentation follows the block structure:
  script/endscript, if/else/elseif/endif, switch/case/default/endswitch,
  begin/repeat, and data brackets { } [ ] ( ) that span lines.

Control-flow keywords are only treated as such at statement level (outside any
{ } [ ] ( ) data context), so a bareword like `default` inside an array literal
is left alone. Interiors of /* ... */ block comments are preserved verbatim.

Usage:
  qbeautify.py FILE [FILE ...]          # rewrite in place
  qbeautify.py --stdout FILE            # write result to stdout, don't touch file
  qbeautify.py --indent='    ' FILE     # use a custom indent unit (default: one tab)
"""
import sys
import re

INDENT_UNIT = "\t"

OPENERS = {"script", "if", "begin", "switch"}
ENDERS  = {"endscript", "endif", "endswitch", "repeat"}
MIDS    = {"else", "elseif"}
CASES   = {"case", "default"}

_word_re = re.compile(r"[A-Za-z_]\w*")


def strip_line(line, in_block):
    """Return (analysis_text, new_in_block).

    analysis_text has string and comment contents removed but keeps the
    structural characters { } [ ] ( ) so they can be counted.
    """
    out = []
    i, n = 0, len(line)
    while i < n:
        c = line[i]
        if in_block:
            j = line.find("*/", i)
            if j == -1:
                i = n
            else:
                in_block = False
                i = j + 2
            continue
        if c == "/" and i + 1 < n and line[i + 1] == "*":
            in_block = True
            i += 2
            continue
        if c == "/" and i + 1 < n and line[i + 1] == "/":
            break          # // line comment
        if c == ";":
            break          # ; line comment
        if c == '"' or c == "'":
            q = c
            i += 1
            while i < n:
                if line[i] == "\\" and i + 1 < n:
                    i += 2
                    continue
                if line[i] == q:
                    i += 1
                    break
                i += 1
            out.append('""')   # placeholder; no structural chars inside
            continue
        out.append(c)
        i += 1
    return "".join(out), in_block


def first_word(code):
    s = code.lstrip()
    m = _word_re.match(s)
    return m.group(0).lower() if m else None


def leading_close_brackets(code):
    count = 0
    for ch in code.lstrip():
        if ch in "}])":
            count += 1
        elif ch.isspace():
            continue
        else:
            break
    return count


def beautify(text, indent_unit=INDENT_UNIT):
    lines = text.split("\n")
    out = []
    kw_stack = []        # 'script' | 'if' | 'begin' | 'switch' | 'case'
    bracket_depth = 0
    in_block = False

    for raw in lines:
        line = raw.rstrip()                      # drop trailing ws / \r
        was_in_block = in_block
        code, in_block = strip_line(line, was_in_block)

        # Preserve the interior of /* ... */ comments exactly as-is.
        if was_in_block:
            out.append(line)
            continue

        if line.strip() == "":
            out.append("")
            continue

        depth_before = len(kw_stack) + bracket_depth

        kw_lead = 0
        lead_brk = leading_close_brackets(code)

        # Control-flow keywords only act at statement level (no open data brackets).
        fw = first_word(code) if bracket_depth == 0 else None

        if fw in ENDERS:
            if fw == "endswitch":
                if kw_stack and kw_stack[-1] == "case":
                    kw_stack.pop()
                    kw_lead += 1
                if kw_stack and kw_stack[-1] == "switch":
                    kw_stack.pop()
                kw_lead += 1
            elif fw == "endscript":
                # pop down to and including the nearest 'script'
                popped = 0
                while kw_stack:
                    top = kw_stack.pop()
                    popped += 1
                    if top == "script":
                        break
                kw_lead += popped
            else:  # endif / repeat
                want = "if" if fw == "endif" else "begin"
                if kw_stack and kw_stack[-1] == want:
                    kw_stack.pop()
                kw_lead += 1
        elif fw in MIDS:
            kw_lead += 1                          # dedent the else/elseif line only
        elif fw in CASES:
            if kw_stack and kw_stack[-1] == "case":
                kw_stack.pop()
                kw_lead += 1

        indent = depth_before - kw_lead - lead_brk
        if indent < 0:
            indent = 0
        out.append(indent_unit * indent + line.lstrip())

        # Apply openers (after emitting this line).
        if fw in OPENERS:
            kw_stack.append(fw)
        elif fw in CASES:
            kw_stack.append("case")

        bracket_depth += code.count("{") + code.count("[") + code.count("(")
        bracket_depth -= code.count("}") + code.count("]") + code.count(")")
        if bracket_depth < 0:
            bracket_depth = 0

    result = "\n".join(out)
    if text.endswith("\n") and not result.endswith("\n"):
        result += "\n"
    return result


def main(argv):
    args = argv[1:]
    to_stdout = False
    indent_unit = INDENT_UNIT
    files = []
    for a in args:
        if a == "--stdout":
            to_stdout = True
        elif a.startswith("--indent="):
            indent_unit = a.split("=", 1)[1]
        else:
            files.append(a)
    if not files:
        print(__doc__)
        return 1
    for path in files:
        with open(path, "r", encoding="latin-1", newline="") as f:
            text = f.read()
        # normalize CRLF -> LF for analysis, remember if we had CRLF
        crlf = "\r\n" in text
        text = text.replace("\r\n", "\n")
        result = beautify(text, indent_unit)
        if crlf:
            result = result.replace("\n", "\r\n")
        if to_stdout:
            sys.stdout.write(result)
        else:
            with open(path, "w", encoding="latin-1", newline="") as f:
                f.write(result)
            print(f"beautified {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
