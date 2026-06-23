#!/usr/bin/env python3
"""Extract a THUG/THUG2/THUG Pro .pre/.prx archive (CURRENT_PRE_VERSION 0xabcd0003).
Header(12): total_size(u32), version(u32), num_entries(u32).
Per entry (PRE_NAME_OFFSET=16): data_size(int@0), compressed_data_size(int@4),
  text_size(SHORT@8), [2 pad], checksum(int@12), name(text_size@16), data(actual_data_size).
  actual_data_size = compressed_data_size if !=0 else data_size (==0 means UNCOMPRESSED, raw).
  next entry = +16 + text_size + ((actual_data_size+3)&~3).
Compressed data is Neversoft LZSS (4096 ring, 12-bit offset, 4-bit len, THRESHOLD 2).
  prx_extract.py <file.prx> <outdir>
"""
import sys, struct, os
BS = chr(92)

def decode_lzss(data, out_len):
    RING = 4096; THRESH = 2
    tb = [0x20] * RING
    r = RING - 18
    out = bytearray()
    flags = 0; ip = 0; Len = len(data)
    while True:
        flags >>= 1
        if (flags & 256) == 0:
            if Len == 0: break
            Len -= 1; c = data[ip]; ip += 1; flags = c | 0xff00
        if flags & 1:
            if Len == 0: break
            Len -= 1; c = data[ip]; ip += 1
            out.append(c); tb[r] = c; r = (r + 1) & (RING - 1)
        else:
            if Len == 0: break
            Len -= 1; i = data[ip]; ip += 1
            if Len == 0: break
            Len -= 1; j = data[ip]; ip += 1
            i |= (j & 0xf0) << 4
            jj = (j & 0x0f) + THRESH
            for k in range(jj + 1):
                c = tb[(i + k) & (RING - 1)]
                out.append(c); tb[r] = c; r = (r + 1) & (RING - 1)
        if out_len and len(out) >= out_len: break
    return bytes(out[:out_len]) if out_len else bytes(out)

def extract(path, outdir):
    d = open(path, 'rb').read()
    total, ver, nfiles = struct.unpack_from('<III', d, 0)
    print("total=%d ver=%08x nfiles=%d" % (total, ver, nfiles))
    o = 12; got = 0
    for n in range(nfiles):
        if o + 16 > len(d): print("  EOF at entry %d" % n); break
        data_size, comp_size = struct.unpack_from('<II', d, o)
        text_size = struct.unpack_from('<H', d, o + 8)[0]
        name = d[o + 16:o + 16 + text_size].split(b'\x00')[0].decode('latin-1', 'replace')
        actual = comp_size if comp_size != 0 else data_size
        ds = o + 16 + text_size
        data = d[ds:ds + actual]
        raw = decode_lzss(data, data_size) if comp_size != 0 else data
        safe = name.replace(BS, '/')
        if safe and all(32 <= ord(ch) < 127 or ch in './_-' for ch in safe):
            outp = os.path.join(outdir, safe)
            os.makedirs(os.path.dirname(outp), exist_ok=True)
            open(outp, 'wb').write(raw)
            got += 1
        else:
            print("  [!] entry %d off=%d bad name %r (skipping)" % (n, o, name[:40]))
        o = ds + ((actual + 3) & ~3)
    print("extracted %d/%d, final off=%d (filesize=%d)" % (got, nfiles, o, len(d)))

if __name__ == '__main__':
    extract(sys.argv[1], sys.argv[2])
