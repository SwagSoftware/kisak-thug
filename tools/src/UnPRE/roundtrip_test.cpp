// Round-trip test: game's real Encode() (lzss.cpp) -> our DecodeLZSS().
// Builds with the unmodified engine encoder to prove the decoder inverts it.
#include <cstdio>
#include <cstdint>
#include <cstdlib>
#include <vector>
#include <cstring>

typedef unsigned int uint32;
typedef unsigned short uint16;

// the real encoder from the engine/tools (lzss.cpp)
extern int Encode(char *pIn, char *pOut, int bytes_to_read, bool print_progress);

// our decoder (copied verbatim from UnPRE.cpp)
static const int kRingSize=4096,kMatchMax=18,kThreshold=2;
static size_t DecodeLZSS(const uint8_t*in,size_t inLen,uint8_t*out,size_t outCap){
    std::vector<uint8_t> tb(kRingSize+kMatchMax-1,0);
    for(int i=0;i<kRingSize-kMatchMax;i++)tb[i]=' ';
    int r=kRingSize-kMatchMax; unsigned flags=0; size_t ip=0,op=0;
    for(;;){
        if(((flags>>=1)&256)==0){ if(ip>=inLen)break; unsigned c=in[ip++]; flags=c|0xff00u; }
        if(flags&1){ if(ip>=inLen)break; uint8_t c=in[ip++]; if(op<outCap)out[op++]=c; tb[r++]=c; r&=(kRingSize-1); }
        else{ if(ip>=inLen)break; int i=in[ip++]; if(ip>=inLen)break; int j=in[ip++];
              i|=((j&0xf0)<<4); j=(j&0x0f)+kThreshold;
              for(int k=0;k<=j;k++){ uint8_t c=tb[(i+k)&(kRingSize-1)]; if(op<outCap)out[op++]=c; tb[r++]=c; r&=(kRingSize-1);} }
    }
    return op;
}

int main(){
    srand(12345);
    int fails=0;
    for(int trial=0;trial<200;trial++){
        int n = 1 + rand()%200000;
        std::vector<char> src(n);
        // mix of random + repetitive data so LZSS actually finds matches
        int mode = trial%3;
        for(int i=0;i<n;i++){
            if(mode==0) src[i]=(char)(rand()&0xff);
            else if(mode==1) src[i]=(char)('A'+(i/37)%5);     // long runs
            else src[i]=(char)((i%17)?(rand()&0x0f):0xAA);    // semi-repetitive
        }
        std::vector<char> packed(n*2+4096);
        int csize = Encode(src.data(), packed.data(), n, false);
        std::vector<uint8_t> out(n);
        size_t got = DecodeLZSS((uint8_t*)packed.data(), csize, out.data(), n);
        if(got!=(size_t)n || memcmp(out.data(),src.data(),n)!=0){
            printf("FAIL trial %d (n=%d mode=%d csize=%d got=%zu)\n",trial,n,mode,csize,got);
            fails++;
        }
    }
    printf(fails? "%d FAILURES\n":"All 200 round-trips OK (random/runs/semi-repetitive, up to 200KB)\n", fails);
    return fails?1:0;
}
