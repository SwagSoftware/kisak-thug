#!/usr/bin/env python3
"""
qdecompile.py - decompile a THUG .qb back to .q source.

Uses the documented token format (docs/scripting-engine/bytecode-and-tokens.md) and the
qb's embedded CHECKSUM_NAME (0x2B) table to recover real names, emitting QComp-dialect .q
(script/endscript, real names, structs/arrays/vectors). Verify a round-trip with QComp:
recompile the .q and compare the core token stream (line numbers + name table stripped).

  qdecompile.py FILE.qb [FILE.q]          # default output: FILE.q next to the qb
  qdecompile.py --thps4 FILE.qb [FILE.q]  # FILE is a THPS4 .qb (converted to THUG first)
"""
import sys, os, struct

# token ids (bytecode-and-tokens.md)
ENDOFFILE=0; ENDOFLINE=1; ENDOFLINENUMBER=2; STARTSTRUCT=3; ENDSTRUCT=4
STARTARRAY=5; ENDARRAY=6; EQUALS=7; DOT=8; COMMA=9; MINUS=10; ADD=11; DIVIDE=12
MULTIPLY=13; OPENPARENTH=14; CLOSEPARENTH=15; DEBUGINFO=16; SAMEAS=17
LESSTHAN=18; LESSTHANEQUAL=19; GREATERTHAN=20; GREATERTHANEQUAL=21
NAME=22; INTEGER=23; HEXINTEGER=24; ENUM=25; FLOAT=26; STRING=27; LOCALSTRING=28
ARRAY=29; VECTOR=30; PAIR=31; KW_BEGIN=32; KW_REPEAT=33; KW_BREAK=34
KW_SCRIPT=35; KW_ENDSCRIPT=36; KW_IF=37; KW_ELSE=38; KW_ELSEIF=39; KW_ENDIF=40
KW_RETURN=41; UNDEFINED=42; CHECKSUM_NAME=43; KW_ALLARGS=44; ARG=45; JUMP=46
KW_RANDOM=47; KW_RANDOM_RANGE=48; AT=49; OR=50; AND=51; XOR=52; SHL=53; SHR=54
KW_RANDOM2=55; KW_RANDOM_RANGE2=56; KW_NOT=57; KW_AND=58; KW_OR=59
KW_SWITCH=60; KW_ENDSWITCH=61; KW_CASE=62; KW_DEFAULT=63
KW_RANDOM_NO_REPEAT=64; KW_RANDOM_PERMUTE=65; COLON=66
RUNTIME_CFUNCTION=67; RUNTIME_MEMBERFUNCTION=68

# simple token -> source text (operators / keywords with no operand)
SIMPLE = {
    STARTSTRUCT:"{", ENDSTRUCT:"}", STARTARRAY:"[", ENDARRAY:"]", EQUALS:"=",
    DOT:".", COMMA:",", MINUS:"-", ADD:"+", DIVIDE:"/", MULTIPLY:"*",
    OPENPARENTH:"(", CLOSEPARENTH:")", SAMEAS:"==", LESSTHAN:"<", LESSTHANEQUAL:"<=",
    GREATERTHAN:">", GREATERTHANEQUAL:">=", OR:"|", AND:"&", XOR:"^",
    SHL:"<<", SHR:">>", COLON:":",
    KW_BEGIN:"begin", KW_REPEAT:"repeat", KW_BREAK:"break", KW_SCRIPT:"script",
    KW_ENDSCRIPT:"endscript", KW_IF:"if", KW_ELSE:"else", KW_ELSEIF:"elseif",
    KW_ENDIF:"endif", KW_RETURN:"return", KW_ALLARGS:"<...>", KW_NOT:"not",
    KW_AND:"and", KW_OR:"or", KW_SWITCH:"switch", KW_ENDSWITCH:"endswitch",
    KW_CASE:"case", KW_DEFAULT:"default", ARRAY:"",
}
RANDOM_KW = {KW_RANDOM:"Random", KW_RANDOM2:"Random2",
             KW_RANDOM_NO_REPEAT:"RandomNoRepeat", KW_RANDOM_PERMUTE:"RandomPermute"}


def u32(d, i): return struct.unpack_from('<I', d, i)[0]
def i32(d, i): return struct.unpack_from('<i', d, i)[0]
def f32(d, i): return struct.unpack_from('<f', d, i)[0]


# THUG2/THUG Pro added "short jump" control-flow tokens (opcode + 2-byte skip), token# > THUG1 max.
# token -> source keyword. Discover more by re-running and inspecting /*tokN*/ in output.
THUG2_SHORTJUMP = {0x47: "if", 0x48: "else", 0x49: "elseif"}


