#!/usr/bin/env python3
# Extract one member from a .PRE into the loose Data tree.
#   extract_pre_file.py <pre> <member-suffix> <data-root>
# e.g. extract_pre_file.py build/Debug/Data/pre/NJ.pre nj_scripts.qb build/Debug/Data
import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..', 'kisak-thug', 'build', 'dx9_audit', 'memcard'))
import unpre

BS = chr(92)  # backslash


def main():
    pre, suffix, data_root = sys.argv[1], sys.argv[2].lower(), sys.argv[3]
    files = unpre.extract(pre)
    print('QB files in %s:' % os.path.basename(pre))
    for k in files:
        if k.lower().endswith('.qb'):
            print('  %8d  %s' % (len(files[k]), k))
    target = next((k for k in files if k.lower().endswith(suffix)), None)
    if not target:
        print('NOT FOUND:', suffix)
        return 1
    outp = os.path.join(data_root, target.replace(BS, os.sep))
    os.makedirs(os.path.dirname(outp), exist_ok=True)
    with open(outp, 'wb') as o:
        o.write(files[target])
    print('EXTRACTED -> %s (%d bytes)' % (outp, len(files[target])))
    return 0


if __name__ == '__main__':
    sys.exit(main())
