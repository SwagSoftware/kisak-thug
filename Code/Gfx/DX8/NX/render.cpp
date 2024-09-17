#include <core/defines.h>
#include <core/debug.h>
#include <core/HashTable.h>
#include <stdio.h>
#include <stdlib.h>
//#include <xgraphics.h>
//#include <xgmath.h>
#include <gfx\DX8\p_nxgeom.h>
#include <Gfx/DX8/p_nxscene.h>
#include <Gfx/nx.h>
#include <sys\timer.h>
#include "nx_init.h"
#include "scene.h"
#include "render.h"
#include "instance.h"
#include "occlude.h"
#include "billboard.h"

//#include "PixelShader0.h"
//#include "PixelShader0IVA.h"
//#include "PixelShader1.h"
//#include "PixelShader2.h"
//#include "PixelShader3.h"
//#include "PixelShader4.h"
//#include "PixelShader5.h"
//#include "PixelShaderBrighten.h"
//#include "PixelShaderBrightenIVA.h"
//#include "PixelShaderFocusBlur.h"
//#include "PixelShaderFocusIntegrate.h"
//#include "PixelShaderFocusLookupIntegrate.h"
//#include "PixelShaderNULL.h"
//#include "PixelShaderPointSprite.h"
//#include "PixelShader_ShadowBuffer.h"
//#include "PixelShaderBumpWater.h"
//#include "ShadowBufferStaticGeomPS.h"

IDirect3DPixelShader9* PixelShader0;
IDirect3DPixelShader9* PixelShader0IVA;
IDirect3DPixelShader9* PixelShader1;
IDirect3DPixelShader9* PixelShader2;
IDirect3DPixelShader9* PixelShader3;
IDirect3DPixelShader9* PixelShader4;
IDirect3DPixelShader9* PixelShader5;
IDirect3DPixelShader9* PixelShaderBrighten;
IDirect3DPixelShader9* PixelShaderBrightenIVA;
IDirect3DPixelShader9* PixelShaderFocusBlur;
IDirect3DPixelShader9* PixelShaderFocusIntegrate;
IDirect3DPixelShader9* PixelShaderFocusLookupIntegrate;
IDirect3DPixelShader9* PixelShaderNULL;
IDirect3DPixelShader9* PixelShaderPointSprite;
IDirect3DPixelShader9* PixelShader_ShadowBuffer;
IDirect3DPixelShader9* PixelShaderBumpWater;
IDirect3DPixelShader9* ShadowBufferStaticGeomPS;

//D3DXMATRIX *p_bbox_transform = NULL;
//D3DXMATRIX bbox_transform;
XGMATRIX	*p_bbox_transform = NULL;
XGMATRIX	bbox_transform;

extern DWORD ShadowBufferStaticGeomVS;

namespace NxXbox
{

const float FRONT_TO_BACK_SORT_CUTOFF	= ( 50.0f * 12.0f );

Lst::HashTable< sTextureProjectionDetails >	*pTextureProjectionDetailsTable = NULL;

// For converting a FLOAT to a DWORD (useful for SetRenderState() calls)
inline DWORD FtoDW( FLOAT f ) { return *((DWORD*)&f); }

//static Lst::HashTable<DWORD> sPixelShaderTable( 8 );
static Lst::HashTable<IDirect3DPixelShader9> sPixelShaderTable( 8 );


static const int MAX_FREE_TESTS					= 1024;
static bool		visibilityTestValuesInitialised = false;
static uint8	visibilityTestValues[MAX_FREE_TESTS];

struct sVisibilityTestFIFO
{
	static const int	MAX_FIFO_SIZE	= 4;

	uint32				m_status_fifo[MAX_FIFO_SIZE];
	uint32				m_fifo_index;

						sVisibilityTestFIFO();
						~sVisibilityTestFIFO();

	static uint32		GetFreeTestIndex( void );
	uint32				AddStatus( void );
	//uint32				GetStatus( void ); // LWSS: Remove, only used in glow code


	private:

