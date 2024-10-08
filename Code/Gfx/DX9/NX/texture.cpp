#include <string.h>
#include <core/defines.h>
#include <core/debug.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/file/filesys.h>
#include "nx_init.h"
#include "chars.h"
#include "texture.h"
#include "render.h"

namespace NxXbox
{

LinkedList* g_sTexturesList;
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sTexture::sTexture()
{
	memset(this, 0x00, sizeof(sTexture)); // lwss add
	pD3DTexture = NULL;
	//pD3DPalette	= NULL;
	texrawdata = NULL;
	pD3DSurface	= NULL;		// If used as a render target.
	texunk2 = 0;
	
	// lwss add
	LinkedList* newEntry = new LinkedList();
	NxXbox::LinkedList* v3 = g_sTexturesList;
	bool hasNoData = (g_sTexturesList == 0);
	newEntry->data = this;
	newEntry->prev = NULL;
	newEntry->next = v3;
	g_sTexturesList = newEntry;
	if (!hasNoData)
	{
		v3->prev = newEntry;
	}
	// lwss end
}

void sTexture::RemoveFromGlobalList()
{
	NxXbox::LinkedList* p_list = g_sTexturesList;
	NxXbox::LinkedList* prev;
	NxXbox::LinkedList* next;
	if (g_sTexturesList)
	{
		while (p_list->data != this)
		{
			p_list = p_list->next;
			if (!p_list)
				return;
		}
		prev = p_list->prev;

		if (prev)
			prev->next = p_list->next;
		else
			g_sTexturesList = p_list->next;
		next = p_list->next;

		if (next)
			next->prev = p_list->prev;

		delete p_list ;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sTexture::~sTexture()
{
	// lwss: slight changes made
	ULONG rr;

	RemoveFromGlobalList();

	if (pD3DSurface)
	{
		rr = pD3DSurface->Release();
		pD3DSurface = NULL;
		//Dbg_Assert(rr == 0); // KISAKTODO fix
	}

	if( pD3DTexture )
	{
		rr = pD3DTexture->Release();
		Dbg_Assert( rr == 0 );

		// Ensure that this texture is no longer referenced in the EngineGlobals.
		for( int p = 0; p < 4; ++p )
		{
			if( EngineGlobals.p_texture[p] == pD3DTexture )
			{
				set_texture( p, NULL );
			}
		}
	}
	//if( pD3DPalette )
	//{
	//	rr = pD3DPalette->Release();
	//	Dbg_Assert( rr == 0 );
	//}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sTexture::Set( int pass )
{
	// Set this texture as the active texture for a specific pass.
	//set_texture( pass, pD3DTexture, pD3DPalette );
	set_texture( pass, pD3DTexture );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool sTexture::SetRenderTarget( int width, int height, int depth, int z_depth )
{
	HRESULT		hr;
	
	if( pD3DTexture )
	{
		pD3DTexture->Release();
		pD3DTexture = NULL;
	}

	if (pD3DSurface)
	{
		pD3DSurface->Release();
		pD3DSurface = NULL;
	}

	//if( pD3DPalette )
	//{
	//	pD3DPalette->Release();
	//}

	// Create the shadow buffer (essentially just a depth buffer).
	//hr = D3DDevice_CreateTexture( width, height, 1, 0, D3DFMT_LIN_D24S8, 0, &pD3DTexture );
	hr = D3DDevice_CreateTexture( width, height, 1, 1, D3DFMT_A8R8G8B8, D3DPOOL_DEFAULT, &pD3DTexture, 0 );
	Dbg_Assert( hr == D3D_OK );
	if( hr == D3D_OK )
	{
		pD3DTexture->GetSurfaceLevel(0, &pD3DSurface);

		// Set fields to reflect surface characteristics.
		Checksum		= 0;
		BaseWidth		= ActualWidth	= width;
		BaseHeight		= ActualHeight	= height;
		Levels			= 1;
		TexelDepth		= depth;
		PaletteDepth	= 0;
		DXT				= 0;
		return true;
	}
	return false;
}



// Eeeek - the .img contains PS2 specific register values for bit depth.
// Use these values to convert them.
#define PSMCT32		0x00
#define PSMCT24		0x01
#define PSMCT16		0x02
#define PSMCT16S	0x0A
#define PS_GPU24	0x12
#define PSMT8		0x13
#define PSMT4		0x14
#define PSMT8H		0x1B
#define PSMT4HL		0x24
#define PSMT4HH		0x2C
#define PSMZ32		0x30
#define PSMZ24		0x31
#define PSMZ16		0x32
#define PSMZ16S		0x3A



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static bool is_power_of_two( uint32 a )
{
	if( a == 0 )
	{
		return false;
	}
	return (( a & ( a - 1 )) == 0 );
}


void Unswizzle(char* outData, char* inData, int width, int height, size_t byteDepth)
{
	int pixelItr = 0;
	int inDataItr = 0;
	int totalResolution = width * height;

	while (pixelItr < totalResolution)
	{
		int halfWidth = width / 2;
		int halfHeight = height / 2;

		int v15 = 0;
		int v16 = 0;
		int v17 = 1;
		int v18 = 1;
		int v19 = 1;
		while (halfWidth || halfHeight)
		{
			if (halfWidth)
			{
				halfWidth /= 2;
				if ((pixelItr & v19) != 0)
				{
					v15 |= v17;
				}
				v17 *= 2;
				v19 *= 2;
			}
			if (halfHeight)
			{
				halfHeight /= 2;
				if ((pixelItr & v19) != 0)
				{
					v16 |= v18;
				}
				v18 *= 2;
				v19 *= 2;
			}
		}
		memcpy(&outData[byteDepth * (v15 + v16 * width)], &inData[inDataItr], byteDepth);
		inDataItr += byteDepth;
		pixelItr++;
	}
}

static char* strrstr(char* _Str, char* _SubStr) {
	char* returnPointer, * p;

	//find 1st occurence. if not found, return NULL
	if ((p = strstr(_Str, _SubStr)) == NULL)
		return NULL;

	//loop around until no more occurences
	do {
		returnPointer = p;
		++p;
	} while (p = strstr(p, _SubStr));

	return returnPointer;
}
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: should be done.
int DwordizeTexelData(int texel_data_dword_array, int texel_data_char_array, int numBytesChar, int data);
sTexture *LoadTexture( const char *p_filename )
{
	struct sIMGHeader
	{
		uint32	version;
		uint32	checksum;
		uint32	width;
		uint32	height;
		uint32	bit_depth;
		uint32	clut_bit_depth;
		uint16	original_width;
		uint16	original_height;
		uint32	palette_data_size;
	};

	void *p_FH = File::Open( p_filename, "rb" );
	
	if (!p_FH)
	{
		return NULL;
	}

	// Read header.
	sIMGHeader header;
	File::Read( &header, sizeof( sIMGHeader ), 1, p_FH );
		
	// Bits per texel and palette size.
	switch( header.bit_depth )
	{
		case PSMCT32:
			header.bit_depth = 32;
			break;
		case PSMCT16:
			header.bit_depth = 16;
			break;
		case PSMT8:
			header.bit_depth = 8;
			break;
		default:
			Dbg_Assert( 0 );
	}

	// Bits per clut entry.
	if(	header.bit_depth < 16 )
	{
		switch( header.clut_bit_depth )
		{
			case PSMCT32:
				header.clut_bit_depth = 32;
				break;
			default:
				Dbg_Assert( 0 );
		}
	}
	else
	{
		header.clut_bit_depth = 0;
	}
		
	// Create the texture object.
	sTexture *p_texture = new sTexture();

	// lwss: no palette in dx9
	// Create palette if required.
	//if( header.clut_bit_depth == 0 )
	//{
	//	p_texture->pD3DPalette = NULL;
	//}
	//else
	bool had_clut_depth = false;
	D3DCOLOR* p_clut = nullptr;
	if (header.clut_bit_depth)
	{
		had_clut_depth = true;
		//if( D3D_OK != D3DDevice_CreatePalette( D3DPALETTE_256, &p_texture->pD3DPalette ))
		//{
		//	Dbg_Assert( 0 );
		//}
		
		// Read clut bitmap data.
		//p_texture->pD3DPalette->Lock( &p_clut, 0 );

		p_clut = (D3DCOLOR *)malloc(header.palette_data_size);
		int len	= File::Read( p_clut, header.palette_data_size, 1, p_FH );
		Dbg_MsgAssert( len == header.palette_data_size, ( "Couldn't read clut from texture file %s", p_filename ));
	}

	// Textures of width 512 and above will not have been resized. This means they cannot be in a swizzled format.
//			bool arbitrary_texture_size = ( header.original_width >= 512 );
	bool arbitrary_texture_size = false;
			
	if( !is_power_of_two( header.width ) || !is_power_of_two( header.height ))
		arbitrary_texture_size = true;

	// LWSS: logic changes here.
	D3DDevice_CreateTexture(header.width, header.height, 1, 0, D3DFMT_A8R8G8B8, D3DPOOL_MANAGED, &p_texture->pD3DTexture, 0);

	if (arbitrary_texture_size)
	{
		p_texture->BaseWidth = header.original_width;
		p_texture->BaseHeight = header.original_height;
	}
	else
	{
		p_texture->BaseWidth = header.width;
		p_texture->BaseHeight = header.height ;
	}

	int base_height = p_texture->BaseHeight;
	int base_width = p_texture->BaseWidth;

	p_texture->ActualWidth = header.original_width;
	p_texture->ActualHeight = header.original_height;

	uint32 num_bytes = (base_width * base_height * ((unsigned int)header.bit_depth >> 3) + 3) & 0xFFFFFFFC;

	// Create texture resource. Linear for arbitrary sized textures, swizzled for standard sizes.
	//uint32 num_bytes;
	//if( arbitrary_texture_size )
	//{
	//	if( D3D_OK != D3DDevice_CreateTexture(	header.original_width,
	//											header.original_height,
	//											1,
	//											0,
	//											( header.bit_depth <= 8 ) ? D3DFMT_P8 : (( header.bit_depth == 16 ) ? D3DFMT_LIN_A1R5G5B5 : D3DFMT_LIN_A8R8G8B8 ),
	//											0,
	//											&p_texture->pD3DTexture ))
	//	{
	//		Dbg_Assert( 0 );
	//	}
	//	p_texture->BaseWidth	= header.original_width;
	//	p_texture->BaseHeight	= header.original_height;
	//	p_texture->ActualWidth	= header.original_width;
	//	p_texture->ActualHeight	= header.original_height;
	//	num_bytes				= ((( header.bit_depth / 8 ) * ( header.original_width ) * ( header.original_height )) + 3 ) & 0xFFFFFFFC;
	//}
	//else
	//{
	//	if( D3D_OK != D3DDevice_CreateTexture(	header.width,
	//											header.height,
	//											1,
	//											0,
	//											( header.bit_depth <= 8 ) ? D3DFMT_P8 : (( header.bit_depth == 16 ) ? D3DFMT_A1R5G5B5 : D3DFMT_A8R8G8B8 ),
	//											0,
	//											&p_texture->pD3DTexture ))
	//	{
	//		Dbg_Assert( 0 );
	//	}
	//	p_texture->BaseWidth	= (uint16)header.width;
	//	p_texture->BaseHeight	= (uint16)header.height;
	//	p_texture->ActualWidth	= header.original_width;
	//	p_texture->ActualHeight	= header.original_height;
	//	num_bytes				= ((( header.bit_depth / 8 ) * header.width * header.height ) + 3 ) & 0xFFFFFFFC;
	//}
	
	// Lock the texture so we can read data into it directly.
	D3DLOCKED_RECT locked_rect;
	if( D3D_OK != p_texture->pD3DTexture->LockRect( 0, &locked_rect, NULL, 0 ))
	{
		Dbg_Assert( 0 );
	}

	void* pBits;

	if (!arbitrary_texture_size || had_clut_depth)
	{
		void* data = malloc(num_bytes);
		void* pBits = NULL;
		bool pBitsNeedFree = false;

		File::Read(data, num_bytes, 1, p_FH);

		if (arbitrary_texture_size)
		{
			pBits = data;
		}
		else
		{
			if (had_clut_depth)
			{
				pBits = malloc(num_bytes);
				pBitsNeedFree = true;
			}
			else
			{
				pBits = locked_rect.pBits;
			}
			Unswizzle((char*)pBits, (char*)data, header.width, header.height, (unsigned int)header.bit_depth >> 3);
		}
		if (had_clut_depth)
		{
			DwordizeTexelData((int)locked_rect.pBits, (int)pBits, num_bytes, (int)p_clut);
		}

		free(p_clut);
		free(data);
		if (pBitsNeedFree)
		{
			free(pBits);
		}
	}
	else
	{
		File::Read(locked_rect.pBits, num_bytes, 1, p_FH);
	}

	// Read texture bitmap data directly into texture. 
	//int len = File::Read( locked_rect.pBits, num_bytes, 1, p_FH );
	//Dbg_MsgAssert( len == num_bytes, ( "couldn't read texture data from texture file %s", p_filename ));
		
	File::Close( p_FH );

	// Set up some member values.
	//p_texture->PaletteDepth	= (uint8)header.clut_bit_depth;
	//p_texture->TexelDepth	= (uint8)header.bit_depth;
	p_texture->PaletteDepth = 0; // lwss change
	p_texture->TexelDepth = 32; // lwss change
	p_texture->DXT			= 0;
	p_texture->Levels		= 1;
			
	p_texture->pD3DTexture->UnlockRect(0);

	//// LWSS Add: exporting of Textures 
	//char buffer[MAX_PATH]{ 0 };
	////snprintf(buffer, MAX_PATH - 1, "C:\\temp\\kisak-%08X.bmp", pMat->m_checksum);
	//const char* lastslash = strrstr((char*)p_filename, "/");
	//
	//snprintf(buffer, MAX_PATH - 1, "C:\\temp\\kisak-%s.bmp", lastslash + 1);
	//auto result = D3DXSaveTextureToFileA(buffer, D3DXIFF_BMP, p_texture->pD3DTexture, NULL);
	//printf("%x", result);
	//// LWSS End

	return p_texture;
}


} // namespace NxXbox

