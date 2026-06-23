#!/usr/bin/env python3
# Extract every .qb member from every .pre in Data/pre/ into the loose Data tree,
# placing each <name>.qb at its original relative path under <data-root>.
#   extract_all_level_qb.py <pre-dir> <data-root>
import sys, os, glob
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..', 'kisak-thug', 'build', 'dx9_audit', 'memcard'))
import unpre

BS = chr(92)


def main():
    pre_dir, data_root = sys.argv[1], sys.argv[2]
    total_qb = 0
    pres_with_qb = 0
    for pre in sorted(glob.glob(os.path.join(pre_dir, '*.pre'))):
        try:
            files = unpre.extract(pre)
        except Exception as e:
            print('SKIP %s (%s)' % (os.path.basename(pre), e))
            continue
        qbs = [k for k in files if k.lower().endswith('.qb')]
        if not qbs:
            continue
        pres_with_qb += 1
        for k in qbs:
            outp = os.path.join(data_root, k.replace(BS, os.sep))
            os.makedirs(os.path.dirname(outp), exist_ok=True)
            with open(outp, 'wb') as o:
                o.write(files[k])
            total_qb += 1
    print('pres with qb: %d   qb files extracted: %d' % (pres_with_qb, total_qb))


if __name__ == '__main__':
    sys.exit(main())
