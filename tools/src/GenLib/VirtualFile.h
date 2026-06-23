//****************************************************************************
//* MODULE:         Tools/Genlib
//* FILENAME:       VirtualFile.h
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  9/24/2002
//****************************************************************************

#ifndef __VIRTUALFILE_H__
#define __VIRTUALFILE_H__

#ifdef __PLAT_WN32__
#include <windows.h>
#endif

#ifndef __CORE_DEFINES_H__
	#include <Core/Defines.h>
#endif

#ifdef DISABLE_VFILE_PREALLOC
	#include "Utility.h"
#endif

namespace IoUtils {

	enum
	{
		vTEXT_MODE,
		vBINARY_MODE,
	};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// these classes allow us to reduce the number of file
// reads/writes (which are extremely slow) by letting us
// manipulate a single buffer in memory (which can be read
// in with a single file read, or can be written out in 
// a single file write)

// example usage for read buffer:
// CVirtualInputFile myInputFile;
// int bytesRead = myInputFile.Load("c:\\skate5\\data\\anims\\skater_basics\\idle.ska");
// if ( !bytesRead )
//		printf("Load error!");
// endif
// myInputFile.Read(&someData1, sizeof(uint32));
// myInputFile.Read(&someData2, sizeof(uint16));
// myInputFile.Read(&someData3, sizeof(uint16));
// myInputFile.Read(&someData4, sizeof(uint32));

// example usage for write buffer:
// CVirtualOutputFile myOutputFile;
// myOutputFile.Init(1024*1024);	// set up a 1-meg max buffer
// myOutputFile.Write(&someData1, sizeof(uint32), reverseByteOrder);
// myOutputFile.Write(&someData2, sizeof(uint16), reverseByteOrder);
// myOutputFile.Write(&someData3, sizeof(uint16), reverseByteOrder);
// myOutputFile.Write(&someData4, sizeof(uint32), reverseByteOrder);
// bytesRead = myOutputFile.Save("c:\\skate5\\data\\anims\\skater_basics\\idle.ska.ps2");
// if ( !bytesRead )
//		printf("Save error!");
// endif

class CVirtualFile
{
protected:
	CVirtualFile();
	~CVirtualFile();

#ifdef DISABLE_VFILE_PREALLOC
	FILE* fp;
	char  bufFilename[256];
#endif

#ifdef __PLAT_WN32__
	HANDLE hFileHeap;
#endif

public:
	bool	Init( int size, char* pData = NULL );
	bool	Uninit();
	bool	SeekPos( int pos );
	int		TellPos() const;
	bool	Align( int alignSize );
	bool	Skip( int numBytes );

#ifdef DISABLE_VFILE_PREALLOC
	unsigned int DumpToMem(void* pMem, unsigned int max);
#endif

#ifndef DISABLE_VFILE_PREALLOC
	inline char* GetBuffer()     { return mp_buffer; }
#else
	inline char* GetBuffer()
	{
		Utils::Assert( 0, "Cannot use GetBuffer call with DISABLE_VFILE_PREALLOC defined" );
		__asm int 3;
		return NULL;
	}
#endif

	inline int   GetBufferSize() { return (int)(mp_currentPos - mp_buffer); }

protected:
	char*	mp_buffer;
	int		m_size;
	char*	mp_currentPos;
	int		m_currentPos;
};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

class CVirtualInputFile : public CVirtualFile
{
public:
	CVirtualInputFile();
	~CVirtualInputFile();

public:
	bool	Read( char* pData, int size );
	bool	ReadString( char* pData, int size );
	int		Load( const char* pFileName, int filemode = vBINARY_MODE );	// returns size of file read
};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

class CVirtualOutputFile : public CVirtualFile
{
public:
	CVirtualOutputFile();
	~CVirtualOutputFile();

public:
	bool	Write( const char* pData, int size, bool reverseByteOrder = false );
	bool	WriteString( const char* pString, bool addNewLine );
	bool	Save( const char* pFileName, int filemode = vBINARY_MODE );	// returns 0 on failure
};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// some convenience functions for backwards-compatibility
bool write8(CVirtualOutputFile* pFileBuffer, unsigned char* pData, bool reverseByteOrder);
bool write16(CVirtualOutputFile* pFileBuffer, unsigned short* pData, bool reverseByteOrder);
bool write32(CVirtualOutputFile* pFileBuffer, unsigned int* pData, bool reverseByteOrder);

// whether a file exists
bool file_exists(const char* pFileName);

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

};

#endif