def token_size(d, i):
    """Total bytes of the token at i (opcode + operand)."""
    t = d[i]
    if t in (NAME, INTEGER, HEXINTEGER, ENUM, FLOAT, ENDOFLINENUMBER, JUMP,
             RUNTIME_CFUNCTION, RUNTIME_MEMBERFUNCTION):
        return 5
    if t == VECTOR: return 13
    if t == PAIR: return 9
    if t in (STRING, LOCALSTRING):
        ln = u32(d, i + 1); return 5 + ln
    if t == CHECKSUM_NAME:
        j = i + 5
        while j < len(d) and d[j] != 0: j += 1
        return (j + 1) - i
    if t in (KW_RANDOM, KW_RANDOM2, KW_RANDOM_NO_REPEAT, KW_RANDOM_PERMUTE):
        n = u32(d, i + 1); return 5 + 2 * n + 4 * n
    # THUG2/THUG Pro "short jump" control-flow tokens: opcode + 2-byte skip offset.
    if t in THUG2_SHORTJUMP:
        return 3
    return 1


def value_end(d, pos):
    """End position of ONE value starting at pos (used to bound a 1-item random branch,
    which has no trailing JUMP): <arg>, a balanced {}/[]/() group, or a single token."""
    t = d[pos]
    if t == ARG:                       # ARG + following NAME
        return pos + 1 + token_size(d, pos + 1)
    if t in (STARTSTRUCT, STARTARRAY, OPENPARENTH):
        depth = 0
        p = pos
        while p < len(d):
            tt = d[p]
            if tt in (STARTSTRUCT, STARTARRAY, OPENPARENTH):
                depth += 1
            elif tt in (ENDSTRUCT, ENDARRAY, CLOSEPARENTH):
                depth -= 1
                if depth == 0:
                    return p + 1
            p += token_size(d, p)
        return p
    return pos + token_size(d, pos)


def fmt_float(v):
    r = round(v, 6)
    if r == 0:
        return '0.0'
    s = repr(r)
    if 'e' in s or 'E' in s:           # QComp can't parse scientific notation
        s = ('%.6f' % r).rstrip('0')
        if s.endswith('.'):
            s += '0'
    return s


def build_names(d):
    names = {}
    i = 0
    n = len(d)
    while i < n:
        t = d[i]
        if t == CHECKSUM_NAME:
            ck = u32(d, i + 1)
            j = i + 5
            while j < n and d[j] != 0: j += 1
            nm = d[i + 5:j].decode('latin-1')
            names[ck] = nm
        if t == ENDOFFILE and i != 0:
            # name table can be before or after ENDOFFILE; keep scanning to be safe
            pass
        i += token_size(d, i)
    return names


import re as _re
_IDENT = _re.compile(r'^[A-Za-z_][A-Za-z0-9_]*$')


def name_of(names, ck):
    nm = names.get(ck)
    if nm is None:
        return "#%08x" % ck   # unresolved checksum (rare when table is present)
    if _IDENT.match(nm):
        return nm
    # name isn't a bare identifier (spaces/apostrophe/digit-start): it came from a
    # #"string" checksum literal; emit it that way (recompiles to the same checksum).
    return '#"%s"' % nm


