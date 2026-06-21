//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       camera.cpp
//* OWNER:          Mark Burton
//* CREATION DATE:  1/31/1999
//****************************************************************************

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <core/allmath.h>
#include <core/singleton.h>
#include <gfx/gfxman.h>
#include <gfx/camera.h>
#include <gfx/nx.h>
#include <gfx/nxviewman.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

namespace Gfx
{

/*****************************************************************************
**								  Externals									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/


/*****************************************************************************
**								Private Types								**
*****************************************************************************/


/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

const float	Camera::vDEFAULT_NEARZ		= 12.0f;
const float	Camera::vDEFAULT_FARZ		= 12000.0f;

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

const float Camera::vUSE_PIXEL_RATIO	= 0.0f;

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/


/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/


/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

Camera::Camera ( )
{	
	//SetFOV ( Mth::DegToRad ( 60.0f ));
	SetHFOV(Nx::CViewportManager::sGetDefaultAngle());

	m_matrix.Ident();	// Since the default constructor doesn't do this

	m_near_clip = vDEFAULT_NEARZ;
	m_far_clip = vDEFAULT_FARZ;
	m_pos.Set();
	m_old_pos.Set();
	m_interp_prev_matrix.Ident();
	m_interp_prev_pos.Set();
	m_interp_prev_hfov = m_h_fov;
	m_interp_valid     = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Camera::~Camera ( void )
{   
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void Camera::SetHFOV(float h_fov)
{
	m_h_fov = h_fov;
	//Dbg_Message("Changed camera %x to angle %f", this, m_h_fov);

	UpdateAdjustedHFOV();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void Camera::UpdateAdjustedHFOV()
{
	m_adj_h_fov = Mth::RadToDeg( 2.0f * atanf( tanf( Mth::DegToRad( m_h_fov / 2.0f ) ) * Nx::CViewportManager::sGetScreenAngleFactor() ) );
	//Dbg_Message("%x: Orig angle %f; Adjusted angle %f", this, m_h_fov, m_adj_h_fov);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float Camera::GetAdjustedHFOV()
{
	// Garrett: m_adj_h_fov may not be right, so we calculate it every time we need it now.  Will try to keep it
	// up-to-date at a later date.
	UpdateAdjustedHFOV();

	return m_adj_h_fov;
#if 0
	return Mth::RadToDeg( 2.0f * atanf( tanf( Mth::DegToRad( m_h_fov / 2.0f ) ) * Nx::CViewportManager::sGetScreenAngleFactor() ) );
#endif
}

#if 0
/******************************************************************************
 *
 * Function:		Camera::SetFocalLength ( float focal_length, float h_aspect )
 *
 * Description:		Sets the camera viewplane according to focal length
 *
 * Parameters:		focal_length = focal length of lens in meters 
 *					h_aspect = horizontal aspect scale factor
 *
 * Notes:			focal_length of 0.035 is equal to a 35mm lens.
 *
 *					You cannot set horizontally or vertically flipped
 *					viewplanes diRectly with this function
 *
 *					focal_length is clamped to a minimum value of N_EPSILON
 *
 ******************************************************************************/

void Camera::SetFocalLength ( float focal_length, float h_aspect )
{
	float fov = atanf (( 18.0f / 1000.0f) / Mth::Max ( Mth::EPSILON, focal_length )) * 2.0f;
	
	SetFOV ( fov, h_aspect );
}

/******************************************************************************
 *
 * Function:		Camera::SetViewPlane ( float h_fov, float v_fov )
 *
 * Description:		Sets the camera view plane with two FOV angles 
 *
 * Parameters:		h_fov	= horizontal FOV angle in radians [-N_PI,+N_PI]
 *					v_fov	= vertical FOV angle in radians	  [_N_PI,+N_PI]
 *
 * Notes:			The FOV angles are clamped separately, i.e. if clamping
 *					occurs due to too large an angle, the aspect ratio is
 *					affected.
 *					
 ******************************************************************************/

void Camera::SetViewPlane ( float h_fov, float v_fov )
{
	

}

/******************************************************************************
 *
 * Function:		Camera::SetFOV ( float fov, float h_aspect )
 *
 * Description:		Sets camera view plane with a field-of-view angle
 *					and an aspect ratio
 *
 * Parameters:		fov		 = FOV angle in radians
 *					h_aspect = horizontal aspect ratio ( default: vp pixel ratio )
 *					
 ******************************************************************************/

void Camera::SetFOV ( float v_fov, float h_aspect )
{
	
/*
	float x,y 
	
	v_fov = Mth::Abs ( v_fov );
	v_fov = Mth::Clamp ( v_fov, Mth::EPSILON, Mth::PI - Mth::EPSILON );
	
	v_fov = tan ( v_fov / 2.0f );
	
	h_aspect = ( h_aspect == vUSE_PIXEL_RATIO ) ? m_viewport->GetPixelRatio() : h_aspect; 

	x = v_fov * h_aspect;
	y = v_fov;
  
// Mick: x and y contain the view window x and y   
*/
    

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float Camera::GetFOV ( void )
{
	// Mick: not meaningful......
	return 0.0f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float Camera::GetFocalLength ( void )
{	
	// Mick: not meaningful......
	return 0.0f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float Camera::GetAspectRatio ( void )
{
	// Mick: not meaningful......
	return 0.0f;

}
#endif

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void Camera::StoreOldPos( void )
{
	m_old_pos = GetPos();
}

/******************************************************************/
/* Render-rate interpolation (decouple P1).                       */
/* SnapshotInterpView() runs once per fixed sim step (before the  */
/* step moves the camera); GetInterpolatedView() lerps the stored */
/* "previous" pose -> the current pose at render time. Render-only.*/
/******************************************************************/

void Camera::SnapshotInterpView( void )
{
	m_interp_prev_matrix = m_matrix;
	m_interp_prev_pos    = m_pos;
	m_interp_prev_hfov   = GetAdjustedHFOV();
	m_interp_valid       = true;
}

/******************************************************************/

void Camera::ResetInterpView( void )
{
	m_interp_valid = false;
}

/******************************************************************/

void Camera::GetInterpolatedView( float alpha, Mth::Matrix& out_matrix, Mth::Vector& out_pos, float& out_hfov )
{
	float cur_hfov = GetAdjustedHFOV();

	if( alpha < 0.0f ) alpha = 0.0f;
	if( alpha > 1.0f ) alpha = 1.0f;

	// No valid history (fresh camera / just reset) -> render at the current pose.
	if( !m_interp_valid )
	{
		out_matrix = m_matrix;
		out_pos    = m_pos;
		out_hfov   = cur_hfov;
		return;
	}

	// Cut / teleport guard: a per-step jump far larger than any real camera move means
	// prev and current straddle a discontinuity (respawn, cutscene cut, warp). Lerping
	// across it would smear, so snap to current. (Explicit per-object snap flags = P4.)
	const float vCUT_DIST_SQ = 600.0f * 600.0f;	// (inches/step)^2; normal motion << this
	const float vCUT_DOT     = 0.5f;			// at-vector dot < this => >60 deg/step => cut
	Mth::Vector delta = m_pos - m_interp_prev_pos;
	float dist_sq = delta.GetX()*delta.GetX() + delta.GetY()*delta.GetY() + delta.GetZ()*delta.GetZ();
	float at_dot  = m_matrix.GetAt().GetX() * m_interp_prev_matrix.GetAt().GetX()
				  + m_matrix.GetAt().GetY() * m_interp_prev_matrix.GetAt().GetY()
				  + m_matrix.GetAt().GetZ() * m_interp_prev_matrix.GetAt().GetZ();
	if( dist_sq > vCUT_DIST_SQ || at_dot < vCUT_DOT )
	{
		out_matrix = m_matrix;
		out_pos    = m_pos;
		out_hfov   = cur_hfov;
		return;
	}

	Mth::Slerp( out_matrix, m_interp_prev_matrix, m_matrix, alpha );
	out_pos  = Mth::Lerp( m_interp_prev_pos, m_pos, alpha );
	out_hfov = Mth::Lerp( m_interp_prev_hfov, cur_hfov, alpha );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// Note these are returned by value, until
// we can store them explicity in the camera, and return them by reference
void Camera::SetPos(const Mth::Vector& pos)
{
	m_pos = pos;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Mth::Vector & Camera::GetPos()
{
	return  m_pos;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void Camera::SetMatrix(const Mth::Matrix& mat)
{
	m_matrix = mat;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Mth::Matrix & Camera::GetMatrix()
{
	return m_matrix;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool Camera::CallMemberFunction( uint32 checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( checksum )
	{
		case 0x44ea2b6d:		// ChangeCameraFOV
			{
				float fov;
				pParams->GetFloat( NONAME, &fov, Script::ASSERT );
				//Nx::CViewportManager::sSetScreenAngle( Mth::RadToDeg( fov ) );
				SetHFOV(Mth::RadToDeg(fov));
				return true;
			}
			break;
	}

	return Obj::CObject::CallMemberFunction( checksum, pParams, pScript );
}

} // namespace Gfx
