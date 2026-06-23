//****************************************************************************
//* MODULE:         Tools/Genlib
//* FILENAME:       FileDatabase.h
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  10/9/2002
//****************************************************************************

#ifndef __FILEDATABASE_H__
#define __FILEDATABASE_H__

#ifndef __CORE_DEFINES_H__
	#include <core/defines.h>
#endif

#ifndef __CORE_HASHTABLE_H__
	#include <core/hashtable.h>
#endif

#include <stdlib.h>

namespace IoUtils {

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

struct SFileInfo
{
	char		pFileName[_MAX_PATH];
	int			timestamp;
};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

class CFileDatabase
{
public:
	CFileDatabase( int numBits = 10 );
	virtual	~CFileDatabase();

public:
	void		RefreshFileList( const char* pRootPath );
	int			GetFileTime( const char* pSearchFileName );
	int			GetSize();
	void		IterateStart();
	SFileInfo*	IterateNext();
	bool		FileExists( const char* pSearchFileName );
	void		AddFile( const char* pFileName, int timeStamp = 0 );

protected:
	void		scan_sub_dir( const char* path );

protected:
	Lst::HashTable<SFileInfo> m_fileHashTable;
};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

};

#endif