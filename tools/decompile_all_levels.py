#!/usr/bin/env python3
"""
decompile_all_levels.py - extract every Levels\\ and Models\\ .qb from the level PREs,
decompile each to .q, VERIFY via a QComp round-trip (recompile + compare normalized token
streams), and only place the .q next to the .qb when it reproduces identically.

  decompile_all_levels.py <pre-dir> <data-root> <qcomp.exe> <verify-dir>
"""
import sys, os, glob, struct, subprocess, shutil
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, '..', '..', 'kisak-thug', 'build', 'dx9_audit', 'memcard'))
import unpre, qdecompile as q, qbeautify

BS = chr(92)


def norm(d):
    """Normalized meaningful-token list: ignores line numbers, name table, and
    layout-dependent offsets so two faithful compiles compare equal."""
    i, out, n = 0, [], len(d)
    while i < n:
        t = d[i]; sz = q.token_size(d, i)
        if t == q.ENDOFFILE: break
        if t in (1, 2, 16, 43): i += sz; continue
        if t in (q.NAME, q.ENUM): out.append((22, q.u32(d, i + 1)))
        elif t == q.INTEGER: out.append((23, q.i32(d, i + 1)))
        elif t == q.HEXINTEGER: out.append((24, q.u32(d, i + 1)))
        elif t == q.FLOAT: out.append((26, round(q.f32(d, i + 1), 3)))
        elif t in (q.STRING, q.LOCALSTRING): out.append((t, d[i + 5:i + 5 + q.u32(d, i + 1)]))
        elif t == q.VECTOR: out.append((30, tuple(round(q.f32(d, i + 1 + 4 * k), 3) for k in range(3))))
        elif t == q.PAIR: out.append((31, tuple(round(q.f32(d, i + 1 + 4 * k), 3) for k in range(2))))
        elif t in q.RANDOM_KW: out.append((t, q.u32(d, i + 1)))
        elif t == q.JUMP: out.append(('J',))
        else: out.append((t,))
        i += sz
    return out


def verify(orig_qb_bytes, q_text, qcomp, verify_dir):
    """Recompile q_text with QComp and compare to orig. Returns (ok, reason)."""
    sdir = os.path.join(verify_dir, 'scripts')
    os.makedirs(sdir, exist_ok=True)
    src = os.path.join(sdir, 'v.q')
    out_qb = os.path.join(sdir, 'v.qb')
    if os.path.exists(out_qb):
        os.remove(out_qb)
    with open(src, 'w', encoding='latin-1') as f:
        f.write(q_text)
    env = dict(os.environ, PROJ_ROOT=os.path.abspath(verify_dir))
    try:
        subprocess.run([qcomp, '-nomessageboxes', 'scripts/v.q'], cwd=verify_dir,
                       env=env, capture_output=True, timeout=120)
    except Exception as e:
        return False, 'qcomp exc: %s' % e
    if not os.path.exists(out_qb):
        return False, 'qcomp produced no qb (parse error)'
    if norm(orig_qb_bytes) == norm(open(out_qb, 'rb').read()):
        return True, ''
    return False, 'token stream mismatch'


def extract_qb_members(pre):
    """Parse a .pre and LZSS-decompress ONLY the Levels\\/Models\\ .qb members
    (skips scene/pcm/collision payloads for speed)."""
    d = open(pre, 'rb').read()
    ver = struct.unpack_from('<I', d, 4)[0]
    if ver != 0xabcd0003:
        return {}
    num = struct.unpack_from('<I', d, 8)[0]
    off = 12
    found = {}
    for _ in range(num):
        dataSize = struct.unpack_from('<I', d, off)[0]
        compSize = struct.unpack_from('<I', d, off + 4)[0]
        nameSize = struct.unpack_from('<I', d, off + 8)[0] & 0xffff
        nameOff = off + 16
        dataOff = nameOff + nameSize
        actual = compSize if compSize else dataSize
        name = d[nameOff:nameOff + nameSize].split(b'\0')[0].decode('latin-1')
        kl = name.lower()
        if kl.endswith('.qb') and (kl.startswith('levels' + BS) or kl.startswith('models' + BS)):
            blob = d[dataOff:dataOff + actual]
            found[name] = unpre.lzss(blob, dataSize) if compSize else blob
        off = dataOff + ((actual + 3) & ~3)
    return found


def main():
    pre_dir, data_root, qcomp, verify_dir = sys.argv[1:5]
    # gather distinct Levels\/Models\ .qb members across all pres
    members = {}  # rel_path -> bytes
    for pre in sorted(glob.glob(os.path.join(pre_dir, '*.pre'))):
        try:
            for k, v in extract_qb_members(pre).items():
                members.setdefault(k, v)
        except Exception:
            continue
    print('distinct level/model qb members: %d' % len(members))

    placed = failed = 0
    failures = []
    for rel, data in sorted(members.items()):
        qb_path = os.path.join(data_root, rel.replace(BS, os.sep))
        os.makedirs(os.path.dirname(qb_path), exist_ok=True)
        with open(qb_path, 'wb') as f:        # place the loose .qb
            f.write(data)
        try:
            text, _ = q.decompile(data)
        except Exception as e:
            failed += 1; failures.append((rel, 'decompile exc: %s' % e)); continue
        ok, reason = verify(data, text, qcomp, verify_dir)
        if not ok:
            failed += 1; failures.append((rel, reason)); continue
        q_path = os.path.splitext(qb_path)[0] + '.q'
        with open(q_path, 'w', encoding='latin-1') as f:
            f.write(qbeautify.beautify(text))
        placed += 1
    print('placed (verified) .q: %d    failed: %d' % (placed, failed))
    for rel, reason in failures[:40]:
        print('  FAIL %-45s %s' % (rel, reason))
    if len(failures) > 40:
        print('  ... and %d more' % (len(failures) - 40))


if __name__ == '__main__':
    sys.exit(main())