	void				SlideQueue( void );
	uint32				m_last_valid_status;
};


struct sLightGlowDetails
{
	Mth::Vector			m_pos;
	float				m_glow_radius;
	float				m_current_radius;
	float				m_test_radius;
	float				m_radius_growth;
	sVisibilityTestFIFO	m_visibility_test_fifo;
};


static Lst::HashTable<sLightGlowDetails> sLightGlowDetailsTable( 8 );




/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
BlendModes GetBlendMode( uint32 blend_checksum )
{
	BlendModes rv = NxXbox::vBLEND_MODE_DIFFUSE;

	switch ( blend_checksum )
	{
		case 0x54628ed7:		// Blend
			rv = NxXbox::vBLEND_MODE_BLEND;
			break;
		case 0x02e58c18:		// Add
			rv = NxXbox::vBLEND_MODE_ADD;
			break;
		case 0xa7fd7d23:		// Sub
		case 0xdea7e576:		// Subtract
			rv = NxXbox::vBLEND_MODE_SUBTRACT;
			break;
		case 0x40f44b8a:		// Modulate
			rv = NxXbox::vBLEND_MODE_MODULATE;
			break;
		case 0x68e77f40:		// Brighten
			rv = NxXbox::vBLEND_MODE_BRIGHTEN;
			break;
		case 0x18b98905:		// FixBlend
			rv = NxXbox::vBLEND_MODE_BLEND_FIXED;
			break;
		case 0xa86285a1:		// FixAdd
			rv = NxXbox::vBLEND_MODE_ADD_FIXED;
			break;
		case 0x0d7a749a:		// FixSub
		case 0x0eea99ff:		// FixSubtract
			rv = NxXbox::vBLEND_MODE_SUB_FIXED;
			break;
		case 0x90b93703:		// FixModulate
			rv = NxXbox::vBLEND_MODE_MODULATE_FIXED;
			break;
		case 0xb8aa03c9:		// FixBrighten
			rv = NxXbox::vBLEND_MODE_BRIGHTEN_FIXED;
			break;
		case 0x515e298e:		// Diffuse
		case 0x806fff30:		// None
			rv = NxXbox::vBLEND_MODE_DIFFUSE;
			break;
		default:
			Dbg_MsgAssert(0,("Illegal blend mode specified. Please use (fix)blend/add/sub/modulate/brighten or diffuse/none."));
			break;
	}
	return rv;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sVisibilityTestFIFO::sVisibilityTestFIFO()
{
	m_fifo_index		= 0;
	m_last_valid_status	= 0;

	if( !visibilityTestValuesInitialised )
	{
		ZeroMemory( visibilityTestValues, sizeof( uint8 ) * MAX_FREE_TESTS );

		// The first index is always reserved.
		visibilityTestValues[0] = 1;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sVisibilityTestFIFO::~sVisibilityTestFIFO()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sVisibilityTestFIFO::SlideQueue( void )
{
	Dbg_Assert( m_fifo_index > 0 );

	m_status_fifo[0] = m_status_fifo[1];
	m_status_fifo[1] = m_status_fifo[2];
	m_status_fifo[2] = m_status_fifo[3];
	m_status_fifo[3] = 0;

	--m_fifo_index;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
uint32 sVisibilityTestFIFO::GetFreeTestIndex( void )
{
	for( uint32 i = 0; i < MAX_FREE_TESTS; ++i )
	{
		if( visibilityTestValues[i] == 0 )
		{
			visibilityTestValues[i] = 1;
			return i;
		}
	}
	Dbg_Assert( 0 );
	return MAX_FREE_TESTS - 1;
}
	


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
uint32 sVisibilityTestFIFO::AddStatus( void )
{
	// If the queue is already full, do nothing.
	if( m_fifo_index >= ( MAX_FIFO_SIZE - 1 ))
	{
		return 0;
	}

	// Get a free index.
	uint32 index = GetFreeTestIndex();
	m_status_fifo[m_fifo_index++] = index;

	return index;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Remove, only used in glow code
//uint32 sVisibilityTestFIFO::GetStatus( void )
//{
//	Dbg_Assert( m_fifo_index > 0 );
//
//	UINT result;
//
//	// Get the result from the least recently issued test.
//	HRESULT hr = D3DDevice_GetVisibilityTestResult( m_status_fifo[0], &result, NULL );
//
//	if( hr == D3D_OK )
//	{
//		// Finished with this test. First mark this test index as no longer in use.
//		visibilityTestValues[m_status_fifo[0]] = 0;
//
//		// Remove entry from the queue.
//		SlideQueue();
//
//		m_last_valid_status = (uint32)result;
//		return m_last_valid_status;
//	}
//	else if( hr == D3DERR_TESTINCOMPLETE )
//	{
//		// Use the last valid status.
//		return m_last_valid_status;
//	}
//
//	return 0;
//}







/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Should be heckin done -- assuming no bugs
// LWSS: Double checked this a week~ later. Small changes made. Should be solid.
//DWORD get_pixel_shader( sMaterial *p_material )
void Swog(char const* format, ...)
{
	char buffer[4096];
	static bool bFirst = true;
	FILE* logFile;

	if (bFirst) {
		logFile = fopen("F:\\thugpixelshaders.txt", "w"); // create new log
		fprintf(logFile, "--Start of log--\n");
		bFirst = false;
	}
	else {
		logFile = fopen("F:\\thugpixelshaders.txt", "a"); // append to log
	}
	setbuf(logFile, NULL); // Turn off buffered I/O, decreases performance but if crash occurs, no unflushed buffer.
	va_list args;
	va_start(args, format);
	vsnprintf(buffer, 4096, format, args);
	fprintf(logFile, buffer);
	va_end(args);
	fclose(logFile);
}
static IDirect3DPixelShader9* get_pixel_shader( sMaterial *p_material )
{
	const  int	PIXEL_SHADER_BUFFER_SIZE	= 64 * 1024;
	static char pixel_shader_buffer[PIXEL_SHADER_BUFFER_SIZE];
	static int	pixel_shader_buffer_offset = 0;
	//uint32		blend_modes[4];
	uint32		blend_modes[5];

//	bool		mcm = true;
//	bool		mcm = false;
	int mcm = 0;
	int v3 = 0;
	for( uint32 p = 0; p < p_material->m_passes;)// ++p )
	{
		//if( !mcm )
		//{
		//	if(( p_material->m_color[p][0] != 0.5f ) || ( p_material->m_color[p][1] != 0.5f ) || ( p_material->m_color[p][2] != 0.5f ))
		//		mcm = true;
		//}
		int v6 = 1 << p++;
		v3 |= v6;
		blend_modes[p] = p_material->m_reg_alpha[p - 1] & sMaterial::BLEND_MODE_MASK;
	}
	mcm = v3;

	// First we build the unique key from the properties of the required shader, to see if it already exists.
	//uint32 code = p_material->m_passes;
	uint32 code = p_material->m_passes - 1;
	int v9 = 2;
	for( uint32 p = 0; p < p_material->m_passes; ++p )
	{
		//code |= ( blend_modes[p] << ( 5 * ( p + 1 )));
		code |= blend_modes[p] << v9;
		v9 += 5;
	}

	// Integrate the ignore vertex alpha flags.
	uint32 ignore_bf = p_material->GetIgnoreVertexAlphaPasses();
	uint32 new_code = ((ignore_bf | (8 * mcm)) << 22) | code;
	//code |= ( ignore_bf << 25 );

	// Check also to see if material color modulation is required.
	//if( mcm )
	//{
	//	code |= ( 1 << 30 );
	//}
		
	// Check to see if the shader exists, if so just return the shader handle.
	IDirect3DPixelShader9 *p_shader = sPixelShaderTable.GetItem( code );
	if( p_shader )
	{
		return p_shader;
	}

	// We need to build the shader.
	char shader_buffer[1024];

	// LWSS: Change entire shader building code
	//sprintf( shader_buffer, "xps.1.1\n" );
	int itr = 0;
	int passItr = 0;
	for (itr = sprintf(shader_buffer, "ps.1.1\n"); passItr < p_material->m_passes;)
	{
		itr += sprintf(&shader_buffer[itr], "tex t%d\n", passItr++);
	}

	if (mcm)
	{
		if (ignore_bf)
		{
			itr += sprintf(&shader_buffer[itr], "mov r0.a, t0.a\n");
		}
		else
		{
			itr += sprintf(&shader_buffer[itr], "mul_x2 r0.a, v0.a, t0.a\n");
		}
		itr += sprintf(&shader_buffer[itr], "+mul_x2 r0.rgb, c0, t0\n");
	}
	else if (ignore_bf)
	{
		itr += sprintf(&shader_buffer[itr], "mov r0, t0\n");
	}
	else
	{
		itr += sprintf(&shader_buffer[itr], "mul_x2 r0.a, v0.a, t0.a\n");
		itr += sprintf(&shader_buffer[itr], "+mov r0.rgb, t0\n");
	}


	int curr_blend_mode = 1;
	int alpha_flag;
	bool uses_prev = false;

	if (p_material->m_passes > 1)
	{
		while (true)
		{
			int blend_mode_value = blend_modes[curr_blend_mode + 1];
			uses_prev = false;
			int v33 = 0;
			int v2 = 4;

			if (blend_mode_value == vBLEND_MODE_BLEND_PREVIOUS_MASK || blend_mode_value == vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK)
			{
				uses_prev = true;
			}

			alpha_flag = 1 << curr_blend_mode;

			if (((1 << curr_blend_mode) & mcm) != 0)
			{
				break;
			}

			if ((alpha_flag & ignore_bf) == 0)
			{
				itr += sprintf(&shader_buffer[itr], "mov r1.rgb, t%d\n", curr_blend_mode);
LABEL_31:
				if (!uses_prev)
				{
					if (blend_modes[curr_blend_mode + 1] == vBLEND_MODE_BLEND)
					{
						itr += sprintf(&shader_buffer[itr], "+mul_x2_sat r1.a, v0.a, t%d.a\n", curr_blend_mode);
					}
					else
					{
						itr += sprintf(&shader_buffer[itr], "+mul_x2 r1.a, v0.a, t%d.a\n", curr_blend_mode);
					}
				}
			}
			else
			{
				v2 = curr_blend_mode;
			}

BLEND_MODES_SWITCH:
			static const char aR0[][3] = { "r0", "t1", "t2", "t3", "r1" };
			uint32 switchVal = blend_modes[curr_blend_mode + 1];
			switch (switchVal)
			{
			case vBLEND_MODE_ADD:
			{
				itr += sprintf(&shader_buffer[itr], "mad r0.rgb,%s,%s.a,r0\n", aR0[v2], aR0[v2]);
				break;
			}
			case vBLEND_MODE_ADD_FIXED:
			{
				itr += sprintf(&shader_buffer[itr], "mad r0.rgb,%s,c%d.a,r0\n", aR0[v2], curr_blend_mode);
				break;
			}
			case vBLEND_MODE_SUBTRACT:
			{
				itr += sprintf(&shader_buffer[itr], "mad r0.rgb,%s,-%s.a,r0\n", aR0[v2], aR0[v2]);
				break;
			}
			case vBLEND_MODE_SUB_FIXED:
			{
				itr += sprintf(&shader_buffer[itr], "mad r0.rgb,-%s,c%d.a,r0\n", aR0[v2], curr_blend_mode);
				break;
			}
			case vBLEND_MODE_BLEND:
			{
				itr += sprintf(&shader_buffer[itr], "lrp r0.rgb,%s.a,%s,r0\n", aR0[v2], aR0[v2]);
				break;
			}
			case vBLEND_MODE_BLEND_FIXED:
			{
				itr += sprintf(&shader_buffer[itr], "lrp r0.rgb,c%d.a,%s,r0\n", curr_blend_mode, aR0[v2]);
				break;
			}
			case vBLEND_MODE_MODULATE:
			{
				itr += sprintf(&shader_buffer[itr], "mul r0.rgb,r0,%s.a\n", aR0[v2]);
				break;
			}
			case vBLEND_MODE_MODULATE_FIXED:
			{
				itr += sprintf(&shader_buffer[itr], "mul r0.rgb,r0,c%d.a\n", curr_blend_mode);
				break;
			}
			case vBLEND_MODE_BRIGHTEN:
			{
				itr += sprintf(&shader_buffer[itr], "mad r0.rgb,r0,%s.a,r0\n", aR0[v2]);
				break;
			}
			case vBLEND_MODE_BRIGHTEN_FIXED:
			{
				itr += sprintf(&shader_buffer[itr], "mad r0.rgb,r0,c%d.a,r0\n", curr_blend_mode);
				break;
			}
			case vBLEND_MODE_GLOSS_MAP:
			{
				itr += sprintf(&shader_buffer[itr], "mul v1.rgb,v1,%s.a\n", aR0[v2]);
				break;
			}
			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
			{
				itr += sprintf(&shader_buffer[itr], "lrp r0.rgb, %s.a, %s, r0\n", aR0[v33], &aR0[v2]);
				break;
			}
			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
			{
				itr += sprintf(&shader_buffer[itr], "lrp r0.rgb, %s.a, r0, %s\n", &aR0[v33], &aR0[v2]);
				break;
			}
			default:
				__debugbreak();
				break;
			} // switch()

			if (++curr_blend_mode >= p_material->m_passes)
			{
				goto ASSEMBLE;
			}
		} // while(TRUE)

		if ((alpha_flag & ignore_bf) != 0)
		{
			itr += sprintf(&shader_buffer[itr], "mul_x2 r1.rgb, c%d, t%d\n", curr_blend_mode, curr_blend_mode);
			if (!uses_prev)
				itr += sprintf(&shader_buffer[itr], "+mov r1.a, t%d\n", curr_blend_mode);
			goto BLEND_MODES_SWITCH;
		}
		itr += sprintf(&shader_buffer[itr], "mul_x2 r1.rgb, c%d, t%d\n", curr_blend_mode, curr_blend_mode);
		goto LABEL_31;

	} // if passes > 1
ASSEMBLE:
	sprintf(&shader_buffer[itr], "mul_x2 r0.rgb, r0, v0\n");

	LPD3DXBUFFER p_shader_buffer = NULL;
	LPD3DXBUFFER p_err = NULL;
		
	if (D3DXAssembleShader(shader_buffer, strlen(shader_buffer), 0, 0, 0, &p_shader_buffer, &p_err) != D3D_OK)
	{
		Dbg_MsgAssert(0, ("Failed to Assemble Shader!"));
		return NULL;
	}

	Swog("%s\n\n\n", shader_buffer);

	IDirect3DPixelShader9* shader_handle;
	if (D3D_OK != NxXbox::EngineGlobals.p_Device->CreatePixelShader((DWORD*)p_shader_buffer->GetBufferPointer(), &shader_handle))
	{
		__debugbreak();
	}
	sPixelShaderTable.PutItem(code, shader_handle);

	return shader_handle;

	//strcat( shader_buffer, "tex t0\n" );
	//strcat( shader_buffer, "tex t1\n" );
	//
	//switch( p_material->m_passes )
	//{
	//	case 2:
	//	{
	//		Dbg_Assert( ignore_bf <= 0x03 );
	//
	//		if( mcm )
	//		{
	//			// Modulate texture0 and texture 1 color with pass 0 and pass 1 material color, and place into t0.rgb and t1.rgb.
	//			strcat( shader_buffer, "xmma		t0.rgb,t1.rgb,discard.rgb,t0.rgb,c0.rgb,t1.rgb,c1.rgb\n" );
	//			
	//			// Modulate result color with vertex color.
	//			strcat( shader_buffer, "xmma_x4		r0.rgb,r1.rgb,discard.rgb,t0.rgb,v0.rgb,t1.rgb,v0.rgb\n" );
	//
	//			// Modulate result alpha with vertex alpha (or constant alpha = 0.5 for those passes that ignore alpha).
	//			if( ignore_bf == 0x00 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,v0.a\n" );
	//			}
	//			else if( ignore_bf == 0x01 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,v0.a\n" );
	//			}
	//			else if( ignore_bf == 0x02 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,c4.a\n" );
	//			}
	//			else if( ignore_bf == 0x03 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,c4.a\n" );
	//			}
	//		}
	//		else
	//		{
	//			// Modulate texture0 and texture1 color with vertex color.
	//			strcat( shader_buffer, "xmma_x2		r0.rgb,r1.rgb,discard.rgb,t0.rgb,v0.rgb,t1.rgb,v0.rgb\n" );
	//
	//			// Modulate texture0 and tetxure1 alpha with vertex alpha (or constant alpha = 0.5 for those passes that ignore alpha).
	//			if( ignore_bf == 0x00 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,v0.a\n" );
	//			}
	//			else if( ignore_bf == 0x01 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,v0.a\n" );
	//			}
	//			else if( ignore_bf == 0x02 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,c4.a\n" );
	//			}
	//			else if( ignore_bf == 0x03 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,c4.a\n" );
	//			}
	//		}
	//
	//		// Then deal with the second pass blend.
	//		switch( blend_modes[1] )
	//		{
	//			case vBLEND_MODE_ADD:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_ADD_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUBTRACT:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,-r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUB_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,-c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r1.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_FIXED:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,c1.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,r1.a\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE_FIXED:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,c1.a\n" );
	//			}
	//			case vBLEND_MODE_BRIGHTEN:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BRIGHTEN_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r0.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r0.a,r0.rgb,r1.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_GLOSS_MAP:
	//			{
	//				strcat( shader_buffer, "mul v1.rgb,v1.rgb,t1.a\n" );
	//				break;
	//			}
	//		}
	//		break;
	//	}
	//
	//	case 3:
	//	{
	//		Dbg_Assert( ignore_bf <= 0x07 );
	//
	//		strcat( shader_buffer, "tex t2\n" );
	//
	//		if( mcm )
	//		{
	//			// Modulate texture0 and texture 1 color with pass 0 and pass 1 material color, and place into t0.rgb and t1.rgb.
	//			strcat( shader_buffer, "xmma		t0.rgb,t1.rgb,discard.rgb,t0.rgb,c0.rgb,t1.rgb,c1.rgb\n" );
	//			
	//			// Modulate result color with vertex color.
	//			strcat( shader_buffer, "xmma_x4		r0.rgb,r1.rgb,discard.rgb,t0.rgb,v0.rgb,t1.rgb,v0.rgb\n" );
	//
	//			// Modulate result alpha with vertex alpha (or constant alpha = 0.5 for those passes that ignore alpha).
	//			if(( ignore_bf & 0x03 ) == 0x00 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,v0.a\n" );
	//			}
	//			else if(( ignore_bf & 0x03 ) == 0x01 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,v0.a\n" );
	//			}
	//			else if(( ignore_bf & 0x03 ) == 0x02 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,c4.a\n" );
	//			}
	//			else if(( ignore_bf & 0x03 ) == 0x03 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,c4.a\n" );
	//			}
	//
	//			// Modulate texture2 with pass 2 material color.
	//			strcat( shader_buffer, "mul			t2.rgb,t2.rgb,c2.rgb\n" );
	//
	//			// Modulate result color with vertex color.
	//			strcat( shader_buffer, "mul_x4		t2.rgb,t2.rgb,v0.rgb\n" );
	//
	//			// Modulate result alpha with vertex alpha (or constant alpha = 0.5 for those passes that ignore alpha).
	//			if(( ignore_bf & 0x04 ) == 0x00 )
	//			{
	//				// Pass2 modulates with vertex alpha.
	//				strcat( shader_buffer, "+mul_x2		t2.a,t2.a,v0.a\n" );
	//			}
	//			else if(( ignore_bf & 0x04 ) == 0x04 )
	//			{
	//				// Pass2 modulates with constant alpha.
	//				strcat( shader_buffer, "+mul_x2		t2.a,t2.a,c4.a\n" );
	//			}
	//		}
	//		else
	//		{
	//			// Modulate texture0 and texture1 with vertex color.
	//			strcat( shader_buffer, "xmma_x2	r0,r1,discard,t0,v0,t1,v0\n" );
	//
	//			// Modulate texture2 with vertex color.
	//			strcat( shader_buffer, "mul_x2	t2,t2,v0\n" );
	//		}
	//
	//		// Then deal with the second pass blend.
	//		switch( blend_modes[1] )
	//		{
	//			case vBLEND_MODE_ADD:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_ADD_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUBTRACT:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,-r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUB_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,-c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r1.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_FIXED:
	//			{
	//				strcat( shader_buffer, "lrp	r0.rgb,c1.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,r1.a\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE_FIXED:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,c1.a\n" );
	//			}
	//			case vBLEND_MODE_BRIGHTEN:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BRIGHTEN_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r0.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r0.a,r0.rgb,r1.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_GLOSS_MAP:
	//			{
	//				strcat( shader_buffer, "mul v1.rgb,v1.rgb,t1.a\n" );
	//				break;
	//			}
	//		}
	//		
	//		// Then deal with the third pass blend.
	//		switch( blend_modes[2] )
	//		{
	//			case vBLEND_MODE_ADD:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,t2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_ADD_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,c2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUBTRACT:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,-t2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUB_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,-c2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,t2.a,t2.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_FIXED:
	//			{
	//				strcat( shader_buffer, "lrp	r0.rgb,c2.a,t2.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,t2.a\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE_FIXED:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,c2.a\n" );
	//			}
	//			case vBLEND_MODE_BRIGHTEN:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,t2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BRIGHTEN_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,c2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r1.a,t2.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r1.a,r0.rgb,t2.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_GLOSS_MAP:
	//			{
	//				strcat( shader_buffer, "mul v1.rgb,v1.rgb,t2.a\n" );
	//				break;
	//			}
	//		}
	//
	//		break;
	//	}
	//
	//	case 4:
	//	{
	//		Dbg_Assert( ignore_bf <= 0x0F );
	//
	//		strcat( shader_buffer, "tex t2\n" );
	//		strcat( shader_buffer, "tex t3\n" );
	//
	//		if( mcm )
	//		{
	//			// Modulate texture0 and texture 1 color with pass 0 and pass 1 material color, and place into t0.rgb and t1.rgb.
	//			strcat( shader_buffer, "xmma		t0.rgb,t1.rgb,discard.rgb,t0.rgb,c0.rgb,t1.rgb,c1.rgb\n" );
	//			
	//			// Modulate result color with vertex color.
	//			strcat( shader_buffer, "xmma_x4		r0.rgb,r1.rgb,discard.rgb,t0.rgb,v0.rgb,t1.rgb,v0.rgb\n" );
	//
	//			// Modulate result alpha with vertex alpha (or constant alpha = 0.5 for those passes that ignore alpha).
	//			if(( ignore_bf & 0x03 ) == 0x00 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,v0.a\n" );
	//			}
	//			else if(( ignore_bf & 0x03 ) == 0x01 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,v0.a\n" );
	//			}
	//			else if(( ignore_bf & 0x03 ) == 0x02 )
	//			{
	//				// Pass0 modulates with vertex alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,v0.a,t1.a,c4.a\n" );
	//			}
	//			else if(( ignore_bf & 0x03 ) == 0x03 )
	//			{
	//				// Pass0 modulates with constant alpha. Pass1 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	r0.a,r1.a,discard.a,t0.a,c4.a,t1.a,c4.a\n" );
	//			}
	//
	//			// Modulate texture2 and texture 3 color with pass 2 and pass 3 material color, and place into t0.rgb and t1.rgb.
	//			strcat( shader_buffer, "xmma		t2.rgb,t3.rgb,discard.rgb,t2.rgb,c2.rgb,t3.rgb,c3.rgb\n" );
	//			
	//			// Modulate result color with vertex color.
	//			strcat( shader_buffer, "xmma_x4		t2.rgb,t3.rgb,discard.rgb,t2.rgb,v0.rgb,t3.rgb,v0.rgb\n" );
	//
	//			// Modulate result alpha with vertex alpha (or constant alpha = 0.5 for those passes that ignore alpha).
	//			if(( ignore_bf & 0x0C ) == 0x00 )
	//			{
	//				// Pass2 modulates with vertex alpha. Pass3 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	t2.a,t3.a,discard.a,t2.a,v0.a,t3.a,v0.a\n" );
	//			}
	//			else if(( ignore_bf & 0x0C ) == 0x04 )
	//			{
	//				// Pass2 modulates with constant alpha. Pass3 modulates with vertex alpha.
	//				strcat( shader_buffer, "+xmma_x2	t2.a,t3.a,discard.a,t2.a,c4.a,t3.a,v0.a\n" );
	//			}
	//			else if(( ignore_bf & 0x0C ) == 0x08 )
	//			{
	//				// Pass2 modulates with vertex alpha. Pass3 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	t2.a,t3.a,discard.a,t2.a,v0.a,t3.a,c4.a\n" );
	//			}
	//			else if(( ignore_bf & 0x0C ) == 0x0C )
	//			{
	//				// Pass2 modulates with constant alpha. Pass3 modulates with constant alpha.
	//				strcat( shader_buffer, "+xmma_x2	t2.a,t3.a,discard.a,t2.a,c4.a,t3.a,c4.a\n" );
	//			}
	//		}
	//		else
	//		{
	//			// Modulate texture0 and texture1 with vertex color.
	//			strcat( shader_buffer, "xmma_x2		r0,r1,discard,t0,v0,t1,v0\n" );
	//
	//			// Modulate texture2 and texture3 with vertex color.
	//			strcat( shader_buffer, "xmma_x2		t2,t3,discard,t2,v0,t3,v0\n" );
	//		}
	//		
	//		// Then deal with the second pass blend.
	//		switch( blend_modes[1] )
	//		{
	//			case vBLEND_MODE_ADD:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_ADD_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUBTRACT:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,-r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUB_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r1.rgb,-c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r1.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_FIXED:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,c1.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,r1.a\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE_FIXED:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,c1.a\n" );
	//			}
	//			case vBLEND_MODE_BRIGHTEN:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,r1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BRIGHTEN_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,c1.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r0.a,r1.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r0.a,r0.rgb,r1.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_GLOSS_MAP:
	//			{
	//				strcat( shader_buffer, "mul v1.rgb,v1.rgb,t1.a\n" );
	//				break;
	//			}
	//		}
	//
	//		// Then deal with the third pass blend.
	//		switch( blend_modes[2] )
	//		{
	//			case vBLEND_MODE_ADD:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,t2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_ADD_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,c2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUBTRACT:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,-t2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUB_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t2.rgb,-c2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,t2.a,t2.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_FIXED:
	//			{
	//				strcat( shader_buffer, "lrp	r0.rgb,c2.a,t2.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,t2.a\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE_FIXED:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,c2.a\n" );
	//			}
	//			case vBLEND_MODE_BRIGHTEN:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,t2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BRIGHTEN_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,c2.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r1.a,t2.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,r1.a,r0.rgb,t2.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_GLOSS_MAP:
	//			{
	//				strcat( shader_buffer, "mul v1.rgb,v1.rgb,t2.a\n" );
	//				break;
	//			}
	//		}
	//		
	//		// Then deal with the fourth pass blend.
	//		switch( blend_modes[3] )
	//		{
	//			case vBLEND_MODE_ADD:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t3.rgb,t3.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_ADD_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t3.rgb,c3.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUBTRACT:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t3.rgb,-t3.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_SUB_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,t3.rgb,-c3.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,t3.a,t3.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_FIXED:
	//			{
	//				strcat( shader_buffer, "lrp	r0.rgb,c3.a,t3.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,t3.a\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_MODULATE_FIXED:
	//			{
	//				strcat( shader_buffer, "mul r0.rgb,r0.rgb,c3.a\n" );
	//			}
	//			case vBLEND_MODE_BRIGHTEN:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,t3.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BRIGHTEN_FIXED:
	//			{
	//				strcat( shader_buffer, "mad r0.rgb,r0.rgb,c3.a,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,t2.a,t3.rgb,r0.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
	//			{
	//				strcat( shader_buffer, "lrp r0.rgb,t2.a,r0.rgb,t3.rgb\n" );
	//				break;
	//			}
	//			case vBLEND_MODE_GLOSS_MAP:
	//			{
	//				strcat( shader_buffer, "mul v1.rgb,v1.rgb,t3.a\n" );
	//				break;
	//			}
	//		}
	//		break;
	//	}
	//}
	//
	//// Final combiner.
	//strcat( shader_buffer, "xfc prod, fog.rgb, sum, zero, 1 - fog.a, c4, r0.a\n" );
	//
	//LPXGBUFFER pCompiledShader;
	//HRESULT hr = XGAssembleShader(	"autogen.ps",									// Source file name, used in error messages.
	//								shader_buffer,									// A pointer to the source data.
	//								strlen( shader_buffer ),						// The source data length.
	//								SASM_SKIPPREPROCESSOR | SASM_SKIPVALIDATION,	// SASM_xxx flags. See xgraphics.h for a complete list.
	//								NULL,											// If constants are declared in the shader, they are written here. Pass NULL if you don't care.
	//								&pCompiledShader,								// The shader microcode is written here. Pass NULL if you don't care.
	//								NULL,											// Errors are written here. Pass NULL if you don't care.
	//								NULL,											// A human-readable listing is written here. Pass NULL if you don't want it.
	//								NULL,											// Used by the preprocessor. Can be NULL if you don't use #include in your source file.
	//								NULL,											// Passed unmodified to the pResolver function.
	//								NULL );											// Returns the type of shader that was assembled. Pass NULL if you don't care.
	//Dbg_Assert( hr == S_OK );
	//
	//// Copy the microcode into our buffer.
	//Dbg_Assert( pixel_shader_buffer_offset + pCompiledShader->size < PIXEL_SHADER_BUFFER_SIZE );
	//CopyMemory( pixel_shader_buffer + pixel_shader_buffer_offset, pCompiledShader->pData, pCompiledShader->size );
	//
	//// Generate a handle to this shader.
	//DWORD shader_handle;
	//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( pixel_shader_buffer + pixel_shader_buffer_offset ), &shader_handle );
	//
	//// Update the buffer offset now we have copied a new shader into the buffer.
	//pixel_shader_buffer_offset += pCompiledShader->size;
	//
	//// This was allocated during XGAssembleShader().
	//XGBuffer_Release( pCompiledShader );
	//
	//// Place the shader handle in the table.
	//sPixelShaderTable.PutItem( code, shader_handle );
	//
	//// Return the handle.
	//return shader_handle;
	//}
	return 0;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
//LWSS: stolen from retail windows thug.exe
const char aPs11TexT0MulR0[] = // aPs11TexT0MulR0
			"ps.1.1\r\n \
			tex t0 \r\n \
			mul r0.rgb, t0, c0 \r\n \
			+ mul_x2 r0.a, v0.a, t0.a \r\n \
			mul_x4	r0.rgb, v0, r0 \r\n";
IDirect3DPixelShader9* pixel_shader_buffer_aPs11TexT0MulR0 = NULL;

const char aPs11MulX2R0Rgb[] = // aPs11MulX2R0Rgb
"ps.1.1\r\n \
mul_x2	r0.rgb, v0, c0\r\n \
+ mov r0.a, v0.a\r\n";
IDirect3DPixelShader9* pixel_shader_buffer_aPs11MulX2R0Rgb = NULL;

const char aPs11TexT0MulX2[] = // aPs11TexT0MulX2
"ps.1.1\r\n \
tex t0\r\n \
mul_x2	r0,v0.a,t0.a\r\n";
IDirect3DPixelShader9* pixel_shader_buffer_aPs11TexT0MulX2 = NULL;

const char aPs11TexT0MulX2_0[] = // aPs11TexT0MulX2_0
"ps.1.1\r\n \
tex t0\r\n \
mul_x2 r0,c4.a,t0.a\r\n";
IDirect3DPixelShader9* pixel_shader_buffer_aPs11TexT0MulX2_0 = NULL;

const char aPs11TexT0MulR0_0[] = // aPs11TexT0MulR0_0
"ps.1.1 \r\n \
tex t0 \r\n \
mul r0.rgb,t0,c0 \r\n \
mul_x4 r0.rgb,v0,r0 \r\n \
+mul_x2 r0.a,c4.a,t0.a \r\n \0";
IDirect3DPixelShader9* pixel_shader_buffer_aPs11TexT0MulR0_0 = NULL;

#include <limits.h>

// LWSS: Should be done. Omitted Error ID3DXBuffer(NULL arg)
void create_pixel_shaders( void )
{
	static bool created_shaders = false;
	if( !created_shaders )
	{
		created_shaders = true;

		// lwss: Changes for PC 
		if (NxXbox::EngineGlobals.hasHLSLv101)
		{
			IDirect3DPixelShader9* dummy;
			ID3DXBuffer* buffer = NULL;
			LPD3DXBUFFER errMsg = NULL;
			D3DXAssembleShader(aPs11TexT0MulR0, strlen(aPs11TexT0MulR0), 0, 0, 0, &buffer, &errMsg);
			D3DDevice_CreatePixelShader((DWORD*)buffer->GetBufferPointer(), &pixel_shader_buffer_aPs11TexT0MulR0);
			buffer->Release();

			D3DXAssembleShader(aPs11MulX2R0Rgb, strlen(aPs11MulX2R0Rgb), 0, 0, 0, &buffer, &errMsg);
			D3DDevice_CreatePixelShader((DWORD*)buffer->GetBufferPointer(), &pixel_shader_buffer_aPs11MulX2R0Rgb);
			buffer->Release();

			D3DXAssembleShader(aPs11TexT0MulX2, strlen(aPs11TexT0MulX2), 0, 0, 0, &buffer, &errMsg);
			D3DDevice_CreatePixelShader((DWORD*)buffer->GetBufferPointer(), &pixel_shader_buffer_aPs11TexT0MulX2);
			buffer->Release();

			D3DXAssembleShader(aPs11TexT0MulX2_0, strlen(aPs11TexT0MulX2_0), 0, 0, 0, &buffer, &errMsg);
			D3DDevice_CreatePixelShader((DWORD*)buffer->GetBufferPointer(), &pixel_shader_buffer_aPs11TexT0MulX2_0);
			buffer->Release();

			D3DXAssembleShader(aPs11TexT0MulR0_0, strlen(aPs11TexT0MulR0_0), 0, 0, 0, &buffer, &errMsg);
			D3DDevice_CreatePixelShader((DWORD*)buffer->GetBufferPointer(), &pixel_shader_buffer_aPs11TexT0MulR0_0);
			buffer->Release();
		}
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader0PixelShader[0] ),						&PixelShader0 );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader0IVAPixelShader[0] ),					&PixelShader0IVA );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader1PixelShader[0] ),						&PixelShader1 );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader2PixelShader[0] ),						&PixelShader2 );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader3PixelShader[0] ),						&PixelShader3 );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader4PixelShader[0] ),						&PixelShader4 );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader5PixelShader[0] ),						&PixelShader5 );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderBrightenPixelShader[0] ),				&PixelShaderBrighten );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderBrightenIVAPixelShader[0] ),			&PixelShaderBrightenIVA );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderFocusBlurPixelShader[0] ),				&PixelShaderFocusBlur );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderFocusIntegratePixelShader[0] ),			&PixelShaderFocusIntegrate );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderFocusLookupIntegratePixelShader[0] ),	&PixelShaderFocusLookupIntegrate );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderNULLPixelShader[0] ),					&PixelShaderNULL );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderPointSpritePixelShader[0] ),			&PixelShaderPointSprite );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShaderBumpWaterPixelShader[0] ),				&PixelShaderBumpWater );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwPixelShader_ShadowBufferPixelShader[0] ),			&PixelShader_ShadowBuffer );
		//D3DDevice_CreatePixelShader((D3DPIXELSHADERDEF*)( &dwShadowBufferStaticGeomPSPixelShader[0] ),			&ShadowBufferStaticGeomPS );
	
		// Shouldn't be doing this here!
		pTextureProjectionDetailsTable = new Lst::HashTable< sTextureProjectionDetails >( 8 );

