//****************************************************************************
//* MODULE:         Tools/Utils
//* FILENAME:       VirtualFile.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  9/24/2002
//****************************************************************************

#ifdef __PLAT_WN32__
#include <windows.h>
#endif

#include "VirtualFile.h"

#include <memory.h>
#include <stdio.h>

#include "Utility.h"

void GenFilename(char* buf)
{
	DWORD rndVal = rand() % 99999999;
	sprintf(buf, "c:\\0x%x.tmp", rndVal);
}

namespace IoUtils
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CVirtualFile::CVirtualFile()
{
	mp_buffer = NULL;
	m_size = 0;
	mp_currentPos = 0;
	m_currentPos = 0;

#ifdef __PLAT_WN32__
	hFileHeap = NULL;
#endif

#ifdef DISABLE_VFILE_PREALLOC
	fp = NULL;
	GenFilename(bufFilename);
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CVirtualFile::~CVirtualFile()
{
#ifndef DISABLE_VFILE_PREALLOC
	Uninit();

	#ifdef __PLAT_WN32__
		//MessageBox(NULL, "About to destroy heap", "HeapDestroy", MB_OK);
		HeapDestroy(hFileHeap);
		//MessageBox(NULL, "Successfully destroyed heap", "HeapDestroy", MB_OK);
	#endif

#else

	if (fp)
		fclose(fp);

	fp = NULL;

#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualFile::Init( int size, char* pData )
{
	Utils::Assert( mp_buffer == NULL, "Buffer already exists!" );
	Utils::Assert( size >= 0, "Size must be positive: (%d bytes/%d)", size, 333 );

#ifndef DISABLE_VFILE_PREALLOC

	#ifdef __PLAT_WN32__
		UINT val = HeapCompact(GetProcessHeap(), 0);
		hFileHeap = HeapCreate(HEAP_GENERATE_EXCEPTIONS, size, 0);

		if (!hFileHeap)
		{
			char buf[256];
			sprintf(buf, "Failed to create heap of %i bytes. (Error: %i)", size, GetLastError());
			MessageBox(NULL, buf, "Failed Heap Create", MB_OK);
			return false;
		}

		mp_buffer = (char*)HeapAlloc(hFileHeap, HEAP_GENERATE_EXCEPTIONS, size);

		if (!mp_buffer)
		{
			MessageBox(NULL, "Failed to allocate buffer", "HeapAlloc", MB_OK);
		}

	#else
		mp_buffer = new char[size];
	#endif

	Utils::Assert( (int)mp_buffer, "Buffer of %i bytes failed to allocate", size );

	if ( pData )
	{
		memcpy(mp_buffer,pData,size);
	}
	else
	{
		//memset(mp_buffer,0,size);
	}

	m_size = size;
	mp_currentPos = &mp_buffer[0];
	m_currentPos = 0;

#else
	fp = fopen(bufFilename, "wb");
	m_size = size;
	mp_currentPos = NULL;
	m_currentPos = 0;

#endif

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualFile::Uninit()
{
#ifndef DISABLE_VFILE_PREALLOC

	if ( mp_buffer )
	{
		#ifdef __PLAT_WN32__
				//MessageBox(NULL, "About to free buffer", "HeapFree", MB_OK);

				HeapFree(hFileHeap, 0, mp_buffer);
				//VirtualFree(mp_buffer, 0, MEM_RELEASE);
		#else
				delete[] mp_buffer;
		#endif
	}
#else
	fclose(fp);

#endif

	m_size = 0;
	mp_currentPos = NULL;
	m_currentPos = 0;

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualFile::SeekPos( int pos )
{
#ifndef DISABLE_VFILE_PREALLOC

		// GJ:  you're allowed to be out of bounds,
		// as long as you don't read or write to it...
		// this lets us do things like Skip() or
		// Align() past the last chunk of data to
		// the byte right after the end of the file...
	#if 0
		if ( pos < 0 || pos >= m_size )
		{
			char error_msg[512];
			sprintf( error_msg, "Tried to seek to an out-of-bounds position (current position = %d; trying to seek position %d; size of file = %d)", m_currentPos, pos, m_size );
			Utils::Assert( 0, error_msg );
			return false;
		}
	#endif

		Utils::Assert( mp_buffer != NULL, "Buffer doesn't exist!" );

		mp_currentPos = &mp_buffer[pos];
		m_currentPos = pos;

#else
		if (!fseek(fp, pos, SEEK_SET) == 0)
			return false;
#endif

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualFile::Align( int alignSize )
{
	// set the cursor to the nearest X bytes
	int remainder = m_currentPos % alignSize;

	if( remainder )
	{
		return SeekPos( alignSize - remainder + m_currentPos );
	}	
	
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualFile::Skip( int numBytes )
{
	// skip X number of bytes
	return SeekPos( m_currentPos + numBytes );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int CVirtualFile::TellPos() const
{
	return m_currentPos;
}

#ifdef DISABLE_VFILE_PREALLOC

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
unsigned int CVirtualFile::DumpToMem(void* pMem, unsigned int max)
{
	bool bFileOpen;

	if (fp)
	{
		fclose(fp);
		bFileOpen = true;
	}
	else
		bFileOpen = false;

	unsigned int size;

	fp = fopen(bufFilename, "rb");

	if (!fp)
		return -1;

	fseek(fp, 0, SEEK_END);
	size = ftell(fp);
	fseek(fp, 0, SEEK_SET);

	if (size > max)
		size = max;

	fread(pMem, size, 1, fp);

	if (!bFileOpen)
		fclose(fp);
	else
	{
		fp = fopen(bufFilename, "wb");

		if (fp)
			fseek(fp, size, SEEK_SET);
		else
			return -2;
	}

	return size;
}

#endif

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CVirtualInputFile::CVirtualInputFile() : CVirtualFile()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CVirtualInputFile::~CVirtualInputFile()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualInputFile::Read( char* pData, int size )
{
#ifndef DISABLE_VFILE_PREALLOC
	if ( m_currentPos < 0 || m_currentPos > (m_size - size) )
	{
		char error_msg[512];
		sprintf( error_msg, "Tried to read data out of bounds (trying to read %d bytes at position %d; size of file = %d)", size, m_currentPos, m_size );
		Utils::Assert( 0, error_msg );
		return false;
	}

	if ( size == 0 )
	{
		// reading 0 bytes is valid
		// but it would be nice to figure out
		// who is actually doing this...
		return true;
	}

	Utils::Assert( pData != NULL, "No return data specified" );
	Utils::Assert( size > 0, "Size must be positive: (Tried to get %d bytes/%d)", size, 555 );

	#if 0
		memcpy(pData,mp_currentPos,size);
		pData+=size;
		mp_currentPos+=size;
		m_currentPos+=size;
	#else

		for ( int i = 0; i < size; i++ )
		{
			*pData = *mp_currentPos;

			pData++;
			mp_currentPos++;
			m_currentPos++;
		}

	#endif

#else
	fread(pData, size, 1, fp);
	pData+=size;
	mp_currentPos+=size;
	m_currentPos+=size;
#endif

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualInputFile::ReadString( char* pReturnString, int size )
{
	// clear it to empty
	*pReturnString = NULL;

	if ( size == 0 )
	{
		// reading 0 bytes is valid
		// but it would be nice to figure out
		// who is actually doing this...
		return true;
	}
	
	Utils::Assert( pReturnString != NULL, "No return data specified" );
	Utils::Assert( size > 0, "Size must be positive: (Tried to get %d bytes/%d)", size, 555 );

	if ( m_currentPos < 0 || m_currentPos >= m_size )
	{
		return false;
	}

	// read one character at a time until we get a NULL character, or until we reach the max characters
	for ( int i = 0; i < size; i++ )
	{
		#ifndef DISABLE_VFILE_PREALLOC
		*pReturnString = *mp_currentPos;
		#else
		*pReturnString = fgetc(fp);
		#endif

		mp_currentPos++;
		m_currentPos++;

		if ( (*pReturnString) == NULL )
		{
			return true;
		}

		if ( (*pReturnString) == '\n' || (*pReturnString) == '\r' )
		{
			// skip over them until we get to the next string
			while ( (*mp_currentPos == '\n') || (*mp_currentPos == '\r') )
			{
				mp_currentPos++;
				m_currentPos++;
			}

			// replace with null-terminator
			*pReturnString = NULL;
			return true;
		}

		if ( m_currentPos >= m_size )
		{
			// got to the end of the file
			// null-terminate it
			*pReturnString = NULL;
			return true;
		}

		pReturnString++;
	}

	// null-terminate it
	*pReturnString = NULL;
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int CVirtualInputFile::Load( const char* pFileName, int fileMode )
{
	Utils::Assert( pFileName != NULL, "No filename" );

	FILE* pFile = NULL;
	
	switch ( fileMode )
	{
		case vTEXT_MODE:
			pFile = fopen( pFileName, "rt" );
			break;
		case vBINARY_MODE:
			pFile = fopen( pFileName, "rb" );
			break;
		default:
			printf( "Unrecognized file mode" );
			return 0;
	}

	int inSize = 0;

#ifndef DISABLE_VFILE_PREALLOC
	if ( pFile )
	{
		int startIn = ftell( pFile );
		fseek( pFile, 0, SEEK_END ); 
		inSize = ftell( pFile ) - startIn;
		fseek( pFile, startIn, SEEK_SET );

		char* pBuffer = new char[inSize];

		fread( pBuffer, inSize, 1, pFile );

		this->Init( inSize, pBuffer );
	
		delete pBuffer;

		fclose( pFile );
	}
#else
	if ( pFile )
	{
		fp = pFile;
		int startIn = ftell( pFile );
		fseek( pFile, 0, SEEK_END ); 
		inSize = ftell( pFile ) - startIn;
		fseek( pFile, startIn, SEEK_SET );
	}
#endif

	return inSize;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CVirtualOutputFile::CVirtualOutputFile() : CVirtualFile()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CVirtualOutputFile::~CVirtualOutputFile()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualOutputFile::WriteString( const char* pString, bool addNewLine )
{
	int size = strlen(pString) + ( addNewLine ? 1 : 0 );

	if ( m_currentPos < 0 || m_currentPos > (m_size - size) )
	{
		char msg[1024];
		sprintf( msg, "Output buffer too small (raise from %dKb)\n", m_size/1024 );
		Utils::Assert( 0, msg );
		return false;
	}

	Utils::Assert( strlen(pString) < 1024, "Msg buffer too small!" );

	char msg[1024 + 1];	// add two for the potential new line

	sprintf( msg, "%s%s", pString, addNewLine ? "\n" : "" );
	return this->Write( msg, strlen(msg), false ); 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualOutputFile::Write( const char* pData, int size, bool reverseByteOrder )
{
#ifndef DISABLE_VFILE_PREALLOC

	if ( m_currentPos < 0 || m_currentPos > (m_size - size) )
	{
		char msg[1024];
		sprintf( msg, "Output buffer too small (raise from %dKb)\n", m_size/1024 );
		Utils::Assert( 0, msg );
		return false;
	}

	if( size == 0 )
	{
		return true;	// nothing to write
	}

	Utils::Assert( pData != NULL, "No return data specified" );
	Utils::Assert( size > 0, "Size must be positive" );

	if ( reverseByteOrder )
	{
		pData += ( size - 1 );

		for ( int i = 0; i < size; i++ )
		{
			*mp_currentPos = *pData;
	
			pData--;
			mp_currentPos++;
			m_currentPos++;
		}
	}
	else
	{
		memcpy( mp_currentPos, pData, size );
		mp_currentPos += size;
		m_currentPos += size;

		#if 0
		for ( int i = 0; i < size; i++ )
		{
			*mp_currentPos = *pData;
	
			pData++;
			mp_currentPos++;
			m_currentPos++;
		}
		#endif
	}
#else
	if (reverseByteOrder)
	{
		Utils::Assert(0, "reverseByteOrder is unsupported with DISABLE_VFILE_PREALLOC");
	}

	fwrite(pData, size, 1, fp);
	pData++;
	mp_currentPos += size;
	m_currentPos += size;
#endif

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CVirtualOutputFile::Save( const char* pFileName, int fileMode )
{
#ifndef DISABLE_VFILE_PREALLOC

	Utils::Assert( pFileName != NULL, "No filename" );
	
	FILE* pFile = NULL;
	
	switch ( fileMode )
	{
		case vTEXT_MODE:
			pFile = fopen( pFileName, "wt" );
			break;
		case vBINARY_MODE:
			pFile = fopen( pFileName, "wb" );
			break;
		default:
			printf( "Unrecognized file mode" );
			return 0;
	}

	if ( !pFile )
	{
		char msg[256];
		sprintf( msg, "Could not open %s for output", pFileName );
		Utils::Assert( 0, msg );
		return 0;
	}

	fwrite( (const void*)mp_buffer, this->TellPos(), 1, pFile );
	fclose( pFile );
#else

	fclose(fp);
	fp = NULL;
	bool bDelOK = DeleteFile(pFileName);
	bool bMoveOK = MoveFile(bufFilename, pFileName);

	DWORD dwErr = GetLastError();

	return bMoveOK;

#endif

	// don't return number of bytes written, because
	// 0 is a valid number of bytes to be written out
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool file_exists(const char* pFileName)
{
	FILE* pFile = fopen( pFileName, "rb" );
	
	if ( !pFile )
	{
		return false;
	}
	else
	{
		fclose( pFile );
		return true;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// for debugging
#define	swap32(_p)	((uint32 *)_p)[0] = ( ((uint8 *)_p)[3] | (((uint8 *)_p)[2]<<8) | (((uint8 *)_p)[1]<<16) | (((uint8 *)_p)[0]<<24) );
#define	swap16(_p)	((uint16 *)_p)[0] = ( ((uint8 *)_p)[1] | (((uint8 *)_p)[0]<<8) );

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool write8(CVirtualOutputFile* pFile, unsigned char* pData, bool reverseByteOrder)
{
	Utils::Assert( pFile != NULL, "No buffer pointer!" );

	unsigned char theData = *pData;

	pFile->Write( (const char*)&theData, 1, reverseByteOrder );

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool write16(CVirtualOutputFile* pFile, unsigned short* pData, bool reverseByteOrder)
{
	Utils::Assert( pFile != NULL, "No buffer pointer!" );

	unsigned short theData = *pData;

#if 1
	pFile->Write( (const char*)&theData, 2, reverseByteOrder );
#else
	// tests the byte-swapping code
	swap16(&theData);
	pFile->Write( (const char*)&theData, 2, !reverseByteOrder );
#endif

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool write32(CVirtualOutputFile* pFile, unsigned int* pData, bool reverseByteOrder)
{
	Utils::Assert( pFile != NULL, "No buffer pointer!" );

	unsigned int theData = *pData;

#if 1
	pFile->Write( (const char*)&theData, 4, reverseByteOrder );
#else
	// tests the byte-swapping code
	swap32(&theData);
	pFile->Write( (const char*)&theData, 4, !reverseByteOrder );
#endif

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

};