def decompile_range(d, names, start, end):
    """Decompile tokens in [start, end) to .q text (newline-separated statements)."""
    out = []
    line = []

    def flush():
        if line:
            out.append(' '.join(line))
            line.clear()

    i = start
    while i < end:
        t = d[i]
        sz = token_size(d, i)
        if t == ENDOFFILE:
            break
        elif t == CHECKSUM_NAME:
            pass  # name-table entry; not source
        elif t in (ENDOFLINE, ENDOFLINENUMBER):
            flush()
        elif t in (NAME, ENUM):
            line.append(name_of(names, u32(d, i + 1)))
        elif t == INTEGER:
            line.append(str(i32(d, i + 1)))
        elif t == HEXINTEGER:
            line.append("0x%x" % u32(d, i + 1))
        elif t == FLOAT:
            line.append(fmt_float(f32(d, i + 1)))
        elif t == STRING:
            ln = u32(d, i + 1)
            s = d[i + 5:i + 5 + ln].rstrip(b'\0').decode('latin-1')
            line.append('"%s"' % s.replace('\\', '\\\\').replace('"', '\\"'))
        elif t == LOCALSTRING:
            ln = u32(d, i + 1)
            s = d[i + 5:i + 5 + ln].rstrip(b'\0').decode('latin-1')
            line.append("'%s'" % s.replace('\\', '\\\\').replace("'", "\\'"))
        elif t == VECTOR:
            line.append("(%s, %s, %s)" % (fmt_float(f32(d, i + 1)),
                        fmt_float(f32(d, i + 5)), fmt_float(f32(d, i + 9))))
        elif t == PAIR:
            line.append("(%s, %s)" % (fmt_float(f32(d, i + 1)), fmt_float(f32(d, i + 5))))
        elif t == ARG:
            if d[i + 1] == NAME:
                line.append("<%s>" % name_of(names, u32(d, i + 2)))
                i += 1 + 5
                continue
            line.append("<")
        elif t in RANDOM_KW:
            n = u32(d, i + 1)
            weights = [struct.unpack_from('<H', d, i + 5 + 2 * k)[0] for k in range(n)]
            offsets = [u32(d, i + 5 + 2 * n + 4 * k) for k in range(n)]
            starts = [i + 9 + 2 * n + 4 * k + offsets[k] for k in range(n)]
            if n >= 2:
                jp = starts[1] - 5                      # branch 0's trailing JUMP
                cend = jp + 5 + i32(d, jp + 1)
            else:
                cend = value_end(d, starts[0])          # 1 item: no jump, consume one value
            branch_texts = []
            for k in range(n):
                bs = starts[k]
                be = (starts[k + 1] - 5) if k < n - 1 else cend
                branch_texts.append(decompile_range(d, names, bs, be).strip('\n'))
            ws = ['' if weights[k] == 1 else '*%d' % weights[k] for k in range(n)]
            if any('\n' in bt for bt in branch_texts):
                # block form: an item spans multiple statements (begin/if/etc. must stay
                # first-on-line), so keep the newlines instead of flattening.
                line.append('%s (' % RANDOM_KW[t])
                flush()
                for k, bt in enumerate(branch_texts):
                    out.append('@%s' % ws[k])   # marker on its own line so a leading
                    out.extend(bt.split('\n'))  # begin/if/etc. stays first-on-line
                out.append(')')
            else:
                items = ['@%s %s' % (ws[k], branch_texts[k]) for k in range(n)]
                line.append('%s ( %s )' % (RANDOM_KW[t], ' '.join(items)))
            i = cend
            continue
        elif t in (KW_RANDOM_RANGE, KW_RANDOM_RANGE2):
            line.append("RandomRange" if t == KW_RANDOM_RANGE else "RandomRange2")
        elif t == JUMP:
            pass  # control-flow artifact; not source
        elif t == AT:
            pass
        elif t in SIMPLE:
            line.append(SIMPLE[t])
        elif t in (RUNTIME_CFUNCTION, RUNTIME_MEMBERFUNCTION):
            line.append(name_of(names, u32(d, i + 1)))
        elif t in THUG2_SHORTJUMP:
            flush()
            line.append(THUG2_SHORTJUMP[t])
        else:
            line.append("/*tok%d*/" % t)
        i += sz
    flush()
    return '\n'.join(out)


def _convert_thps4(d):
    # THPS4 qb is identical to THUG except the random family has no weight array
    # (uniform pick). thps4_to_thug/qb.py's convert_qb inserts weight=1 bytes, yielding a
    # THUG-format stream the rest of this decompiler handles unchanged.
    import os
    t4dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'thps4_to_thug')
    if t4dir not in sys.path:
        sys.path.insert(0, t4dir)
    import qb as _t4qb
    return _t4qb.convert_qb(bytes(d))


def decompile(d, thps4=False):
    if thps4:
        d = _convert_thps4(d)
    names = build_names(d)
    return decompile_range(d, names, 0, len(d)) + '\n', names


def main():
    args = [a for a in sys.argv[1:] if a != '--thps4']
    thps4 = '--thps4' in sys.argv[1:]
    if not args:
        print(__doc__); return 1
    inp = args[0]
    outp = args[1] if len(args) > 1 else os.path.splitext(inp)[0] + ".q"
    d = open(inp, 'rb').read()
    text, names = decompile(d, thps4=thps4)
    with open(outp, 'w', encoding='latin-1') as f:
        f.write(text)
    print("decompiled %s -> %s  (%d names, %d lines%s)" %
          (os.path.basename(inp), outp, len(names), text.count('\n'),
           ", thps4" if thps4 else ""))
    return 0


if __name__ == '__main__':
    sys.exit(main())