#		if 0
		// Light glow test code.
		sLightGlowDetails *p_details = new sLightGlowDetails;
		p_details->m_pos.Set( 0.0f, 48.0f, 0.0f );
		p_details->m_glow_radius	= 24.0f;
		p_details->m_current_radius	= 0.0f;
		p_details->m_test_radius	= 2.0f;
		p_details->m_radius_growth	= 0.2f;
		sLightGlowDetailsTable.PutItem( (uint32)p_details, p_details );

		p_details = new sLightGlowDetails;
		p_details->m_pos.Set( 60.0f, 48.0f, 0.0f );
		p_details->m_glow_radius	= 24.0f;
		p_details->m_current_radius	= 0.0f;
		p_details->m_test_radius	= 2.0f;
		p_details->m_radius_growth	= 0.2f;
		sLightGlowDetailsTable.PutItem( (uint32)p_details, p_details );

		p_details = new sLightGlowDetails;
		p_details->m_pos.Set( -60.0f, 48.0f, 0.0f );
		p_details->m_glow_radius	= 24.0f;
		p_details->m_current_radius	= 0.0f;
		p_details->m_test_radius	= 2.0f;
		p_details->m_radius_growth	= 0.2f;
		sLightGlowDetailsTable.PutItem( (uint32)p_details, p_details );
