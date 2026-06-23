#!/usr/bin/env python3
"""
decompile_thps4.py - decompile every THPS4 .qb under a dir to .q (placed next to the .qb),
verifying each with a QComp round-trip: recompile the .q and compare the normalized token
stream to the THUG-converted original (THPS4 -> THUG via thps4_to_thug/qb.py). Only files
that reproduce identically get a .q written.

  decompile_thps4.py <data_thps4_dir> <qcomp.exe> <verify-dir>
"""
import sys, os, glob
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, 'thps4_to_thug'))
import qdecompile as q
import qbeautify
import decompile_all_levels as B   # reuse norm() and verify()
import qb as t4                    # thps4_to_thug/qb.py


def main():
    data_dir, qcomp, verify_dir = sys.argv[1:4]
    qbs = sorted(glob.glob(os.path.join(data_dir, '**', '*.qb'), recursive=True))
    print('thps4 qb files: %d' % len(qbs))

    placed = failed = 0
    failures = []
    for qb_path in qbs:
        raw = open(qb_path, 'rb').read()
        try:
            text, _ = q.decompile(raw, thps4=True)
            expected = t4.convert_qb(raw)       # THUG-format reference for verification
        except Exception as e:
            failed += 1; failures.append((qb_path, 'decompile/convert exc: %s' % e)); continue
        ok, reason = B.verify(expected, text, qcomp, verify_dir)
        if not ok:
            failed += 1; failures.append((qb_path, reason)); continue
        with open(os.path.splitext(qb_path)[0] + '.q', 'w', encoding='latin-1') as f:
            f.write(qbeautify.beautify(text))
        placed += 1

    print('placed (verified) .q: %d    failed: %d' % (placed, failed))
    for p, r in failures[:50]:
        print('  FAIL %-50s %s' % (os.path.relpath(p, data_dir), r))
    if len(failures) > 50:
        print('  ... and %d more' % (len(failures) - 50))


if __name__ == '__main__':
    sys.exit(main())
