#!/usr/bin/env python3
# Count CHECKSUM_NAME (0x2B) records in a .qb (the documented appended name table).
# Format per bytecode-and-tokens.md: 0x2B + 4-byte checksum + NUL-terminated name.
import sys, struct, re


def probe(path):
    d = open(path, 'rb').read()
    n = len(d)
    i = 0
    names = {}
    while i < n:
        if d[i] == 0x2B and i + 5 < n:
            ck = struct.unpack_from('<I', d, i + 1)[0]
            j = i + 5
            while j < n and d[j] != 0:
                j += 1
            name = d[i + 5:j]
            if name and re.match(rb'^[\x20-\x7e]+$', name):
                names[ck] = name.decode('latin-1')
                i = j + 1
                continue
        i += 1
    return names


for path in sys.argv[1:]:
    names = probe(path)
    print('%-60s  CHECKSUM_NAME records: %d' % (path, len(names)))
    for ck, nm in list(names.items())[:6]:
        print('    0x%08x = %s' % (ck, nm))