#		endif
	}
}
	
	

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void GetPixelShader( sMaterial *p_material, IDirect3DPixelShader9 **p_pixel_shader_id )
{
	if( p_material->m_passes == 1 )
	{
		// There are only 2 shader for single pass materials, depending on whether a texture is required.
		if( p_material->mp_tex[0] == NULL )
		{
			//*p_pixel_shader_id = PixelShader1;
			*p_pixel_shader_id = pixel_shader_buffer_aPs11MulX2R0Rgb;
		}
		else
		{
			uint32 ignore_bf = p_material->GetIgnoreVertexAlphaPasses();

			if(( p_material->m_reg_alpha[0] & sMaterial::BLEND_MODE_MASK ) == vBLEND_MODE_BRIGHTEN )
			{
				// The single pass mode is brighten, which requires special handling.
				if (ignore_bf == 0)
				{
					//*p_pixel_shader_id = PixelShaderBrighten;
					*p_pixel_shader_id = pixel_shader_buffer_aPs11TexT0MulX2;
				}
				else
				{
					//*p_pixel_shader_id = PixelShaderBrightenIVA;
					*p_pixel_shader_id = pixel_shader_buffer_aPs11TexT0MulX2_0;
				}
			}
			else
			{
				if (ignore_bf == 0)
				{
					//*p_pixel_shader_id = PixelShader0;
					*p_pixel_shader_id = pixel_shader_buffer_aPs11TexT0MulR0;
				}
				else
				{
					//*p_pixel_shader_id = PixelShader0IVA;
					*p_pixel_shader_id = pixel_shader_buffer_aPs11TexT0MulR0_0;
				}
			}
		}
	}
	else
	{
		// Get the pixel shader.
		*p_pixel_shader_id = get_pixel_shader( p_material );
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// lwss: Done
void set_texture( uint32 pass, IDirect3DTexture9 *p_texture )
{
	// LWSS: totally gimped for dx9
	if (EngineGlobals.p_texture[pass] != p_texture)
	{
		D3DDevice_SetTexture(pass, p_texture);
		EngineGlobals.p_texture[pass] = p_texture;
	}
	//if((IDirect3DTexture9*)( EngineGlobals.p_texture[pass] ) != p_texture )
	//
	//	// Use SwitchTexture() whenever possible. Cannot switch from or to a NULL texture. Also cannot
	//	// switch to a liner texture (in this case the calling code should perform a set_texture( NULL )
	//	// call first, to force D3DDevice_SetTexture() to be called for the linear texture.
	//	// LWSS: Removed Most of this for PC
	//	//if(( p_texture != NULL ) && ( EngineGlobals.p_texture[pass] != NULL ))
	//	//{
	//	//	EngineGlobals.p_Device->SwitchTexture( pass, (LPDIRECT3DBASETEXTURE8)( p_texture ));
	//	//}
	//	//else
	//	//{
	//		D3DDevice_SetTexture( pass, (LPDIRECT3DBASETEXTURE8)( p_texture ));
	//	//}
	//	//
	//	//if( p_palette )
	//	//{
	//	//	D3DDevice_SetPalette( pass, p_palette );
	//	//}
	//	// LWSS end
	//	
	//	EngineGlobals.p_texture[pass] = p_texture;
	//
}

				
				
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
//lwss: should be done.
//LWSS: double checked for accuracy. Should be 99%
void set_blend_mode( uint32 mode )
{
	if( NxXbox::EngineGlobals.blend_mode_override )
	{
		mode = NxXbox::EngineGlobals.blend_mode_override;
	}

	// Only do something if the blend mode is changing.
	if( mode != EngineGlobals.blend_mode_value )
	{
		// Low 24 bits contain the mode, high 8 bits contain the fixed alpha value.
		uint32 modeLower24bits = ( mode & 0x00FFFFFFUL );

		if(modeLower24bits != ( EngineGlobals.blend_mode_value & 0x00FFFFFFUL ))
		{
			// For additive and subtractive, we set the fog color to black.
			if( EngineGlobals.fog_enabled )
			{
				if( (modeLower24bits >= vBLEND_MODE_ADD) && (modeLower24bits <= vBLEND_MODE_SUB_FIXED))
				{
					D3DDevice_SetRenderState( D3DRS_FOGCOLOR, 0x00000000UL );
				}
				else
				{
					D3DDevice_SetRenderState( D3DRS_FOGCOLOR, NxXbox::EngineGlobals.fog_color );
				}
			}

			int blend_op, src_blend, dest_blend;

			switch( modeLower24bits )
			{
				case vBLEND_MODE_DIFFUSE:			// ( 0 - 0 ) * 0 + Src
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_ONE;
					dest_blend	= D3DBLEND_ZERO;
					break;				
				}
				case vBLEND_MODE_GLOSS_MAP:
				{
					// Treat as diffuse for now.
					blend_op = D3DBLENDOP_ADD;
					src_blend = D3DBLEND_ONE;
					dest_blend = D3DBLEND_ZERO;
					break;
				}
				case vBLEND_MODE_ADD:				// ( Src - 0 ) * Src + Dst
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_SRCALPHA;
					dest_blend	= D3DBLEND_ONE;
					break;				
				}
				case vBLEND_MODE_ADD_FIXED:			// ( Src - 0 ) * Fixed + Dst
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_BLENDFACTOR;
					dest_blend	= D3DBLEND_ONE;
					break;				
				}
				case vBLEND_MODE_SUBTRACT:			// ( 0 - Src ) * Src + Dst
				{
					blend_op	= D3DBLENDOP_REVSUBTRACT;
					src_blend	= D3DBLEND_SRCALPHA;
					dest_blend	= D3DBLEND_ONE;
					break;				
				}
				case vBLEND_MODE_SUB_FIXED:			// ( 0 - Src ) * Fixed + Dst
				{
					blend_op	= D3DBLENDOP_REVSUBTRACT;
					src_blend	= D3DBLEND_BLENDFACTOR;
					dest_blend	= D3DBLEND_ONE;
					break;				
				}
				case vBLEND_MODE_BLEND:				// ( Src - Dst ) * Src + Dst	
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_SRCALPHA;
					dest_blend	= D3DBLEND_INVSRCALPHA;
					break;				
				}
				case vBLEND_MODE_BLEND_PREVIOUS_MASK:
				{
					// Meaningless unless destination alpha is enabled.
					blend_op = D3DBLENDOP_ADD;
					//src_blend = D3DBLEND_DESTALPHA;
					src_blend = D3DBLEND_SRCALPHA;
					//dest_blend = D3DBLEND_INVDESTALPHA;
					dest_blend = D3DBLEND_INVSRCALPHA;
					break;
				}
				case vBLEND_MODE_BLEND_FIXED:		// ( Src - Dst ) * Fixed + Dst	
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_BLENDFACTOR;
					dest_blend	= D3DBLEND_INVBLENDFACTOR;
					break;				
				}
				case vBLEND_MODE_MODULATE:			// ( Dst - 0 ) * Src + 0
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_ZERO;
					dest_blend	= D3DBLEND_SRCALPHA;
					break;				
				}
				case vBLEND_MODE_MODULATE_FIXED:	// ( Dst - 0 ) * Fixed + 0	
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_ZERO;
					//dest_blend	= D3DBLEND_BLENDFACTOR;
					dest_blend	= D3DBLEND_SRCALPHA;
					break;				
				}
				case vBLEND_MODE_BRIGHTEN:			// ( Dst - 0 ) * Src + Dst
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_DESTCOLOR;
					dest_blend	= D3DBLEND_ONE;
					break;				
				}
				case vBLEND_MODE_BRIGHTEN_FIXED:	// ( Dst - 0 ) * Fixed + Dst	
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_DESTCOLOR;
					dest_blend	= D3DBLEND_BLENDFACTOR;
					break;				
				}
				case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
				{
					// Meaningless unless destination alpha is enabled.
					blend_op	= D3DBLENDOP_ADD;
					//src_blend	= D3DBLEND_INVDESTALPHA;
					src_blend	= D3DBLEND_INVSRCALPHA;
					//dest_blend	= D3DBLEND_DESTALPHA;
					dest_blend	= D3DBLEND_SRCALPHA;
					break;
				}
				case vBLEND_MODE_MODULATE_COLOR:	// ( Dst - 0 ) * Src(col) + 0 - specially for the shadow.
				{
					blend_op = D3DBLENDOP_ADD;
					src_blend = D3DBLEND_ZERO;
					dest_blend = D3DBLEND_SRCCOLOR;
					break;
				}
				case vBLEND_MODE_ONE_INV_SRC_ALPHA:
				{
					blend_op	= D3DBLENDOP_ADD;
					src_blend	= D3DBLEND_ONE;
					dest_blend	= D3DBLEND_INVSRCALPHA;
					break;
				}
				default:
				{
					__debugbreak();
					Dbg_Assert( 0 );
					break;
				}
			}

			// lwss add
			if (!EngineGlobals.dontConvertBlendModes)
			{
				if (src_blend == D3DBLEND_BLENDFACTOR)
				{
					if (dest_blend == D3DBLEND_INVBLENDFACTOR)
					{
						src_blend = D3DBLEND_ONE;
						dest_blend = D3DBLEND_INVSRCALPHA;
					}
					else
					{
						src_blend = D3DBLEND_ZERO;
					}
				}
				if (dest_blend == D3DBLEND_BLENDFACTOR)
				{
					dest_blend = D3DBLEND_SRCALPHA;
				}
				else if (dest_blend == D3DBLEND_INVBLENDFACTOR)
				{
					dest_blend = D3DBLEND_INVSRCALPHA;
				}
			}
			// lwss end

			// Now set the values if they have changed.
			if( blend_op != EngineGlobals.blend_op )
			{
				D3DDevice_SetRenderState( D3DRS_BLENDOP, blend_op );
				EngineGlobals.blend_op	= blend_op;
			}
			if( src_blend != EngineGlobals.src_blend )
			{
				D3DDevice_SetRenderState( D3DRS_SRCBLEND, src_blend );
				EngineGlobals.src_blend	= src_blend;
			}
			if( dest_blend != EngineGlobals.dest_blend )
			{
				D3DDevice_SetRenderState( D3DRS_DESTBLEND, dest_blend );
				EngineGlobals.dest_blend = dest_blend;
			}
		}

		// Change the fixed alpha value if different.
		if(( mode & 0xFF000000UL ) != ( EngineGlobals.blend_mode_value & 0xFF000000UL ))
		{
			uint32 fixed_alpha	= mode & 0xFF000000UL;
			fixed_alpha			= fixed_alpha >= 0x80000000UL ? 0xFF000000UL : ( fixed_alpha << 1 );
			//D3DDevice_SetRenderState( D3DRS_BLENDCOLOR,	fixed_alpha );
			//LWSS: this is a bit bizarre
			D3DDevice_SetRenderState(D3DRS_BLENDFACTOR, fixed_alpha | ((fixed_alpha | ((fixed_alpha | (fixed_alpha >> 8)) >> 8)) >> 8));
		}

		// Set the new blend mode value.
		EngineGlobals.blend_mode_value	= mode;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void set_vertex_shader( DWORD shader_id )
{
	if( EngineGlobals.vertex_shader_override == 0 )
	{
		if( EngineGlobals.vertex_shader_id != shader_id )
		{
			// Set vertex shader.
			//D3DDevice_SetVertexShader( shader_id );
			if (D3D_OK != D3DDevice_SetFVF(shader_id)) // lwss add for PC
			{
				__debugbreak();
			}
			EngineGlobals.vertex_shader_id = shader_id;
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// lwss: changed for PC
// Done!
//void set_pixel_shader( uint32 shader_id )
void set_pixel_shader(IDirect3DPixelShader9* shader_id )
{
	if (EngineGlobals.hasHLSLv101)
	{
		if (EngineGlobals.pixel_shader_override == 0)
		{
			if (EngineGlobals.pixel_shader_id != shader_id)
			{
				// Set pixel shader.
				D3DDevice_SetPixelShader(shader_id);
				EngineGlobals.pixel_shader_id = shader_id;

				// Changing pixel shader invalidates the constants, so we need to upload.
				EngineGlobals.upload_pixel_shader_constants = true;
			}

			// Upload any pixel shader constants if required.
			if (EngineGlobals.upload_pixel_shader_constants)
			{
				//D3DDevice_SetPixelShaderConstant(0, EngineGlobals.pixel_shader_constants, 5);
				D3DDevice_SetPixelShaderConstantF(0, EngineGlobals.pixel_shader_constants, 5);
			}
		}

		// Want to clear this field even if the override is set, since otherwise it will persist and cause problems later.
		EngineGlobals.upload_pixel_shader_constants = false;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void set_pixel_shader(IDirect3DPixelShader9* shader_id, uint32 num_passes )
{
	// LWSS: Changes for PC
	if( EngineGlobals.pixel_shader_override == 0 )
	{
		if( EngineGlobals.pixel_shader_id != shader_id )
		{
			// Set pixel shader.
			if (D3DDevice_SetPixelShader(shader_id) != D3D_OK)
			{
				__debugbreak();
			}
			EngineGlobals.pixel_shader_id = shader_id;

			// Changing pixel shader invalidates the constants, so we need to upload.
			EngineGlobals.upload_pixel_shader_constants = true;
		}
		else
		{
			if (!EngineGlobals.upload_pixel_shader_constants)
			{
				EngineGlobals.upload_pixel_shader_constants = false;
				return;
			}
		}
			
		// Upload any pixel shader constants if required.
		if( EngineGlobals.upload_pixel_shader_constants && ( shader_id > 0 ))
		{
			D3DDevice_SetPixelShaderConstantF( 0, &EngineGlobals.pixel_shader_constants[0], num_passes );
			D3DDevice_SetPixelShaderConstantF( 4, &EngineGlobals.pixel_shader_constants[16], 1 );
		}
	}

	// Want to clear this field even if the override is set, since otherwise it will persist and cause problems later.
	EngineGlobals.upload_pixel_shader_constants = false;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: function double checked for accuracy. Should be pristine.
void set_render_state( uint32 type, uint32 state )
{
	switch( type )
	{
		case RS_ZBIAS:
		{
			if( state != EngineGlobals.z_bias )
			{
				EngineGlobals.z_bias = state;
				// *(float *)&v13 = (double)state * -0.0000009999999974752427;
				// lwss: wtf ^^
				DWORD v13;
				*(float *)&v13 = (double)state * -0.0000009999999974752427;
				//D3DDevice_SetRenderState( D3DRS_ZBIAS, state );
				D3DDevice_SetRenderState(D3DRS_DEPTHBIAS, v13);
			}
			break;
		}

		case RS_CULLMODE:
		{
			if( state != EngineGlobals.cull_mode )
			{
				EngineGlobals.cull_mode = state;
				D3DDevice_SetRenderState( D3DRS_CULLMODE, state );
			}
			break;
		}

		case RS_ALPHABLENDENABLE:
		{
			if( state != EngineGlobals.alpha_blend_enable )
			{
				EngineGlobals.alpha_blend_enable = state;
				D3DDevice_SetRenderState( D3DRS_ALPHABLENDENABLE, ( state > 0 ) ? TRUE : FALSE );
			}
			break;
		}

		case RS_ALPHATESTENABLE:
		{
			if( state != EngineGlobals.alpha_test_enable )
			{
				EngineGlobals.alpha_test_enable = state;
				D3DDevice_SetRenderState( D3DRS_ALPHATESTENABLE, ( state > 0 ) ? TRUE : FALSE );
			}
			break;
		}

		case RS_ZWRITEENABLE:
		{
			if( state )
			{
				if( EngineGlobals.z_write_enabled == FALSE )
				{
					D3DDevice_SetRenderState( D3DRS_ZWRITEENABLE, TRUE );
					EngineGlobals.z_write_enabled = TRUE;
				}
			}
			else
			{
				if( EngineGlobals.z_write_enabled == TRUE )
				{
					D3DDevice_SetRenderState( D3DRS_ZWRITEENABLE, FALSE );
					EngineGlobals.z_write_enabled = FALSE;
				}
			}
			break;
		}

		case RS_ZTESTENABLE:
		{
			if( state > 0 )
			{
				if( EngineGlobals.z_test_enabled == FALSE )
				{
					D3DDevice_SetRenderState( D3DRS_ZFUNC, D3DCMP_LESSEQUAL );
					EngineGlobals.z_test_enabled = TRUE;
				}
			}
			else
			{
				if( EngineGlobals.z_test_enabled == TRUE )
				{
					D3DDevice_SetRenderState( D3DRS_ZFUNC, D3DCMP_ALWAYS );
					EngineGlobals.z_test_enabled = FALSE;
				}
			}
			break;
		}

		case RS_ALPHACUTOFF:
		{
			// Convert from state (where 1 means "render all pixels with alpha 1 or higher") to the D3D.
			// Also, if alpha cutoff is 1 or greater, enable alphakill, which can in some cases provide an earlier
			// rejection of the pixel.
			if( state != EngineGlobals.alpha_ref )
			{
				EngineGlobals.alpha_ref = state;
				if( state )
				{
					D3DDevice_SetRenderState( D3DRS_ALPHAREF,				state );

					// Enable alpha testing.
					if( EngineGlobals.alpha_test_enable == 0 )
					{
						D3DDevice_SetRenderState( D3DRS_ALPHATESTENABLE,	TRUE );
						EngineGlobals.alpha_test_enable = 1;
					}

					//lwss: removed for PC
					//D3DDevice_SetTextureStageState( 0, D3DTSS_ALPHAKILL,	D3DTALPHAKILL_ENABLE );
				}
				else
				{
					// Disable alpha testing.
					if( EngineGlobals.alpha_test_enable > 0 )
					{
						D3DDevice_SetRenderState( D3DRS_ALPHATESTENABLE,	FALSE );
						EngineGlobals.alpha_test_enable = 0;
					}

					//lwss: removed for PC
					//D3DDevice_SetTextureStageState( 0, D3DTSS_ALPHAKILL,	D3DTALPHAKILL_DISABLE );
				}
			}
			break;
		}
		
		case RS_SPECULARENABLE:
		{
			if( state != EngineGlobals.specular_enabled )
			{
				EngineGlobals.specular_enabled = state;

				if( state > 0 )
				{
					D3DDevice_SetRenderState( D3DRS_SPECULARENABLE, TRUE );
					D3DDevice_SetRenderState( D3DRS_LOCALVIEWER, TRUE );
				}
				else
				{
					D3DDevice_SetRenderState( D3DRS_SPECULARENABLE, FALSE );
					D3DDevice_SetRenderState( D3DRS_LOCALVIEWER, FALSE );
				}
			}
			break;
		}

		case RS_FOGENABLE:
		{
			if( state != EngineGlobals.fog_enabled )
			{
				EngineGlobals.fog_enabled = state;
				D3DDevice_SetRenderState( D3DRS_FOGENABLE, ( state > 0 ) ? TRUE : FALSE );
			}
			break;
		}

		case RS_UVADDRESSMODE0:
		case RS_UVADDRESSMODE1:
		case RS_UVADDRESSMODE2:
		case RS_UVADDRESSMODE3:
		{
			int pass = type - RS_UVADDRESSMODE0;
			if(( state & 0xFFFFUL ) != ( EngineGlobals.uv_addressing[pass] & 0xFFFFUL ))
			{
				switch( state & 0xFFFFUL )
				{
					case 0x0000U:
					{
						//LWSS: Dx9 doesn't have this - use SetSamplerState Instead
						//D3DDevice_SetTextureStageState( pass, D3DTSS_ADDRESSU, D3DTADDRESS_WRAP );
						D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSU, D3DTADDRESS_WRAP);
						break;
					}
					case 0x0001U:
					{
						//D3DDevice_SetTextureStageState( pass, D3DTSS_ADDRESSU, D3DTADDRESS_CLAMP );
						D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSU, D3DTADDRESS_CLAMP);
						break;
					}
					case 0x0002U:
					{
						//D3DDevice_SetTextureStageState( pass, D3DTSS_ADDRESSU, D3DTADDRESS_BORDER );
						// LWSS: new for PC
						if (EngineGlobals.has_D3DPTADDRESSCAPS_BORDER)
						{
							D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSU, D3DTADDRESS_BORDER);
						}
						else
						{
							D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSU, D3DTADDRESS_CLAMP);
						}
						break;
					}
					default:
					{
						Dbg_Assert( 0 );
						break;
					}
				}
				EngineGlobals.uv_addressing[pass] = ( EngineGlobals.uv_addressing[pass] & 0xFFFF0000UL ) | ( state & 0xFFFFUL );
			}

			if(( state & 0xFFFF0000UL ) != ( EngineGlobals.uv_addressing[pass] & 0xFFFF0000UL ))
			{
				switch( state & 0xFFFF0000UL )
				{
					case 0x00000000UL:
					{
						// LWSS: Same thing here, need sampler commands instead of fixed-function dx8 
						//D3DDevice_SetTextureStageState( pass, D3DTSS_ADDRESSV, D3DTADDRESS_WRAP );
						D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSV, D3DTADDRESS_WRAP);
						break;
					}
					case 0x00010000UL:
					{
						//D3DDevice_SetTextureStageState( pass, D3DTSS_ADDRESSV, D3DTADDRESS_CLAMP );
						D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSV, D3DTADDRESS_CLAMP);
						break;
					}
					case 0x00020000UL:
					{
						//D3DDevice_SetTextureStageState(pass, D3DTSS_ADDRESSV, D3DTADDRESS_BORDER);
						// LWSS: new for PC
						if (EngineGlobals.has_D3DPTADDRESSCAPS_BORDER)
						{
							D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSV, D3DTADDRESS_BORDER);
						}
						else
						{
							D3DDevice_SetSamplerState(pass, D3DSAMP_ADDRESSV, D3DTADDRESS_CLAMP);
						}
						break;
					}
					default:
					{
						Dbg_Assert( 0 );
						break;
					}
				}
				EngineGlobals.uv_addressing[pass] = ( EngineGlobals.uv_addressing[pass] & 0x0000FFFFUL ) | ( state & 0xFFFF0000UL );
			}
			break;
		}

		case RS_MIPLODBIASPASS0:
		case RS_MIPLODBIASPASS1:
		case RS_MIPLODBIASPASS2:
		case RS_MIPLODBIASPASS3:
		{
			int pass = type - RS_MIPLODBIASPASS0;
			if( state != EngineGlobals.mip_map_lod_bias[pass] )
			{
				// LWSS: Same thing here, need sampler commands instead of fixed-function dx8 
				//D3DDevice_SetTextureStageState( pass, D3DTSS_MIPMAPLODBIAS, state );
				D3DDevice_SetSamplerState( pass, D3DSAMP_MIPMAPLODBIAS, state );
				EngineGlobals.mip_map_lod_bias[pass] = state;
			}
			break;
		}

		case RS_MINMAGFILTER0:
		case RS_MINMAGFILTER1:
		case RS_MINMAGFILTER2:
		case RS_MINMAGFILTER3:
		{
			int pass = type - RS_MINMAGFILTER0;

			// Magnification filter.
			state = state & 0xFFFF0000UL;
			if( state != EngineGlobals.min_mag_filter[pass] )
			{
				if( state == 0x00000000UL )
				{
					// LWSS: Same thing here, need sampler commands instead of fixed-function dx8 
					// Point.
					//D3DDevice_SetTextureStageState( pass, D3DTSS_MAGFILTER, D3DTEXF_POINT );
					D3DDevice_SetSamplerState( pass, D3DSAMP_MAGFILTER, D3DTEXF_POINT );
				}
				else
				{
					// Linear.
					//D3DDevice_SetTextureStageState( pass, D3DTSS_MAGFILTER, D3DTEXF_LINEAR );
					D3DDevice_SetSamplerState( pass, D3DSAMP_MAGFILTER, D3DTEXF_LINEAR );
				}
				EngineGlobals.min_mag_filter[pass] = state;
			}
			break;
		}
		// lwss add
		case RS_LOCALVIEWER:
		{
			if (state != EngineGlobals.is_d3drs_localviewer_on)
			{
				EngineGlobals.is_d3drs_localviewer_on = (state != 0);
				D3DDevice_SetRenderState(D3DRS_LOCALVIEWER, state);
			}
			break;
		}
		// lwss end
	}
}











