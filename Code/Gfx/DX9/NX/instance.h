#ifndef __INSTANCE_H
#define __INSTANCE_H


#include <core/defines.h>
#include <gfx/NxModel.h>
#include "scene.h"

namespace NxXbox
{
void	render_instance( class CInstance *p_instance, uint32 flags );
void	render_instances( uint32 flags );

class CInstance
{
public:

	enum EInstanceFlag
	{
		INSTANCE_FLAG_DELETE_ATTACHED_SCENE	= 0x01,
		INSTANCE_FLAG_LIGHTING_ALLOWED		= 0x02
	};
	

	void			SetTransform( Mth::Matrix &transform )	{ m_interp_prev_transform = m_transform; m_transform = transform; }
	Mth::Matrix*	GetTransform(void)						{ return &m_transform; }
	void			GetInterpolatedTransform( Mth::Matrix& out );	// lerp prev->current by g_render_interp_alpha
	bool			InterpIsCut( void ) const;						// true if root prev/current straddle a cut/teleport

	void			SnapshotBones( Mth::Matrix* pBones, int numBones );

	int				GetNumBones( void )						{ return m_num_bones; }
	Mth::Matrix*	GetBoneTransforms( void )				{ return mp_bone_transforms; }
	void			SetBoneTransforms( Mth::Matrix* p_t )	{ mp_bone_transforms = p_t; }
	sScene*			GetScene( void )						{ return mp_scene; }
	void			SetActive( bool active )				{ m_active = active; }
	bool			GetActive( void )						{ return m_active; }
	void			SetFlag( EInstanceFlag flag )			{ m_flags |= flag; }
	void			ClearFlag( EInstanceFlag flag )			{ m_flags &= ~flag; }
	void			SetModel( Nx::CModel *p_model )			{ mp_model = p_model; }
	Nx::CModel*		GetModel( void )						{ return mp_model; }
	CInstance*		GetNextInstance( void )				{ return mp_next_instance; }

					CInstance( sScene *pScene, Mth::Matrix &transform, int numBones, Mth::Matrix *pBoneTransforms );
					~CInstance();

	void			Render( uint32 flags );
	//void			RenderShadowVolume( void ); // LWSS: commented out. seems unused.

private:
	uint32			m_flags;
	Mth::Matrix		m_transform;
	Mth::Matrix		m_interp_prev_transform;	// previous sim-step root transform (render interpolation)
	Mth::Matrix*	mp_bone_transforms;
	int				m_num_bones;
	// P3 bone interpolation: owned double-buffer of the last two sim-step poses.
	Mth::Matrix*	mp_interp_bones_cur;		// most recent sim-step skeleton pose (copy)
	Mth::Matrix*	mp_interp_bones_prev;		// previous sim-step skeleton pose (copy)
	int				m_interp_num_bones;			// allocated size of the bone buffers
	int				m_interp_bones_snaps;		// snapshots taken since last reset (need 2 to interpolate)
	bool			m_interp_bones_valid;		// false during no-anim / before 2 snapshots
	bool			m_active;
	Nx::CModel*		mp_model;		// Required in order to get pointer to CXboxLights structure at render time.
	sScene*			mp_scene;
	CInstance*		mp_next_instance;
};

extern Mth::Matrix* pBoneTransforms;

} // namespace NxXbox


#endif // __INSTANCE_H

