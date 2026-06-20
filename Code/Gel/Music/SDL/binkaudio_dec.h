#ifndef __GEL_MUSIC_SDL_BINKAUDIO_DEC_H
#define __GEL_MUSIC_SDL_BINKAUDIO_DEC_H

// Self-contained Bink Audio (DCT variant) decoder.
//
// THUG PC stores streamed speech/voice clips as mono 44100Hz Bink-audio files
// concatenated in Data/streams/pcm/pcm.wad (indexed by pcm.dat). The SDL audio
// backend has no Bink support, so those streams (skater bail/hurt voices, etc.)
// never played. This decodes one Bink-audio block at a time so the stream layer
// can resample/upmix it like any other source.
//
// The stock retail music is the same codec: stereo 48000Hz Bink-audio .bik files
// in Data/streams/music (flags=0x7000 = STEREO|16BITS|USEDCT). So this decoder
// supports 1 or 2 channels; stereo channels are decoded sequentially within a
// block and interleaved on output.
//
// Algorithm ported from FFmpeg's binkaudio.c (DCT path) and verified bit-exact
// against `ffmpeg -acodec binkaudio_dct` (see kisak-thug-claude/tools/bink/).
// Scope: mono/stereo, DCT variant (USEDCT). RDFT variant is not supported.

#include <cstdint>
#include <cstddef>
#include <cstdlib>
#include <new>
#include <vector>

namespace Pcm
{

// The global operator new is overridden to draw from the game's fixed-size region
// allocator (Mem::Manager::New). Streamed voice clips are large (one cutscene line
// can be ~576KB) and would compete with the gameplay region -- on a heavy cutscene
// load that region runs out and the allocation asserts (region.cpp). The original
// game never streamed audio through the main heap. This allocator routes the decode
// buffers to the CRT heap (::malloc/::free, which back the regions and have the full
// process address space) so they never touch the game region.
template<class T>
struct SysHeapAlloc
{
	using value_type = T;
	SysHeapAlloc() noexcept = default;
	template<class U> SysHeapAlloc( const SysHeapAlloc<U>& ) noexcept {}
	T*   allocate( std::size_t n )
	{
		if( n > (std::size_t)-1 / sizeof(T) ) throw std::bad_alloc();
		void *p = std::malloc( n * sizeof(T) );
		if( !p ) throw std::bad_alloc();
		return static_cast<T*>( p );
	}
	void deallocate( T *p, std::size_t ) noexcept { std::free( p ); }
};
template<class T, class U> bool operator==( const SysHeapAlloc<T>&, const SysHeapAlloc<U>& ) noexcept { return true; }
template<class T, class U> bool operator!=( const SysHeapAlloc<T>&, const SysHeapAlloc<U>& ) noexcept { return false; }

template<class T> using SysVector = std::vector<T, SysHeapAlloc<T>>;

class BinkAudioDecoder
{
public:
	// data/size must outlive the decoder (it is not copied).
	BinkAudioDecoder(const uint8_t *data, size_t size);

	bool   Valid()      const { return m_valid; }
	int    SampleRate() const { return m_sample_rate; }
	int    Channels()   const { return m_channels; }

	// Decode the next block into out as normalised [-1,1] float frames. For stereo
	// the samples are interleaved L,R, so out capacity must be >= BlockSamples() *
	// Channels(). Returns the number of frames written (== BlockSamples()), or 0 at
	// end of stream. Advances through packets/blocks internally.
	size_t DecodeBlock(float *out);

	// Frames emitted per block, per channel (frame_len - overlap_len).
	size_t BlockSamples() const { return (size_t)(m_frame_len - m_overlap_len); }

private:
	// --- input ---
	const uint8_t *m_data; size_t m_size;
	bool   m_valid = false;
	int    m_sample_rate = 0;
	int    m_channels = 0;
	bool   m_use_dct = false;

	// audio packets within the bink container: (offset,size) into m_data
	struct Pkt { size_t off, len; };
	SysVector<Pkt> m_pkts;
	size_t m_pkt_index = 0;

	// --- bit reader over the current packet (LSB-first) ---
	const uint8_t *m_bits = nullptr; size_t m_bit_nbits = 0; size_t m_bit_pos = 0;
	bool   m_pkt_open = false;
	void   open_packet(size_t i);
	uint32_t read_bits(int n);
	int    read_bit() { return (int)read_bits(1); }
	size_t bits_left() const { return m_bit_nbits - m_bit_pos; }
	void   align32();
	float  read_float();

	// --- decoder state ---
	int    m_frame_len = 0;
	int    m_overlap_len = 0;
	int    m_num_bands = 0;
	float  m_root = 0.0f;
	float  m_quant_table[96];
	unsigned m_bands[26];
	bool   m_first = true;
	SysVector<float> m_previous;   // overlap tail from previous block [overlap_len*channels]

	SysVector<float> m_coeffs;     // per-channel scratch [frame_len+2]
	SysVector<float> m_timebuf;    // inverse-DCT output, one frame per channel [frame_len*channels]

	// Fast inverse DCT-III via a 2N-point FFT (M = 2*frame_len).
	// out[n] = (2/N) * Re( FFT+_{2N}( coeffs[k]*exp(i*pi*k/M) )[n] ), n in [0,N).
	int    m_M = 0;
	SysVector<int>   m_brev;       // bit-reversal permutation [M]
	SysVector<float> m_tw_r, m_tw_i;   // FFT twiddles cos/sin(2pi t/M), t in [0,M/2)
	SysVector<float> m_pre_r, m_pre_i; // pre-rotation cos/sin(pi k/M), k in [0,N)
	SysVector<float> m_fr, m_fi;       // FFT scratch [M]
	void fft_pos(float *re, float *im);  // in-place radix-2 FFT, kernel exp(+i 2pi/M)

	void init_decoder();
	bool decode_one_block(float *out);   // fills frame_len, returns false at EOF
};

}

#endif