/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void create_texture_projection_details( sTexture *p_texture, Nx::CXboxModel *p_model, sScene *p_scene )
{
	// LWSS hack for pc...
	if (!p_scene)
	{
		for (int i = 0; i < Nx::CEngine::MAX_LOADED_SCENES; i++)
		{
			if (Nx::CEngine::sp_loaded_scenes[i])
			{
				Nx::CXboxScene* pXboxScene = static_cast<Nx::CXboxScene*>(Nx::CEngine::sp_loaded_scenes[i]);

				if (!pXboxScene->IsSky())
				{
					p_scene = (sScene*)pXboxScene;
					break;
				}
			}
		}
	}

	// LWSS end
	sTextureProjectionDetails *p_details = new sTextureProjectionDetails;

	p_details->p_model		= p_model;
	p_details->p_scene		= p_scene;
	p_details->p_texture	= p_texture;
	
	XGMatrixIdentity( &p_details->view_matrix );
	XGMatrixIdentity( &p_details->projection_matrix );
	
	pTextureProjectionDetailsTable->PutItem((uint32)p_texture, p_details );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void destroy_texture_projection_details( sTexture *p_texture )
{
	sTextureProjectionDetails *p_details = pTextureProjectionDetailsTable->GetItem((uint32)p_texture );
	if( p_details )
	{
		pTextureProjectionDetailsTable->FlushItem((uint32)p_texture );
		delete p_details;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void set_texture_projection_camera( sTexture *p_texture, XGVECTOR3 *p_pos, XGVECTOR3 *p_at )
{
	sTextureProjectionDetails *p_details = pTextureProjectionDetailsTable->GetItem((uint32)p_texture );
	if( p_details )
	{
		// Check for 'straight down' vector.
		if(( p_pos->x == p_at->x ) && ( p_pos->z == p_at->z ))
		{
			XGMatrixLookAtRH( &p_details->view_matrix, p_pos, p_at, &XGVECTOR3( 0.0f, 0.0f, 1.0f ));
		}
		else
		{
			XGMatrixLookAtRH( &p_details->view_matrix, p_pos, p_at, &XGVECTOR3( 0.0f, 1.0f, 0.0f ));
		}
		XGMatrixOrthoRH( &p_details->projection_matrix, 96.0f, 96.0f, 1.0f, 128.0f );
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// MSM PERFCHANGE - added scale.
void set_camera( Mth::Matrix *p_matrix, Mth::Vector *p_position, float screen_angle, float aspect_ratio, bool render_at_infinity )
{
	EngineGlobals.cam_position.x	= p_position->GetX();
	EngineGlobals.cam_position.y	= p_position->GetY();
	EngineGlobals.cam_position.z	= p_position->GetZ();
	
	EngineGlobals.cam_at.x			= p_matrix->GetAt().GetX();
	EngineGlobals.cam_at.y			= p_matrix->GetAt().GetY();
	EngineGlobals.cam_at.z			= p_matrix->GetAt().GetZ();
	
	EngineGlobals.cam_up.x			= p_matrix->GetUp().GetX();
	EngineGlobals.cam_up.y			= p_matrix->GetUp().GetY();
	EngineGlobals.cam_up.z			= p_matrix->GetUp().GetZ();
	
	XGMatrixIdentity( &EngineGlobals.world_matrix );

	// XGMatrixLookAtRH() takes an 'at' position rather than a direction, so we need it relative to the camera position.
	XGVECTOR3	at;
	at.x	= EngineGlobals.cam_position.x - EngineGlobals.cam_at.x;
	at.y	= EngineGlobals.cam_position.y - EngineGlobals.cam_at.y;
	at.z	= EngineGlobals.cam_position.z - EngineGlobals.cam_at.z;
	XGMatrixLookAtRH( &EngineGlobals.view_matrix, &EngineGlobals.cam_position, &at, &EngineGlobals.cam_up );

	EngineGlobals.near_plane	= 2.0f;
	//EngineGlobals.far_plane		= 32000.0f;
	EngineGlobals.far_plane		= 64000.0f; // lwss change for PC
	EngineGlobals.screen_angle	= screen_angle;

	// Figure width and height of viewport at near clip plane.
	float half_screen_angle_in_radians	= Mth::DegToRad( screen_angle * 0.5f );
	float width							= EngineGlobals.near_plane * 2.0f * tanf( half_screen_angle_in_radians );

// lwss Remove for PC
#ifndef __PLAT_WN32__
	if( EngineGlobals.backbuffer_width == 640.0f )
	{
		// We need to adjust the aspect ratio for the Xbox, since it is now rendering with D3DPRESENTFLAG_10X11PIXELASPECTRATIO
		// set. This changes the regular aspect ratio from 4:3 to 4:3.3, so adjust the value here.
		// KISAKTODO: Change for PC later
		aspect_ratio = aspect_ratio * (( 4.0f / 3.3f ) / ( 4.0f / 3.0f ));
	}
#endif
	
	float height	= width / aspect_ratio;
	// LWSS: Swap out xbox function
	//XGMatrixPerspectiveRH( &EngineGlobals.projection_matrix, width, height, EngineGlobals.near_plane, EngineGlobals.far_plane );
	D3DXMatrixPerspectiveRH((D3DXMATRIX*)&EngineGlobals.projection_matrix._11, width, height, 2.0f, EngineGlobals.far_plane);
	
	NxXbox::EngineGlobals.near_plane_width	= width;
	NxXbox::EngineGlobals.near_plane_height	= height;

	if( render_at_infinity )
	{
		// Rendering the sky, so set the projection transform up to calculate a constant z value of 1.0.
		// W value must remain correct however.
		EngineGlobals.projection_matrix.m[2][2] = -0.999999f;	// Setting this to -1.0f causes D3D to complain about WNear calculation.
		EngineGlobals.projection_matrix.m[3][2] =  0.0f;
	}
	
	D3DDevice_SetTransform( D3DTS_WORLD, &EngineGlobals.world_matrix );
	D3DDevice_SetTransform( D3DTS_VIEW, &EngineGlobals.view_matrix );
	D3DDevice_SetTransform( D3DTS_PROJECTION, &EngineGlobals.projection_matrix );

	// Set up view frustum values for bounding sphere culling.
	EngineGlobals.ViewFrustumTX	= tanf( Mth::DegToRad( screen_angle * 0.5f ));
	EngineGlobals.ViewFrustumTY	= -( EngineGlobals.ViewFrustumTX / aspect_ratio );
	EngineGlobals.ViewFrustumSX	= 1.0f / sqrtf( 1.0f + 1.0f / ( EngineGlobals.ViewFrustumTX * EngineGlobals.ViewFrustumTX ));
	EngineGlobals.ViewFrustumSY	= 1.0f / sqrtf( 1.0f + 1.0f / ( EngineGlobals.ViewFrustumTY * EngineGlobals.ViewFrustumTY ));
	EngineGlobals.ViewFrustumCX	= 1.0f / sqrtf( 1.0f + EngineGlobals.ViewFrustumTX * EngineGlobals.ViewFrustumTX );
	EngineGlobals.ViewFrustumCY	= 1.0f / sqrtf( 1.0f + EngineGlobals.ViewFrustumTY * EngineGlobals.ViewFrustumTY );

	// Set up matrix for offset bump mapping (the matrix that will be used to set the D3DTSS_BUMPENVMATnn texture states).
    float rotate_angle = atan2f( -EngineGlobals.cam_at.z, -EngineGlobals.cam_at.x );
	// LWSS: Swap out xbox function
	//XGMatrixRotationY( &EngineGlobals.bump_env_matrix, rotate_angle - D3DX_PI / 2 );
	// KISAKTODO: Might be RotationX
	D3DXMatrixRotationY(&EngineGlobals.bump_env_matrix, rotate_angle - D3DX_PI / 2);

	// Calculate vectors for billboard rendering.
	BillboardManager.SetCameraMatrix();
}



/******************************************************************/
/* Quick determination of if something is visible or not, uses	  */
/* the previously calculated s and c vectors and the			  */
/* WorldToCamera transform (note, no attempt is made to ensure	  */
/* this is the same camera that the object will eventually be	  */
/* rendered with.												  */
/******************************************************************/
bool IsVisible( Mth::Vector &center, float radius )
{
	XGVECTOR4 test_out;

	XGVec3Transform( &test_out, (XGVECTOR3*)&center[X], (XGMATRIX*)&EngineGlobals.view_matrix );

	if( -test_out.z + radius < EngineGlobals.near_plane )
		return false;

	float sx_z	= EngineGlobals.ViewFrustumSX * test_out.z;
	float cx_x	= EngineGlobals.ViewFrustumCX * test_out.x;
	if(( radius < sx_z - cx_x ) || ( radius < sx_z + cx_x ))
		return false;

	float sy_z	= EngineGlobals.ViewFrustumSY * test_out.z;
	float cy_y	= EngineGlobals.ViewFrustumCY * test_out.y;
	if(( radius < sy_z + cy_y ) || ( radius < sy_z - cy_y ))
		return false;

	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void set_frustum_bbox_transform( Mth::Matrix *p_transform )
{
	if( p_transform == NULL )
	{
		p_bbox_transform = NULL;
	}
	else
	{
		p_bbox_transform		= &bbox_transform;

		bbox_transform.m[0][0]	= ( *p_transform ).GetRight().GetX();
		bbox_transform.m[0][1]	= ( *p_transform ).GetRight().GetY();
		bbox_transform.m[0][2]	= ( *p_transform ).GetRight().GetZ();
		bbox_transform.m[0][3]	= 0.0f;

		bbox_transform.m[1][0]	= ( *p_transform ).GetUp().GetX();
		bbox_transform.m[1][1]	= ( *p_transform ).GetUp().GetY();
		bbox_transform.m[1][2]	= ( *p_transform ).GetUp().GetZ();
		bbox_transform.m[1][3]	= 0.0f;

		bbox_transform.m[2][0]	= ( *p_transform ).GetAt().GetX();
		bbox_transform.m[2][1]	= ( *p_transform ).GetAt().GetY();
		bbox_transform.m[2][2]	= ( *p_transform ).GetAt().GetZ();
		bbox_transform.m[2][3]	= 0.0f;

		bbox_transform.m[3][0]	= p_transform->GetPos().GetX();
		bbox_transform.m[3][1]	= p_transform->GetPos().GetY();
		bbox_transform.m[3][2]	= p_transform->GetPos().GetZ();
		bbox_transform.m[3][3]	= 1.0f;
	}
}



float boundingSphereNearestZ = 0.0f;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
float get_bounding_sphere_nearest_z( void )
{
	return boundingSphereNearestZ;
}



/******************************************************************/
/*                                                                */
/* Checks a bounding sphere against the current view frustum	  */
/* (ignoring far clipping). Returns true if any part is visible.  */
/* Timings suggest this method runs on average around ~0.25us,    */
/* faster than test code doing world space culling against a set  */
/* of plane equations representing the view frustum in world	  */
/* space.														  */
/*                                                                */
/******************************************************************/
bool frustum_check_sphere( D3DXVECTOR3 *p_center, float radius )
{
	XGVECTOR4	test_out;

	// Build the composite transform if required.
	if( p_bbox_transform )
	{
		// Object to world.
		test_out.x = p_center->x + p_bbox_transform->_41;
		test_out.y = p_center->y + p_bbox_transform->_42;
		test_out.z = p_center->z + p_bbox_transform->_43;
//		XGVec3Transform( &test_out, (XGVECTOR3*)p_center, p_bbox_transform );

		// World to view.
		XGVec3Transform( &test_out, (XGVECTOR3*)&test_out, (XGMATRIX*)&EngineGlobals.view_matrix );
	}
	else
	{
		// World to view.
		XGVec3Transform( &test_out, (XGVECTOR3*)p_center, (XGMATRIX*)&EngineGlobals.view_matrix );
	}
		
	boundingSphereNearestZ = -test_out.z - radius;

	if( -test_out.z + radius < EngineGlobals.near_plane )
		return false;

	float sx_z	= EngineGlobals.ViewFrustumSX * test_out.z;
	float cx_x	= EngineGlobals.ViewFrustumCX * test_out.x;
	if(( radius < sx_z - cx_x ) || ( radius < sx_z + cx_x ))
		return false;

	float sy_z	= EngineGlobals.ViewFrustumSY * test_out.z;
	float cy_y	= EngineGlobals.ViewFrustumCY * test_out.y;
	if(( radius < sy_z + cy_y ) || ( radius < sy_z - cy_y ))
		return false;

	return true;
}

// LWSS Add
bool check_radius(D3DXVECTOR3* p_center, float radius)
{
	XGVECTOR4	test_out;

	// Build the composite transform if required.
	if (p_bbox_transform)
	{
		// Object to world.
		test_out.x = p_center->x + p_bbox_transform->_41;
		test_out.y = p_center->y + p_bbox_transform->_42;
		test_out.z = p_center->z + p_bbox_transform->_43;
		//		XGVec3Transform( &test_out, (XGVECTOR3*)p_center, p_bbox_transform );

				// World to view.
		XGVec3Transform(&test_out, (XGVECTOR3*)&test_out, (XGMATRIX*)&EngineGlobals.view_matrix);
	}
	else
	{
		// World to view.
		XGVec3Transform(&test_out, (XGVECTOR3*)p_center, (XGMATRIX*)&EngineGlobals.view_matrix);
	}

	// LengthSqr() -- KISAKTODO: convert to Mth::Vector
	float len = test_out.y * test_out.y + test_out.x * test_out.x + test_out.z * test_out.z;
	float lenSqr = sqrt(len);

	return EngineGlobals.far_plane < lenSqr - radius;
}




/******************************************************************/
/*                                                                */
/* Checks a bounding box against the current view frustum		  */
/* (ignoring far clipping). Returns true if any part is visible.  */
/*                                                                */
/******************************************************************/
bool frustum_check_box( Mth::CBBox *p_bbox )
{
	XGVECTOR3	test_in, test_out;
	XGVECTOR4	test_mid;
	
	uint32	cumulative_projection_space_outcode	= 0xFF;
	float	min_x = p_bbox->GetMin().GetX();
	float	min_y = p_bbox->GetMin().GetY();
	float	min_z = p_bbox->GetMin().GetZ();
	float	max_x = p_bbox->GetMax().GetX();
	float	max_y = p_bbox->GetMax().GetY();
	float	max_z = p_bbox->GetMax().GetZ();

	for( uint32 v = 0; v < 8; ++v )
	{
		uint32 projection_space_outcode = 0;

		test_in.x = ( v & 0x04 ) ? max_x : min_x;
		test_in.y = ( v & 0x02 ) ? max_y : min_y;
		test_in.z = ( v & 0x01 ) ? max_z : min_z;

		if( p_bbox_transform )
		{
			XGVec3Transform( &test_mid, &test_in, p_bbox_transform );
			test_in.x = test_mid.x;
			test_in.y = test_mid.y;
			test_in.z = test_mid.z;
		}
		
		XGVec3Transform( &test_mid, &test_in, &EngineGlobals.view_matrix );
		test_in.x = test_mid.x;
		test_in.y = test_mid.y;
		test_in.z = test_mid.z;
		
		// Do z-checking here.
		if( -test_mid.z < EngineGlobals.near_plane )
		{
			// Behind the camera near plane.
			projection_space_outcode |= 0x10;
		}
		else if( -test_mid.z > EngineGlobals.far_plane )
		{
			// Beyond the camera far plane.
			projection_space_outcode |= 0x20;
		}
		
		// At this point it's important to check to see whether the point is in postive or negative z-space, since
		// after the projection transform, both very large camera space z values and camera space z values where z < 0
		// will give results with z > 1. (Camera space values in the range [0,near] give negative projection space z values).
		XGVec3TransformCoord( &test_out, &test_in, &EngineGlobals.projection_matrix );

		if(( -test_mid.z < 0.0f ) && ( !EngineGlobals.is_orthographic ))
		{
			test_out.x = -test_out.x;
			test_out.y = -test_out.y;
		}

		if( test_out.x > 1.0f )
			projection_space_outcode |= 0x01;
		else if( test_out.x < -1.0f )
			projection_space_outcode |= 0x02;

		if( test_out.y > 1.0f )
			projection_space_outcode |= 0x04;
		else if( test_out.y < -1.0f )
			projection_space_outcode |= 0x08;

		cumulative_projection_space_outcode	&= projection_space_outcode;

		if( cumulative_projection_space_outcode == 0 )
		{
			// Early out.
			return true;
		}
	}
	return false;
}



struct sSortedMeshEntry
{
	sMesh				*p_mesh;
	float				sort;
	sSortedMeshEntry	*pNext;
};


static sSortedMeshEntry	sortedMeshArray[1000];


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void calculate_tex_proj_matrix( XGMATRIX *p_tex_view_matrix, XGMATRIX *p_tex_proj_matrix, XGMATRIX *p_tex_transform_matrix, XGMATRIX *p_world_matrix )
{
	// Get the current view matrix.
	XGMATRIX matView, matInvView;
	D3DDevice_GetTransform( D3DTS_VIEW, (XGMATRIX*)&matView );
	//XGMatrixInverse( &matInvView,  NULL, &matView );
	D3DXMatrixInverse(&matInvView, NULL, &matView);
	XGMATRIX matBiasScale;
    XGMatrixIdentity( &matBiasScale );

	static float x0 = 256.0f;
	static float y0 = 256.0f;
	
	matBiasScale._11 = x0 * 0.5f;
	matBiasScale._22 = y0 * -0.5f;
	matBiasScale._33 = 16777215.0f; //  D3DZ_MAX_D24S8; // lwss add

	static float x1 = 256.0f;
	static float y1 = 256.0f;
	
	matBiasScale._41 = x1 * 0.5f + 0.5f;
	matBiasScale._42 = y1 * 0.5f + 0.5f;

	XGMATRIX m_matTexProj;

	// Don't bother with inverse view transform for Shadow Buffer, since we are picking up world-space coordinates directly.
	if( p_world_matrix )
	{
		m_matTexProj = *p_world_matrix;												// Transform to world space.
		XGMatrixMultiply( &m_matTexProj, &m_matTexProj, p_tex_view_matrix );		// Transform to projection camera space.
	}
	else
	{
		m_matTexProj = *p_tex_view_matrix;											// Transform to projection camera space.
	}
	XGMatrixMultiply( &m_matTexProj, &m_matTexProj, p_tex_proj_matrix );			// Situate verts relative to projector's view
    XGMatrixMultiply( p_tex_transform_matrix, &m_matTexProj, &matBiasScale );		// Scale and bias to map the near clipping plane to texcoords
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void render_shadow_targets( void )
{
	XGMATRIX	stored_view_matrix			= EngineGlobals.view_matrix;
	XGMATRIX	stored_projection_matrix	= EngineGlobals.projection_matrix;
	uint32		stored_fog_state			= EngineGlobals.fog_enabled;
	DWORD		multisample_mode;

	IDirect3DSurface9* render_target = NULL;
	IDirect3DSurface9* zstencil_surface = NULL;

	// Get multisample mode.
	//D3DDevice_GetRenderState( D3DRS_MULTISAMPLEMODE, &multisample_mode );

	D3DDevice_GetRenderTarget( 0, &render_target );
	D3DDevice_GetDepthStencilSurface( &zstencil_surface );

	// Disable fogging.
	set_render_state( RS_FOGENABLE, 0 );

	// Goes through the list of render target textures, rendering to each one in turn.
	pTextureProjectionDetailsTable->IterateStart();
	sTextureProjectionDetails *p_details = pTextureProjectionDetailsTable->IterateNext();
	
	//D3DSurface fake_target;

	while( p_details )
	{
		if( p_details->p_model )
		{
			// lwss: removed for PC
			/*
			// Setup dummy color buffer (bad things will happen if you write to it).
			// The XGSetSurfaceHeader() function is slow, these values are now set explicitly from the observed values
			// set by the function.
//			ZeroMemory( &fake_target, sizeof( fake_target ));
//			XGSetSurfaceHeader( 256, 256, D3DFMT_LIN_R5G6B5, &fake_target, 0, 0 );
			fake_target.Common	= 0x00050001UL;
			fake_target.Data	= 0x00000000UL;
			fake_target.Lock	= 0x00000000UL;
			fake_target.Format	= 0x00011129UL;
			fake_target.Size	= 0x070FF0FFUL;
			fake_target.Parent	= 0x00000000UL;
			*/
			// Set the new render target.
			LPDIRECT3DSURFACE9 pSurface;

			// This call will increase the reference count of the IDirect3DTexture8 object.
			//p_details->p_texture->pD3DTexture->GetSurfaceLevel( 0, &pSurface );
			
			// lwss end
			
			// This call will increase the reference count of the IDirect3DSurface8 object.
			//D3DDevice_SetRenderTarget( &fake_target, pSurface );
			D3DDevice_SetRenderTarget( 0, p_details->p_texture->pD3DSurface );
			
			D3DDevice_SetDepthStencilSurface(0);

			// Clear the target.
			//D3DDevice_Clear( 0, NULL, D3DCLEAR_ZBUFFER | D3DCLEAR_STENCIL, 0, 1.0f, 0 ); 
			D3DDevice_Clear( 0, NULL, D3DCLEAR_TARGET, 0, 1.0f, 0 );
			
			// Disable color writes.
			//D3DDevice_SetRenderState( D3DRS_COLORWRITEENABLE, 0 );

			// Turn on z-offset.
			//D3DDevice_SetRenderState( D3DRS_SOLIDOFFSETENABLE,			TRUE );
			//D3DDevice_SetRenderState( D3DRS_POLYGONOFFSETZOFFSET,		FtoDW( 4.0f ));
			//D3DDevice_SetRenderState( D3DRS_POLYGONOFFSETZSLOPESCALE,	FtoDW( 2.0f ));

			// Performance optimiser suggested change.
			// Priority 2: Set D3DRS_MULTISAMPLEMODE to D3DMULTISAMPLEMODE_4X for faster fill rate with no quality loss when depth only rendering.
			//D3DDevice_SetRenderState( D3DRS_MULTISAMPLEMODE,			D3DMULTISAMPLEMODE_4X );

			// Set the view and projection transforms.
			EngineGlobals.view_matrix		= p_details->view_matrix;
			EngineGlobals.projection_matrix	= p_details->projection_matrix;
			EngineGlobals.is_orthographic	= true;

			D3DDevice_SetTransform(D3DTS_VIEW, &p_details->view_matrix);
			D3DDevice_SetTransform(D3DTS_PROJECTION, &p_details->projection_matrix);
			D3DMATRIX v10;
			v10._11 = 1.0;
			v10._12 = 0.0;
			v10._13 = 0.0;
			v10._14 = 0.0;

			v10._21 = 0.0;
			v10._22 = 1.0;
			v10._23 = 0.0;
			v10._24 = 0.0;

			v10._31 = 0.0;
			v10._32 = 0.0;
			v10._33 = 1.0;
			v10._34 = 0.0;

			v10._41 = 0.0;
			v10._42 = 0.0;
			v10._43 = 0.0;
			v10._44 = 1.0;

			D3DDevice_SetTransform(D3DTS_WORLD, &v10);

			// Render all instances for the CGeom's contained in this model.
			int num_geoms = p_details->p_model->GetNumGeoms();
			for( int i = 0; i < num_geoms; ++i )
			{
				Nx::CXboxGeom *p_xbox_geom	= static_cast<Nx::CXboxGeom*>( p_details->p_model->GetGeomByIndex( i ));
				CInstance *p_instance		= p_xbox_geom->GetInstance();
				
				if( p_instance->GetActive())
				{
					// Flag the scene as having the shadow version rendered.
					p_instance->GetScene()->m_flags |= SCENE_FLAG_RENDERING_SHADOW;

					// Render the model.
					render_instance( p_instance, vRENDER_NO_CULLING );

					// Clear the flag the scene as having the shadow version rendered.
					p_instance->GetScene()->m_flags &= ~SCENE_FLAG_RENDERING_SHADOW;
			
					// Flag the scene as self shadowing.
					p_instance->GetScene()->m_flags |= SCENE_FLAG_SELF_SHADOWS;
				}
			}
			//pSurface->Release();
		}
		p_details = pTextureProjectionDetailsTable->IterateNext();
	}

	// Restore important states.
	// LWSS: changes made here to match windows bin
	//D3DDevice_SetRenderState( D3DRS_COLORWRITEENABLE,	D3DCOLORWRITEENABLE_ALL );
	D3DDevice_SetRenderState( D3DRS_COLORWRITEENABLE,	15/*ALL*/);
	//D3DDevice_SetRenderState( D3DRS_SOLIDOFFSETENABLE,	FALSE );
	//D3DDevice_SetRenderState( D3DRS_MULTISAMPLEMODE,	multisample_mode );
	set_render_state( RS_FOGENABLE, stored_fog_state );

	// Pixel shader override no longer required.
	EngineGlobals.pixel_shader_override = 0;
	
	// Restore the view and projection transforms.
	EngineGlobals.view_matrix		= stored_view_matrix;
	EngineGlobals.projection_matrix	= stored_projection_matrix;
	EngineGlobals.is_orthographic	= false;

	// It's important to set the internal reference count of the dummy color surface here, otherwise
	// the debug version of D3D will complain when it attempts to reduce the internal ref count during
	// the subsequent SetRenderTarget() call.
	//fake_target.Common	= 0x000D0001UL;

	D3DDevice_SetTransform(D3DTS_WORLD, &EngineGlobals.world_matrix);

	D3DDevice_SetTransform(D3DTS_VIEW, &EngineGlobals.view_matrix);
	D3DDevice_SetRenderState(D3DRS_TEXTUREFACTOR, -1);
	D3DDevice_SetRenderTarget(0, render_target);
	D3DDevice_SetDepthStencilSurface(zstencil_surface);

	if (render_target)
		render_target->Release();

	if (zstencil_surface)
		zstencil_surface->Release();

	// Restore the default render target.
	//D3DDevice_SetRenderTarget( EngineGlobals.p_RenderSurface, EngineGlobals.p_ZStencilSurface );
}

static D3DVECTOR sShadowTransV[1024];

// LWSS Add
unsigned int TransformShadowVertices(const D3DXVECTOR3* p_vertices, int num_vertices_arg, D3DXMATRIX* p_matrix)
{
	int num_vertices; // ebp
	float* v5; // esi
	unsigned int result; // eax
	float y; // edx
	float z; // [esp+14h] [ebp-4h]

	num_vertices = num_vertices_arg;
	if (num_vertices_arg)
	{
		v5 = (float*)&sShadowTransV;
		do
		{
			XGVec3TransformCoord((D3DXVECTOR3*)v5, p_vertices, p_matrix);
			z = p_vertices->z;
			result = (*((_DWORD*)v5 + 2) + 0x800000) & 0xC0000000 | ((((unsigned int)(*(_DWORD*)v5 + 0x800000) >> 2) & 0x30000000 | (*((_DWORD*)v5 + 1) + 0x800000) & 0xC0000003) >> 2);
			y = p_vertices->y;
			*(v5 - 3) = p_vertices->x;
			*(v5 - 2) = y;
			*(v5 - 1) = z;
			*((_DWORD*)v5 + 3) = result & ~((result >> 1) & 0x54000000);
			v5 += 7;
			++p_vertices;
			--num_vertices;
		} while (num_vertices);
	}
	return result;
}
// LWSS End


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void render_shadow_meshes( sScene *p_scene, sMesh **p_mesh_indices, int num_meshes )
{
	// LWSS: reworked for PC
	
	// No anisotropic filtering for the base texture.
	DWORD stage_zero_minfilter;
	//D3DDevice_GetTextureStageState( 0, D3DTSS_MINFILTER, &stage_zero_minfilter );
	D3DDevice_GetSamplerState(0, D3DSAMP_MINFILTER, &stage_zero_minfilter);
	D3DDevice_SetSamplerState( 0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR );
	D3DDevice_SetTextureStageState(0, D3DTSS_TEXCOORDINDEX, 0);
	D3DDevice_SetTextureStageState(0, D3DTSS_TEXTURETRANSFORMFLAGS, 0);

	// Disable fogging.
	uint32 stored_fog_state = EngineGlobals.fog_enabled;
	set_render_state( RS_FOGENABLE, 0 );

	// Scan through each entry in the TextureProjectionDetails table, and see whether it relates to this scene.
	pTextureProjectionDetailsTable->IterateStart();
	sTextureProjectionDetails *p_details = pTextureProjectionDetailsTable->IterateNext();
	//while( p_details )
	while (false) // lwss: this loop NEVER goes off in retail PC version. (KISAKTODO?)
	{
		XGMATRIX	stored_view_matrix			= EngineGlobals.view_matrix;
		XGMATRIX	stored_projection_matrix	= EngineGlobals.projection_matrix;
			
		XGMATRIX viewXproj;
		XGMATRIX v14;
		XGMATRIX identity;
		identity._11 = 0.5;
		identity._12 = 0.0;
		identity._13 = 0.0;
		identity._14 = 0.0;

		identity._21 = 0.0;
		identity._22 = -0.5;
		identity._23 = 0.0;
		identity._24 = 0.0;

		identity._31 = 0.0;
		identity._32 = 0.0;
		identity._33 = 1.0;
		identity._34 = 0.0;

		identity._41 = 0.5;
		identity._42 = 0.5;
		identity._43 = 0.0;
		identity._44 = 1.0;

		XGMatrixMultiply(&viewXproj, &p_details->view_matrix, &p_details->texture_projection_matrix);
		XGMatrixMultiply(&v14, &viewXproj, &identity);

		// Calculate the projection matrix that will project world coordinates into our shadow buffer.
		calculate_tex_proj_matrix( &p_details->view_matrix, &p_details->projection_matrix, &p_details->texture_projection_matrix );

		if (NxXbox::EngineGlobals.hasHLSLv101)
		{
			if (!EngineGlobals.pixel_shader_override && EngineGlobals.pixel_shader_id)
			{
				D3DDevice_SetPixelShader(0);
				EngineGlobals.pixel_shader_id = 0;
			}
			EngineGlobals.upload_pixel_shader_constants = 0;
		}

		// LWSS: Remove shaders here for PC
		// Set the vertex shader.
		//set_vertex_shader( ShadowBufferStaticGeomVS );

		// Set the pixel shader that just does straight texturing.
		//set_pixel_shader( ShadowBufferStaticGeomPS );

		D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, 2);
		D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAOP, 2);
		D3DDevice_SetTextureStageState(0, D3DTSS_COLORARG1, 3);
		D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAARG1, 2);
		D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, 1);
		D3DDevice_SetRenderState(D3DRS_TEXTUREFACTOR, -6250336); // ??
		
		set_render_state( RS_ALPHACUTOFF, 1 );
		
		// Set the other textures to NULL.
		set_texture( 0, NULL );
		set_texture( 2, NULL );
		set_texture( 3, NULL );

		// Need to set this texture NULL first, to flush the texture state, since the incoming texture is linear.
		set_texture( 1, NULL );

		// Set the projected texture (as the second-pass texture).
		//if( p_details->p_texture->pD3DSurface )
		//	set_texture( 1, (IDirect3DTexture9*)( p_details->p_texture->pD3DSurface ));
		//else
		//	set_texture( 1, p_details->p_texture->pD3DTexture );

		set_texture(0, p_details->p_texture->pD3DTexture);

		// Set shadowbuffer texture details.
		//set_render_state( RS_UVADDRESSMODE1, 0x00020002UL );					// Set (border,border) addressing.
		set_render_state( RS_UVADDRESSMODE0, 0x00020002UL );					// Set (border,border) addressing.

		if (EngineGlobals.has_D3DPTADDRESSCAPS_BORDER)
		{
			D3DDevice_SetSamplerState(0, D3DSAMP_BORDERCOLOR, 0);
		}

		D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);
		D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR); // KISAKTODO: Twice???
		D3DDevice_SetTransform(D3DTS_PROJECTION, &EngineGlobals.projection_matrix);
		D3DDevice_SetTransform(D3DTS_VIEW, &EngineGlobals.view_matrix);

		D3DXMATRIX world_matrix;
		world_matrix._11 = 1.0;
		world_matrix._12 = 0.0;
		world_matrix._13 = 0.0;
		world_matrix._14 = 0.0;

		world_matrix._21 = 0.0;
		world_matrix._22 = 1.0;
		world_matrix._23 = 0.0;
		world_matrix._24 = 0.0;

		world_matrix._31 = 0.0;
		world_matrix._32 = 0.0;
		world_matrix._33 = 1.0;
		world_matrix._34 = 0.0;

		world_matrix._41 = 0.0;
		world_matrix._42 = 0.0;
		world_matrix._43 = 0.0;
		world_matrix._44 = 1.0;






		D3DDevice_SetTransform(D3DTS_WORLD, &world_matrix);

		//D3DDevice_SetTextureStageState( 1, D3DTSS_BORDERCOLOR, 0xffffffff );
		//D3DDevice_SetTextureStageState( 1, D3DTSS_MAGFILTER, D3DTEXF_LINEAR );
		//D3DDevice_SetTextureStageState( 1, D3DTSS_MINFILTER, D3DTEXF_LINEAR );
		
		// Set shadowbuffer state.
		//D3DDevice_SetRenderState( D3DRS_SHADOWFUNC, D3DCMP_GREATEREQUAL );
			
		//// Upload constants to the vertex shader for composite world->view->projection transform (c0 - c3) and
		//// world->texture transform (c4 - c7).
		//XGMATRIX	dest_matrix;
		//XGMATRIX	temp_matrix;
		//XGMATRIX	projMatrix;
		//XGMATRIX	viewMatrix;
		//XGMATRIX	worldMatrix;
		//XGMATRIX	texProjMatrix;
		//
		//// Texture projection matrix.
		//XGMatrixTranspose( &texProjMatrix, &p_details->texture_projection_matrix );
		//
		//// Projection matrix.
		//XGMatrixTranspose( &projMatrix, &EngineGlobals.projection_matrix );
		//
		//// View matrix.
		//XGMatrixTranspose( &viewMatrix, &EngineGlobals.view_matrix );
		//viewMatrix.m[3][0] = 0.0f;
		//viewMatrix.m[3][1] = 0.0f;
		//viewMatrix.m[3][2] = 0.0f;
		//viewMatrix.m[3][3] = 1.0f;
		//
		//// World space transformation matrix.
		//XGMatrixIdentity( &worldMatrix );
		//
		//// Calculate composite world->view->projection matrix.
		//XGMatrixMultiply( &temp_matrix, &viewMatrix, &worldMatrix );
		//XGMatrixMultiply( &dest_matrix, &projMatrix, &temp_matrix );
		//
		//// Load up the combined world, camera & projection matrix, and the tetxure transform matrix.
		//D3DDevice_SetVertexShaderConstantFast( 0, (void*)&dest_matrix, 4 );
		//D3DDevice_SetVertexShaderConstantFast( 4, (void*)&texProjMatrix, 4 );
		//
		//// Turn on z-offset.
		//D3DDevice_SetRenderState( D3DRS_SOLIDOFFSETENABLE,			TRUE );
		//D3DDevice_SetRenderState( D3DRS_POLYGONOFFSETZOFFSET,		FtoDW( -4.0f ));
		//D3DDevice_SetRenderState( D3DRS_POLYGONOFFSETZSLOPESCALE,	FtoDW( -2.0f ));

		// Set the blend mode to modulate, using the texture color.
		set_blend_mode( vBLEND_MODE_MODULATE_COLOR );

		// Set up the correct view and projection matrix for frustum culling.
		EngineGlobals.view_matrix		= p_details->view_matrix;
		EngineGlobals.projection_matrix	= p_details->projection_matrix;
		EngineGlobals.is_orthographic	= true;

		set_render_state(RS_ZBIAS, 10); // lwss add

		// Draw the meshes.
		for( int i = 0; i < num_meshes; ++i )
		{
			sMesh *p_mesh = p_mesh_indices[i];
			if (!p_mesh)
			{
				continue;
			}
				
			// Check this mesh is okay for shadow rendering.
			if( !( p_mesh->m_flags & sMesh::MESH_FLAG_NO_SKATER_SHADOW ))
			{
				// Cull this mesh against the second view frustum.
				if( frustum_check_sphere( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius ))
				{
					set_vertex_shader(D3DFVF_TEX1 | D3DFVF_XYZ); // 0x102

//					if( frustum_check_box( &p_mesh->m_bbox ))
					{
						// KISAKTODO: Transform and GenerateShadowVertices()
						TransformShadowVertices((const D3DXVECTOR3 *)p_mesh->m_vertices_raw, p_mesh->m_num_vertices_raw, &v14);
						//// Here we want to set up texture 0 as per the material on the mesh. This way we can use it as an alpha
						//// mask to avoid drawing the shadow on transparent pixels.
						////if( p_mesh->mp_material->mp_tex[0] )
						////{
						////	set_texture( 0, p_mesh->mp_material->mp_tex[0]->pD3DTexture );
						////	set_render_state( RS_UVADDRESSMODE0, p_mesh->mp_material->m_uv_addressing[0] );
						////}
						//
						////(THIS_ D3DPRIMITIVETYPE PrimitiveType,UINT PrimitiveCount,CONST void* pVertexStreamZeroData,UINT VertexStreamZeroStride) PURE;
						//D3DDevice_DrawPrimitiveUP(D3DPT_TRIANGLELIST, tri_count, NxXbox::sShadowRenderV, 20);
						//// Draw the mesh.
						//D3DDevice_SetStreamSource( 0, p_mesh->mp_vertex_buffer[0], p_mesh->m_vertex_stride );
						//D3DDevice_DrawIndexedVertices( p_mesh->m_primitive_type, p_mesh->m_num_indices[0], p_mesh->mp_index_buffer[0] );
					}
				}
			}
		}

		// Restore the view and projection transforms.
		EngineGlobals.view_matrix		= stored_view_matrix;
		EngineGlobals.projection_matrix	= stored_projection_matrix;
		EngineGlobals.is_orthographic	= false;

		p_details = pTextureProjectionDetailsTable->IterateNext();
	}

	if (NxXbox::EngineGlobals.hasHLSLv101)
	{
		if (!NxXbox::EngineGlobals.pixel_shader_override && NxXbox::EngineGlobals.pixel_shader_id)
		{
			D3DDevice_SetPixelShader(NULL);
			NxXbox::EngineGlobals.pixel_shader_id = NULL;
		}
		NxXbox::EngineGlobals.upload_pixel_shader_constants = false;
	}

	D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, stage_zero_minfilter);
	set_render_state(RS_FOGENABLE, stored_fog_state);
	D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, 4);
	D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAOP, 4);
	D3DDevice_SetTextureStageState(0, D3DTSS_COLORARG1, 2);
	D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAARG1, 2);
	D3DDevice_SetTextureStageState(1, D3DTSS_COLOROP, 1);
	D3DDevice_SetRenderState(D3DRS_TEXTUREFACTOR, -1);
	set_render_state(RS_ZBIAS, 0);
	D3DDevice_SetRenderState(D3DRS_ZENABLE, 1);

	if (NxXbox::EngineGlobals.p_texture[0])
	{
		D3DDevice_SetTexture(0, 0);
		NxXbox::EngineGlobals.p_texture[0] = NULL;
	}

	// Turn off z-offset.
	//D3DDevice_SetRenderState( D3DRS_SOLIDOFFSETENABLE, FALSE );
	//D3DDevice_SetRenderState( D3DRS_SHADOWFUNC, D3DCMP_NEVER );
	//set_pixel_shader( 0 );
	//
	//// Restore anisotropic filtering if present.
	//D3DDevice_SetTextureStageState( 0, D3DTSS_MINFILTER, stage_zero_minfilter );
	//
	//// Restore fogging if present.
	//set_render_state( RS_FOGENABLE, stored_fog_state );
	//
	//// Reflush linear texture.
	//set_texture( 1, NULL );
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static int cmp( const void *p1, const void *p2 )
{
	return((sSortedMeshEntry*)p1)->sort < ((sSortedMeshEntry*)p2)->sort ? -1 : ((sSortedMeshEntry*)p1)->sort > ((sSortedMeshEntry*)p2)->sort ? 1 : 0;
}



