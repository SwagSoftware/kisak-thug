//****************************************************************************
//* MODULE:         Tools/Utils
//* FILENAME:       Utility.h
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  9/25/2002
//****************************************************************************

#ifndef __UTILITY_H__
#define __UTILITY_H__

// some utility functions

namespace Utils
{
	// had to rename these from vPLAT_PS2, et al.
	// because of the global name conflict
	typedef enum
	{
		vPLATFORM_PS2,
		vPLATFORM_NGC,
		vPLATFORM_XBOX,
		vNUM_PLATFORMS,
		vPLATFORM_PCVIEWER,
		vPLATFORM_NONE,
	};

	void	Assert( int condition, char* pMessage, ... );
	int		GetTimeStamp( const char* pFileName );
	int		GetFileSize( const char* pFileName );
	void	RemoveDirs(char* dirs);
	bool	UpToDate( const char* pSrcName, const char* pDstName, const char* pExeName );

	const char* GetProjRoot();
	char* GetPlatformExt( int platform );
	void PrintTime( char* pMsg = 0 );
	bool UpToDate( char* pSrcFileName, char* pDstFileName );
	char* TestArg( int argc, char* argv[], char pTest );
	void SplitFileExt( const char* pSrcBuf, char* pFileBuf, char* pExtBuf );
};

#endif