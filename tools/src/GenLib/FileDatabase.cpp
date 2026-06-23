//****************************************************************************
//* MODULE:         Tools/Genlib
//* FILENAME:       FileDatabase.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  10/9/2002
//****************************************************************************

#include "FileDatabase.h"

#include <io.h>

#include <core/crc.h>

#include "Utility.h"

namespace IoUtils
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFileDatabase::scan_sub_dir( const char* path )
{
	struct _finddata_t file_info;

	char search_string[_MAX_PATH];
	sprintf( search_string, "%s\\*.*", path );

	int handle;
	handle = _findfirst( search_string, &file_info );

	if( handle >= 0 )
	{
		do 
		{
			char ext[_MAX_EXT];
			char cur_file[_MAX_FNAME];

			_splitpath( file_info.name, NULL, NULL, cur_file, ext );

			if( file_info.attrib & _A_SUBDIR )
			{
				if( ( stricmp( file_info.name, "." ) != 0 ) && ( stricmp( file_info.name, ".." ) != 0 ))
				{
					char sub_path[_MAX_PATH];

					sprintf( sub_path, "%s\\%s", path, file_info.name );
					
					scan_sub_dir( sub_path );
				}
			}
			else
			{
				SFileInfo* pInfo = new SFileInfo;
				sprintf( pInfo->pFileName, "%s\\%s", path, file_info.name );

				int len = strlen( pInfo->pFileName ) + 1;
				for ( int i = 0; i < len; i++ )
				{
					if ( pInfo->pFileName[i] == '/' )
					{
						pInfo->pFileName[i] = '\\';
					}
				}

				pInfo->timestamp = file_info.time_write;
				uint32 checksum = Crc::GenerateCRCFromString( pInfo->pFileName );

				// duplicate checksums are now allowed;  we can
				// tell which is the correct info, because
				// we store the filename in there...
//				SFileInfo* pSearchInfo = m_fileHashTable.GetItem( checksum );
//				if ( pSearchInfo )
//				{
//					Utils::Assert( 0, "Checksum clash in filename %s %s (Tell Gary)!", pInfo->pFileName, pSearchInfo->pFileName );
//				}

				m_fileHashTable.PutItem( checksum, pInfo );
			}
		}
		while( _findnext( handle, &file_info ) == 0 );

		_findclose( handle );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CFileDatabase::CFileDatabase( int numBits ) : m_fileHashTable( numBits )
{
	m_fileHashTable.AllowDuplicateKeys( true );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CFileDatabase::~CFileDatabase()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFileDatabase::RefreshFileList( const char* pRootPath )
{
	m_fileHashTable.FlushAllItems();

	scan_sub_dir( pRootPath );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CFileDatabase::FileExists( const char* pFileName )
{
	uint32 checksum = Crc::GenerateCRCFromString( pFileName );

	SFileInfo* pInfo = m_fileHashTable.GetItem( checksum );

	char temp[_MAX_PATH];
	int len = strlen( pFileName ) + 1;
	for ( int i = 0; i < len; i++ )
	{
		temp[i] = pFileName[i];
		if ( temp[i] == '/' )
		{
			temp[i] = '\\';
		}
	}

	while ( pInfo )
	{
		if ( !stricmp( pInfo->pFileName, temp ) )
		{
			// already exists
			return true;
		}

		pInfo = m_fileHashTable.GetNextItemWithSameKey( checksum, pInfo );
	}

	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFileDatabase::AddFile( const char* pFileName, int timestamp )
{
	if ( !FileExists(pFileName) )
	{
		SFileInfo* pInfo = new SFileInfo;
		strcpy( pInfo->pFileName, pFileName );

		int len = strlen( pInfo->pFileName ) + 1;
		for ( int i = 0; i < len; i++ )
		{
			if ( pInfo->pFileName[i] == '/' )
			{
				pInfo->pFileName[i] = '\\';
			}
		}

		pInfo->timestamp = timestamp;

		uint32 checksum = Crc::GenerateCRCFromString( pInfo->pFileName );
		m_fileHashTable.PutItem( checksum, pInfo );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int CFileDatabase::GetFileTime( const char* pFileName )
{
	uint32 checksum = Crc::GenerateCRCFromString( pFileName );

	SFileInfo* pInfo = m_fileHashTable.GetItem( checksum );

	char temp[_MAX_PATH];
	int len = strlen( pFileName ) + 1;
	for ( int i = 0; i < len; i++ )
	{
		temp[i] = pFileName[i];
		if ( temp[i] == '/' )
		{
			temp[i] = '\\';
		}
	}

	while ( pInfo )
	{
		if ( !stricmp( pInfo->pFileName, temp ) )
		{
			return pInfo->timestamp;
		}

		pInfo = m_fileHashTable.GetNextItemWithSameKey( checksum, pInfo );
	}

	return -1;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int CFileDatabase::GetSize()
{
	return m_fileHashTable.GetSize();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFileDatabase::IterateStart()
{
	m_fileHashTable.IterateStart();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

SFileInfo* CFileDatabase::IterateNext()
{
	uint32 dummy;
	return m_fileHashTable.IterateNext( &dummy );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

};