static bool debug_shadow_volumes = false;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: This function is done. ++
void render_shadow_volumes( sScene *p_scene, uint32 viewport )
{
	// Switch viewport from value to bitfield value.
	viewport = ( 1 << viewport );
	
	NxXbox::set_pixel_shader( (IDirect3DPixelShader9*)PixelShader5 );
	EngineGlobals.pixel_shader_override	= PixelShader5;
	NxXbox::set_texture( 0, NULL );
	NxXbox::set_render_state( RS_ZWRITEENABLE,	0 );
	NxXbox::set_render_state( RS_ZTESTENABLE,	1 );
	NxXbox::set_render_state( RS_ALPHACUTOFF,	0 );

	if( debug_shadow_volumes == false )
		D3DDevice_SetRenderState( D3DRS_ZFUNC,		D3DCMP_GREATEREQUAL );

	// Render all meshes.
	for( int e = 0; e < p_scene->m_num_mesh_entries; ++e )
	{
		sMesh *p_mesh = p_scene->m_meshes[e];
		if(( p_mesh->m_flags & sMesh::MESH_FLAG_ACTIVE ) && ( p_mesh->m_flags & sMesh::MESH_FLAG_SHADOW_VOLUME ))
		{
			// Frustum cull this mesh, using the associated bounding sphere.
			if( frustum_check_sphere( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius ))
			{
				if( debug_shadow_volumes == false )
				{
					NxXbox::set_render_state( RS_CULLMODE, D3DCULL_CW );
					NxXbox::set_blend_mode( 0x10000000UL | NxXbox::vBLEND_MODE_ADD_FIXED );
					p_mesh->Submit();

					NxXbox::set_render_state( RS_CULLMODE, D3DCULL_CCW );
					NxXbox::set_blend_mode( 0x10000000UL | NxXbox::vBLEND_MODE_SUB_FIXED );
					p_mesh->Submit();
				}
				else
				{
					NxXbox::set_render_state( RS_CULLMODE, D3DCULL_NONE );
					NxXbox::set_blend_mode( 0x30000000UL | NxXbox::vBLEND_MODE_BLEND_FIXED );
					p_mesh->Submit();
				}
			}
		}
	}

	EngineGlobals.pixel_shader_override	= 0;
	NxXbox::set_render_state( RS_ZWRITEENABLE,	1 );
	NxXbox::set_render_state( RS_CULLMODE,		D3DCULL_CW );
	D3DDevice_SetRenderState( D3DRS_ZFUNC,		D3DCMP_LESSEQUAL );
}


