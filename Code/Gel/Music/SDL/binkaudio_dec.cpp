// Bink Audio (DCT variant) decoder - see binkaudio_dec.h.
// Ported from FFmpeg's binkaudio.c and verified bit-exact against ffmpeg
// (kisak-thug-claude/tools/bink/bink_decode.py reproduces this exactly).

#include "binkaudio_dec.h"
#include <cmath>
#include <cstring>
#include <algorithm>

namespace Pcm
{

// WMA critical frequencies (ff_wma_critical_freqs).
static const int kWmaCriticalFreqs[25] = {
	100,200,300,400,510,630,770,920,1080,1270,1480,1720,2000,2320,2700,
	3150,3700,4400,5300,6400,7700,9500,12000,15500,100000
};
static const uint8_t kRleLen[16] = { 2,3,4,5,6,8,9,10,11,12,13,14,15,16,32,64 };

static inline uint32_t rd_le32(const uint8_t *p) {
	return (uint32_t)p[0] | ((uint32_t)p[1]<<8) | ((uint32_t)p[2]<<16) | ((uint32_t)p[3]<<24);
}
static inline uint16_t rd_le16(const uint8_t *p) {
	return (uint16_t)(p[0] | (p[1]<<8));
}

// ---------------------------------------------------------------- bit reader
void BinkAudioDecoder::open_packet(size_t i)
{
	m_bits = m_data + m_pkts[i].off;
	m_bit_nbits = m_pkts[i].len * 8;
	m_bit_pos = 0;
	m_pkt_open = true;
}

uint32_t BinkAudioDecoder::read_bits(int n)
{
	uint32_t v = 0;
	for (int b = 0; b < n; b++)
	{
		size_t p = m_bit_pos++;
		if (p >= m_bit_nbits) continue;            // past end -> zero bits (defensive)
		uint32_t bit = (m_bits[p >> 3] >> (p & 7)) & 1;   // LSB-first
		v |= bit << b;
	}
	return v;
}

void BinkAudioDecoder::align32()
{
	size_t n = (-(int64_t)m_bit_pos) & 31;
	m_bit_pos += n;
}

float BinkAudioDecoder::read_float()
{
	int power = (int)read_bits(5);
	float f = ldexpf((float)read_bits(23), power - 23);
	if (read_bit()) f = -f;
	return f;
}

// ----------------------------------------------------------------- demux
BinkAudioDecoder::BinkAudioDecoder(const uint8_t *data, size_t size)
	: m_data(data), m_size(size)
{
	if (!data || size < 48) return;
	if (data[0] != 'B' || data[1] != 'I' || data[2] != 'K') return;

	uint32_t num_frames = rd_le32(data + 8);
	uint32_t num_tracks = rd_le32(data + 40);
	if (num_tracks < 1) return;

	size_t pos = 44;
	pos += 4 * num_tracks;                 // max packet sizes
	if (pos + 4 > size) return;
	m_sample_rate = rd_le16(data + pos);
	uint16_t flags = rd_le16(data + pos + 2);
	pos += 4 * num_tracks;                 // audio headers (sr,flags) per track
	pos += 4 * num_tracks;                 // track ids

	m_channels = (flags & 0x2000) ? 2 : 1;
	m_use_dct  = (flags & 0x1000) != 0;

	// Supported: DCT variant, mono (pcm.wad voice) or stereo (retail .bik music).
	if ((m_channels != 1 && m_channels != 2) || !m_use_dct) return;

	// frame offset table: num_frames+1 little-endian uint32 (low bit = keyframe)
	if (pos + 4 * (size_t)(num_frames + 1) > size) return;
	std::vector<size_t> offs(num_frames + 1);
	for (uint32_t i = 0; i <= num_frames; i++)
		offs[i] = rd_le32(data + pos + 4 * i) & ~1u;

	// per frame: uint32 audio_size, then audio_size bytes = audio packet
	for (uint32_t i = 0; i < num_frames; i++)
	{
		size_t fstart = offs[i];
		if (fstart + 4 > size) break;
		uint32_t audio_size = rd_le32(data + fstart);
		if (audio_size >= 4 && fstart + 4 + audio_size <= size)
			m_pkts.push_back({ fstart + 4, audio_size });
	}

	init_decoder();
	m_valid = !m_pkts.empty();
}

void BinkAudioDecoder::init_decoder()
{
	int frame_len_bits = (m_sample_rate < 22050) ? 9 : (m_sample_rate < 44100) ? 10 : 11;
	m_frame_len   = 1 << frame_len_bits;
	m_overlap_len = m_frame_len / 16;
	int srh = (m_sample_rate + 1) / 2;
	m_root = (float)m_frame_len / (sqrtf((float)m_frame_len) * 32768.0f);
	for (int i = 0; i < 96; i++)
		m_quant_table[i] = expf(i * 0.15289164787221953823f) * m_root;

	int nb = 1;
	while (nb < 25 && srh > kWmaCriticalFreqs[nb - 1]) nb++;
	m_num_bands = nb;
	m_bands[0] = 2;
	for (int i = 1; i < nb; i++)
		m_bands[i] = (unsigned)((kWmaCriticalFreqs[i - 1] * m_frame_len / srh) & ~1);
	m_bands[nb] = m_frame_len;

	m_previous.assign((size_t)m_overlap_len * m_channels, 0.0f);
	m_coeffs.assign(m_frame_len + 2, 0.0f);
	m_timebuf.assign((size_t)m_frame_len * m_channels, 0.0f);
	m_first = true;

	// Fast IDCT setup: a 2N-point FFT.
	const double PI = 3.14159265358979323846;
	const int N = m_frame_len;
	m_M = 2 * N;
	int M = m_M;

	// bit-reversal permutation for radix-2
	int logM = 0; while ((1 << logM) < M) logM++;
	m_brev.resize(M);
	for (int i = 0; i < M; i++)
	{
		int r = 0;
		for (int b = 0; b < logM; b++) if (i & (1 << b)) r |= 1 << (logM - 1 - b);
		m_brev[i] = r;
	}
	// FFT twiddles: exp(i 2pi t / M) (positive kernel)
	m_tw_r.resize(M / 2); m_tw_i.resize(M / 2);
	for (int t = 0; t < M / 2; t++)
	{
		m_tw_r[t] = (float)cos(2.0 * PI * t / M);
		m_tw_i[t] = (float)sin(2.0 * PI * t / M);
	}
	// pre-rotation: exp(i pi k / M), k in [0,N)
	m_pre_r.resize(N); m_pre_i.resize(N);
	for (int k = 0; k < N; k++)
	{
		m_pre_r[k] = (float)cos(PI * k / M);
		m_pre_i[k] = (float)sin(PI * k / M);
	}
	m_fr.assign(M, 0.0f); m_fi.assign(M, 0.0f);
}

// In-place radix-2 DIT FFT, kernel exp(+i 2pi/M) (no 1/M scaling).
void BinkAudioDecoder::fft_pos(float *re, float *im)
{
	const int M = m_M;
	for (int i = 0; i < M; i++)
	{
		int j = m_brev[i];
		if (i < j) { std::swap(re[i], re[j]); std::swap(im[i], im[j]); }
	}
	for (int len = 2; len <= M; len <<= 1)
	{
		int half = len >> 1;
		int step = M / len;
		for (int i = 0; i < M; i += len)
			for (int k = 0; k < half; k++)
			{
				int t = k * step;
				float wr = m_tw_r[t], wi = m_tw_i[t];
				int a = i + k, b = i + k + half;
				float vr = re[b] * wr - im[b] * wi;
				float vi = re[b] * wi + im[b] * wr;
				re[b] = re[a] - vr; im[b] = im[a] - vi;
				re[a] += vr;        im[a] += vi;
			}
	}
}

// Decode one block of m_frame_len samples, overlap-add, emit first (frame_len-
// overlap_len) samples into out. Returns false at end of stream.
bool BinkAudioDecoder::decode_one_block(float *out)
{
	// Ensure a packet with enough bits for another block is open.
	for (;;)
	{
		if (m_pkt_open)
		{
			align32();
			if (bits_left() >= 64) break;
		}
		if (m_pkt_index >= m_pkts.size()) return false;
		open_packet(m_pkt_index++);
		read_bits(32);                 // skip reported size at packet start
	}

	const int N  = m_frame_len;
	const int ov = m_overlap_len;
	const int CH = m_channels;
	const bool firstBlock = m_first;
	float *c = m_coeffs.data();

	read_bits(2);                      // DCT variant: skip 2 bits (once per block)

	// Stereo blocks carry both channels back-to-back in the same packet: parse and
	// transform channel 0 fully, then channel 1, then interleave on output.
	for (int ch = 0; ch < CH; ch++)
	{
		c[0] = read_float() * m_root;
		c[1] = read_float() * m_root;

		float quant[25];
		for (int b = 0; b < m_num_bands; b++)
		{
			int v = (int)read_bits(8);
			quant[b] = m_quant_table[v < 95 ? v : 95];
		}

		// Parse coefficients (RLE of bit-widths, per-band quantiser).
		int k = 0; float q = quant[0]; int i = 2;
		while (i < N)
		{
			int j;
			if (read_bit()) j = i + kRleLen[read_bits(4)] * 8;
			else            j = i + 8;
			if (j > N) j = N;
			int width = (int)read_bits(4);
			if (width == 0)
			{
				memset(c + i, 0, (size_t)(j - i) * sizeof(float));
				i = j;
				while ((int)m_bands[k] < i) q = quant[k++];
			}
			else
			{
				while (i < j)
				{
					if ((int)m_bands[k] == i) q = quant[k++];
					int coeff = (int)read_bits(width);
					if (coeff) c[i] = read_bit() ? (-q * coeff) : (q * coeff);
					else       c[i] = 0.0f;
					i++;
				}
			}
		}

		// Inverse DCT-III via a 2N-point FFT. Derived directly from the verified formula
		//   time[n] = (2/N) * ( c[0] + sum_{k>=1} c[k] cos(pi/N*(n+0.5)*k) )
		//           = (2/N) * Re( sum_{k=0}^{N-1} c[k] exp(i*pi*k/M) * exp(i*2pi*n*k/M) ),  M=2N
		// i.e. the first N outputs of a 2N-point (positive-kernel) FFT of the pre-rotated coeffs.
		const int M = m_M;
		float *fr = m_fr.data(), *fi = m_fi.data();
		for (int b = 0; b < N; b++)
		{
			float cb = c[b];
			fr[b] = cb * m_pre_r[b];
			fi[b] = cb * m_pre_i[b];
		}
		memset(fr + N, 0, (size_t)(M - N) * sizeof(float));
		memset(fi + N, 0, (size_t)(M - N) * sizeof(float));
		fft_pos(fr, fi);

		const float scale = 2.0f / (float)N;
		float *t = m_timebuf.data() + (size_t)ch * N;   // this channel's frame
		for (int n = 0; n < N; n++)
			t[n] = fr[n] * scale;

		// Overlap-add with this channel's previous tail; save its new tail.
		float *prev = m_previous.data() + (size_t)ch * ov;
		if (!firstBlock)
			for (int x = 0; x < ov; x++)
				t[x] = (prev[x] * (ov - x) + t[x] * x) / (float)ov;
		for (int x = 0; x < ov; x++)
			prev[x] = t[N - ov + x];
	}

	m_first = false;

	// Emit the first (N-ov) frames, interleaving channels (L,R for stereo).
	const int frames = N - ov;
	for (int n = 0; n < frames; n++)
		for (int ch = 0; ch < CH; ch++)
			out[n * CH + ch] = m_timebuf[(size_t)ch * N + n];

	return true;
}

size_t BinkAudioDecoder::DecodeBlock(float *out)
{
	if (!m_valid) return 0;
	if (!decode_one_block(out)) return 0;
	return BlockSamples();
}

}