#define			VISIBLE_MESH_ARRAY_SIZE		4096
static sMesh	*visible_mesh_array[VISIBLE_MESH_ARRAY_SIZE];

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Function looks good
void render_scene( sScene *p_scene, uint32 flags, uint32 viewport )
{
	sMaterial		*p_material					= NULL;
	bool			no_culling					= ( flags & vRENDER_NO_CULLING ) > 0 ;
	bool			render;
	int				visible_mesh_array_index	= 0;

	// Don't render dictionary scenes.
	if( p_scene->m_is_dictionary )
	{
		return;
	}
	
	if( flags & vRENDER_SHADOW_VOLUMES )
	{
		render_shadow_volumes( p_scene, viewport );
		return;
	}

	// Disallow front to back sorting if the number of opaque meshes is larger than the visible mesh array.
	if( p_scene->m_first_semitransparent_entry >= VISIBLE_MESH_ARRAY_SIZE )
	{
		flags &= ~vRENDER_SORT_FRONT_TO_BACK;
	}

	// Switch viewport from value to bitfield value.
	viewport = ( 1 << viewport );
	
	// Render opaque meshes.
	if( flags & vRENDER_OPAQUE )
	{
		for( int e = 0; e < p_scene->m_first_semitransparent_entry; ++e )
		{
			sMesh *p_mesh = p_scene->m_meshes[e];

			__asm mov eax, p_mesh			// Store mesh pointer.
			__asm prefetcht0 [eax]			// Get first 32 bytes of sMesh structure.
			
			if(( p_mesh->m_flags & sMesh::MESH_FLAG_ACTIVE ) && (( p_mesh->m_flags & ( sMesh::MESH_FLAG_SHADOW_VOLUME | sMesh::MESH_FLAG_BILLBOARD )) == 0 ))
			{
				if( no_culling )
				{
					render = true;
				}
				else
				{
					render = false;

					// Check the visibility mask.
					if( p_mesh->m_visibility_mask & viewport )
					{
						// Frustum cull this set of meshes, using the associated bounding sphere and bounding box.
						if( frustum_check_sphere( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius ))
						{
							// Check against any occluders.
							if(( !( flags & vRENDER_OCCLUDED )) || ( !TestSphereAgainstOccluders( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius )))
							{
								render = true;
							}
						}
					}
				}

				// Draw this mesh if we decided it is visible.
				if( render )
				{
					if(( flags & vRENDER_SORT_FRONT_TO_BACK ) == 0 )
					{
						// lwss: Comment out for PC
						// If the material has changed, submit the new material.
						//if( p_mesh->mp_material != p_material )
						//{
						//	p_material = p_mesh->mp_material;
						//	p_material->Submit();
						//}
						p_mesh->Submit();
					}
					else
					{
						// If this mesh is within the 'near' section, render it now. Meshes in the far section will be
						// deferred for rendering later on, which should gain some benefit from the fast pixel occlusion.
						if( boundingSphereNearestZ <= FRONT_TO_BACK_SORT_CUTOFF )
						{
							// lwss: Comment out for PC
							//if( p_mesh->mp_material != p_material )
							//{
							//	p_material = p_mesh->mp_material;
							//	p_material->Submit();
							//}
							p_mesh->Submit();
						}

						// Set the nearest point of the bounding sphere.
						p_mesh->m_bounding_sphere_nearest_z = boundingSphereNearestZ;
					}

					// Add this mesh to the visible list, providing it is within bounds.
					visible_mesh_array[visible_mesh_array_index] = p_mesh;
					if( visible_mesh_array_index < ( VISIBLE_MESH_ARRAY_SIZE - 1 ))
						++visible_mesh_array_index;
				}
			}
		}			
		
		if(( flags & vRENDER_SORT_FRONT_TO_BACK ) && ( visible_mesh_array_index > 0 ))
		{
			// At this stage we have an array of meshes, some of which may not yet have been rendered.
			// At this point simply scan through the list twice, drawing all 'far' meshes.
			for( int vm = 0; vm < visible_mesh_array_index; ++vm )
			{
				sMesh *p_sorted_mesh = visible_mesh_array[vm];

				if( p_sorted_mesh->m_bounding_sphere_nearest_z > FRONT_TO_BACK_SORT_CUTOFF )
				{				
					// If the material has changed, submit the new material.
					if( p_sorted_mesh->mp_material != p_material )
					{
						p_material = p_sorted_mesh->mp_material;
						p_material->Submit();
					}
					p_sorted_mesh->Submit();
				}
			}
		}

		// Now draw the opaque meshes with shadow mapped on them.
		if( p_scene->m_flags & SCENE_FLAG_RECEIVE_SHADOWS )
		{
			set_render_state( RS_ZWRITEENABLE,	0 );
			DWORD min_filter;
			D3DDevice_GetSamplerState( 0, D3DSAMP_MINFILTER, &min_filter );
			if( min_filter == D3DTEXF_ANISOTROPIC )
			{
				D3DDevice_SetSamplerState( 0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR );
			}
		
			render_shadow_meshes( p_scene, visible_mesh_array, visible_mesh_array_index );

			if( min_filter == D3DTEXF_ANISOTROPIC )
			{
				D3DDevice_SetSamplerState( 0, D3DSAMP_MINFILTER, D3DTEXF_ANISOTROPIC );
			}
			set_render_state( RS_ZWRITEENABLE,	1 );
		}

		// Reset mesh array
		visible_mesh_array_index = 0;

		if( flags & vRENDER_BILLBOARDS )
		{
			BillboardManager.Render( vRENDER_OPAQUE );
		}
	}
	
	if( flags & vRENDER_SEMITRANSPARENT )
	{
		int e						= p_scene->m_first_semitransparent_entry;
		int next_sorted_mesh_entry	= 0;
		
		// Semitransparent rendering is done in three stages.
		// The first stage is meshes in the list up to the point where dynamic sorting starts.
		// The second stage is meshes in the list which use dynamic sorting.
		// The third stage is meshes in the list beyond the point where dynamic sorting ends.
		for( ; e < p_scene->m_first_dynamic_sort_entry; ++e )
		{
			sMesh *p_mesh = p_scene->m_meshes[e];

			__asm mov eax, p_mesh			// Store mesh pointer.
			__asm prefetcht0 [eax]			// Get first 32 bytes of sMesh structure.

			if(( p_mesh->m_flags & sMesh::MESH_FLAG_ACTIVE ) && (( p_mesh->m_flags & ( sMesh::MESH_FLAG_SHADOW_VOLUME | sMesh::MESH_FLAG_BILLBOARD )) == 0 ))
			{
				if( no_culling )
				{
					render = true;
				}
				else
				{
					render = false;

					// Check the visibility mask.
					if( p_mesh->m_visibility_mask & viewport )
					{
						// Frustum cull this set of meshes, using the associated bounding box.
						if( frustum_check_sphere( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius ))
						{
							// Check against any occluders.
							if(( !( flags & vRENDER_OCCLUDED )) || ( !TestSphereAgainstOccluders( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius )))
							{
								render = true;
							}
						}
					}
				}
				if( render )
				{
					// If the material has changed, submit the new material.
					// LWSS: Remove for PC
					//if( p_mesh->mp_material != p_material )
					//{
					//	p_material = p_mesh->mp_material;
					//	p_material->Submit();
					//}
					// LWSS: Add hack from PC.
					if (p_mesh->mp_material->m_checksum == 0x5C738D12)
					{
						p_mesh->mp_material->mp_tex[0] = p_mesh->mp_material->mp_tex[1];
					}
					p_mesh->Submit();

					// Add this mesh to the visible list, providing it is within bounds.
					visible_mesh_array[visible_mesh_array_index] = p_mesh;
					if( visible_mesh_array_index < ( VISIBLE_MESH_ARRAY_SIZE - 1 ))
						++visible_mesh_array_index;
				}
			}
		}

		if( p_scene->m_num_dynamic_sort_entries > 0 )
		{
			// Second stage - dynamically sorted meshes.
			int last_dynamic_sort_entry = p_scene->m_first_dynamic_sort_entry + p_scene->m_num_dynamic_sort_entries;
			for( ; e < last_dynamic_sort_entry; ++e )
			{
				sMesh *p_mesh = p_scene->m_meshes[e];

				__asm mov eax, p_mesh			// Store mesh pointer.
				__asm prefetcht0 [eax]			// Get first 32 bytes of sMesh structure.

				if(( p_mesh->m_flags & sMesh::MESH_FLAG_ACTIVE ) && (( p_mesh->m_flags & ( sMesh::MESH_FLAG_SHADOW_VOLUME | sMesh::MESH_FLAG_BILLBOARD )) == 0 ))
				{
					if( no_culling )
					{
						render = true;
					}
					else
					{
						render = false;

						// Check the visibility mask.
						if( p_mesh->m_visibility_mask & viewport )
						{
							// Frustum cull this set of meshes, using the associated bounding box.
							if( frustum_check_sphere( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius ))
							{
								// Check against any occluders.
								if(( !( flags & vRENDER_OCCLUDED )) || ( !TestSphereAgainstOccluders( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius )))
								{
									render = true;
								}
							}
						}
					}
					if( render )
					{
						// Add this mesh to the visible list, providing it is within bounds.
						visible_mesh_array[visible_mesh_array_index] = p_mesh;
						if( visible_mesh_array_index < ( VISIBLE_MESH_ARRAY_SIZE - 1 ))
							++visible_mesh_array_index;

						sortedMeshArray[next_sorted_mesh_entry].p_mesh	= p_mesh;
						sortedMeshArray[next_sorted_mesh_entry].sort	= boundingSphereNearestZ;

						++next_sorted_mesh_entry;
					}
				}
			}
			if( next_sorted_mesh_entry > 0 )
			{
				// Sort the array into ascending sort order.
				qsort( sortedMeshArray, next_sorted_mesh_entry, sizeof( sSortedMeshEntry ), cmp );
		
				for( int m = 0; m < next_sorted_mesh_entry; ++m )
				{
					if( sortedMeshArray[m].p_mesh->mp_material != p_material )
					{
						sortedMeshArray[m].p_mesh->mp_material->Submit();
						p_material = sortedMeshArray[m].p_mesh->mp_material;
					}
					sortedMeshArray[m].p_mesh->Submit();
				}
			}
		
			// Third stage - meshes after the dynamically sorted set.
			for( ; e < p_scene->m_num_mesh_entries; ++e )
			{
				sMesh *p_mesh = p_scene->m_meshes[e];

				__asm mov eax, p_mesh			// Store mesh pointer.
				__asm prefetcht0 [eax]			// Get first 32 bytes of sMesh structure.

				if(( p_mesh->m_flags & sMesh::MESH_FLAG_ACTIVE ) && (( p_mesh->m_flags & ( sMesh::MESH_FLAG_SHADOW_VOLUME | sMesh::MESH_FLAG_BILLBOARD )) == 0 ))
				{
					if( no_culling )
					{
						render = true;
					}
					else
					{
						render = false;

						// Check the visibility mask.
						if( p_mesh->m_visibility_mask & viewport )
						{
							// Frustum cull this set of meshes, using the associated bounding box.
							if( frustum_check_sphere( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius ))
							{
								// Check against any occluders.
								if(( !( flags & vRENDER_OCCLUDED )) || ( !TestSphereAgainstOccluders( &p_mesh->m_sphere_center, p_mesh->m_sphere_radius )))
								{
									render = true;
								}
							}
						}
					}
					if( render )
					{
						// If the material has changed, submit the new material.
						// LWSS: Remove for PC
						//if( p_mesh->mp_material != p_material )
						//{
						//	p_material = p_mesh->mp_material;
						//	p_material->Submit();
						//}
						p_mesh->Submit();

						// Add this mesh to the visible list, providing it is within bounds.
						visible_mesh_array[visible_mesh_array_index] = p_mesh;
						if( visible_mesh_array_index < ( VISIBLE_MESH_ARRAY_SIZE - 1 ))
							++visible_mesh_array_index;
					}
				}
			}
		}

		// Now draw the semitransparent meshes with shadow mapped on them.
		if( p_scene->m_flags & SCENE_FLAG_RECEIVE_SHADOWS )
		{
			render_shadow_meshes( p_scene, visible_mesh_array, visible_mesh_array_index );
		}

		if( flags & vRENDER_BILLBOARDS )
		{
			BillboardManager.Render( vRENDER_SEMITRANSPARENT );
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Seems removed in PC
//void render_light_glows( bool test )
//{
//	struct sLightGlowVert
//	{
//		D3DVECTOR	m_pos;
//		D3DCOLOR	m_col;
//	};
//
//	static sLightGlowVert verts[4];
//
//	// This function will be called twice per render, once to test the amount of pixels drawn,
//	// the other to actually draw the pixels.
//
//	// Used to figure the right and up vectors for creating screen-aligned particle quads.
//	D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;
//
//	// Concatenate p_matrix with the emmission angle to create the direction.
//	Mth::Vector up( 0.0f, 1.0f, 0.0f, 0.0f );
//
//	// Get the 'right' vector as the cross product of camera 'at' and world 'up'.
//	Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
//	Mth::Vector screen_right	= Mth::CrossProduct( at, up );
//	Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );
//
//	screen_right.Normalize();
//	screen_up.Normalize();
//
//	sLightGlowDetailsTable.IterateStart();
//	sLightGlowDetails *p_details = sLightGlowDetailsTable.IterateNext();
//
//	if( test )
//	{
//		// Turn of z and color writes.
////		D3DDevice_SetRenderState( D3DRS_COLORWRITEENABLE,	0 );
//		D3DDevice_SetRenderState( D3DRS_ZWRITEENABLE,		FALSE );
//
//		set_blend_mode( vBLEND_MODE_DIFFUSE );
//		set_texture( 0, NULL );
//		set_pixel_shader( PixelShader5 );
//		set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
//
//		while( p_details )
//		{
//			// Get a new test index.
//			uint32 index = p_details->m_visibility_test_fifo.AddStatus();
//
//			// Only do the check if there is room on the queue.
//			if( index > 0 )
//			{
//				// For each light glow instance, add a render check.
//				D3DDevice_BeginVisibilityTest();
//
//				// Draw the glow.
//				verts[0].m_pos.x	= p_details->m_pos[X] - ( screen_right[X] * p_details->m_test_radius ) - ( screen_up[X] * p_details->m_test_radius );
//				verts[0].m_pos.y	= p_details->m_pos[Y] - ( screen_right[Y] * p_details->m_test_radius ) - ( screen_up[Y] * p_details->m_test_radius );
//				verts[0].m_pos.z	= p_details->m_pos[Z] - ( screen_right[Z] * p_details->m_test_radius ) - ( screen_up[Z] * p_details->m_test_radius );
//				verts[0].m_col		= 0xFFFFFFFF;
//
//				verts[1].m_pos.x	= p_details->m_pos[X] - ( screen_right[X] * p_details->m_test_radius ) + ( screen_up[X] * p_details->m_test_radius );
//				verts[1].m_pos.y	= p_details->m_pos[Y] - ( screen_right[Y] * p_details->m_test_radius ) + ( screen_up[Y] * p_details->m_test_radius );
//				verts[1].m_pos.z	= p_details->m_pos[Z] - ( screen_right[Z] * p_details->m_test_radius ) + ( screen_up[Z] * p_details->m_test_radius );
//				verts[1].m_col		= 0xFFFFFFFF;
//
//				verts[2].m_pos.x	= p_details->m_pos[X] + ( screen_right[X] * p_details->m_test_radius ) + ( screen_up[X] * p_details->m_test_radius );
//				verts[2].m_pos.y	= p_details->m_pos[Y] + ( screen_right[Y] * p_details->m_test_radius ) + ( screen_up[Y] * p_details->m_test_radius );
//				verts[2].m_pos.z	= p_details->m_pos[Z] + ( screen_right[Z] * p_details->m_test_radius ) + ( screen_up[Z] * p_details->m_test_radius );
//				verts[2].m_col		= 0xFFFFFFFF;
//
//				verts[3].m_pos.x	= p_details->m_pos[X] + ( screen_right[X] * p_details->m_test_radius ) - ( screen_up[X] * p_details->m_test_radius );
//				verts[3].m_pos.y	= p_details->m_pos[Y] + ( screen_right[Y] * p_details->m_test_radius ) - ( screen_up[Y] * p_details->m_test_radius );
//				verts[3].m_pos.z	= p_details->m_pos[Z] + ( screen_right[Z] * p_details->m_test_radius ) - ( screen_up[Z] * p_details->m_test_radius );
//				verts[3].m_col		= 0xFFFFFFFF;
//
//				D3DDevice_DrawVerticesUP( D3DPT_QUADLIST, 4, verts, sizeof( sLightGlowVert ));
//
//				// Push a visibility check onto the queue.
//				D3DDevice_EndVisibilityTest( index );
//			}
//
//			p_details = sLightGlowDetailsTable.IterateNext();
//		}
//
//		// Restore z and color writes.
//		D3DDevice_SetRenderState( D3DRS_COLORWRITEENABLE,	D3DCOLORWRITEENABLE_ALL );
//		D3DDevice_SetRenderState( D3DRS_ZWRITEENABLE,		TRUE );
//	}
//	else
//	{
//		set_blend_mode( vBLEND_MODE_BLEND );
//		set_pixel_shader( PixelShader5 );
//		set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
//
//		while( p_details )
//		{
//			// Get the visibility check result.
//			uint32 result = p_details->m_visibility_test_fifo.GetStatus();
//
//			if( result > 0 )
//			{
//				// Tend the radius towards the target.
//				p_details->m_current_radius += ( p_details->m_glow_radius - p_details->m_current_radius ) * p_details->m_radius_growth;
//			}
//			else
//			{
//				// Tend the radius towards zero.
//				p_details->m_current_radius -= p_details->m_current_radius * p_details->m_radius_growth;
//			}
//
//			if( p_details->
//				m_current_radius > 0.0f )
//			{
//				// Draw the glow.
//				verts[0].m_pos.x	= p_details->m_pos[X] - ( screen_right[X] * p_details->m_current_radius ) - ( screen_up[X] * p_details->m_current_radius );
//				verts[0].m_pos.y	= p_details->m_pos[Y] - ( screen_right[Y] * p_details->m_current_radius ) - ( screen_up[Y] * p_details->m_current_radius );
//				verts[0].m_pos.z	= p_details->m_pos[Z] - ( screen_right[Z] * p_details->m_current_radius ) - ( screen_up[Z] * p_details->m_current_radius );
//				verts[0].m_col		= 0x40FFFFFF;
//
//				verts[1].m_pos.x	= p_details->m_pos[X] - ( screen_right[X] * p_details->m_current_radius ) + ( screen_up[X] * p_details->m_current_radius );
//				verts[1].m_pos.y	= p_details->m_pos[Y] - ( screen_right[Y] * p_details->m_current_radius ) + ( screen_up[Y] * p_details->m_current_radius );
//				verts[1].m_pos.z	= p_details->m_pos[Z] - ( screen_right[Z] * p_details->m_current_radius ) + ( screen_up[Z] * p_details->m_current_radius );
//				verts[1].m_col		= 0x40FFFFFF;
//
//				verts[2].m_pos.x	= p_details->m_pos[X] + ( screen_right[X] * p_details->m_current_radius ) + ( screen_up[X] * p_details->m_current_radius );
//				verts[2].m_pos.y	= p_details->m_pos[Y] + ( screen_right[Y] * p_details->m_current_radius ) + ( screen_up[Y] * p_details->m_current_radius );
//				verts[2].m_pos.z	= p_details->m_pos[Z] + ( screen_right[Z] * p_details->m_current_radius ) + ( screen_up[Z] * p_details->m_current_radius );
//				verts[2].m_col		= 0x40FFFFFF;
//
//				verts[3].m_pos.x	= p_details->m_pos[X] + ( screen_right[X] * p_details->m_current_radius ) - ( screen_up[X] * p_details->m_current_radius );
//				verts[3].m_pos.y	= p_details->m_pos[Y] + ( screen_right[Y] * p_details->m_current_radius ) - ( screen_up[Y] * p_details->m_current_radius );
//				verts[3].m_pos.z	= p_details->m_pos[Z] + ( screen_right[Z] * p_details->m_current_radius ) - ( screen_up[Z] * p_details->m_current_radius );
//				verts[3].m_col		= 0x40FFFFFF;
//
//				D3DDevice_DrawVerticesUP( D3DPT_QUADLIST, 4, verts, sizeof( sLightGlowVert ));
//			}
//
//			p_details = sLightGlowDetailsTable.IterateNext();
//		}
//	}
//}




} // namespace NxXbox

