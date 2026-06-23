//****************************************************************************
//* MODULE:         Tools/Utils
//* FILENAME:       Utility.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  9/25/2002
//****************************************************************************

#include "utility.h"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <io.h>
#include <windows.h>
#include <direct.h>
#include <sys/stat.h>

namespace Utils
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

const char *GetProjRoot()
{
	static const char *sp_proj_root = NULL;
	if (!sp_proj_root)
	{
		sp_proj_root=getenv( "PROJ_ROOT" );
		Utils::Assert(sp_proj_root!=NULL,("You must first define your PROJ_ROOT environment variable"));
	}
	return sp_proj_root;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void Assert( int condition, char* pMessage, ... )
{
	char pad[1024];
	
	if ( condition ) 
	{
		return;
	}
	
	va_list args;
	
	va_start( args, pMessage );
	vsprintf( pad, pMessage, args);
	va_end( args );

	printf("ERROR: ");
	printf( pad );
	printf("\n");

	exit(1);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

char* GetPlatformExt( int platform )
{
	switch ( platform )
	{
		case vPLATFORM_PS2:
			return "ps2";
		case vPLATFORM_XBOX:
			return "xbx";
		case vPLATFORM_NGC:
			return "ngc";
		case vPLATFORM_PCVIEWER:
			return "pcv";
		default:
			return "none";
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void PrintTime( char* pMsg )
{
	return;

	SYSTEMTIME st;
	GetSystemTime(&st);

	if ( pMsg )
	{
		printf( "%s: ", pMsg );
	}

	printf( "%d:%02d:%03d\n", st.wMinute, st.wSecond, st.wMilliseconds );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

char* TestArg( int argc, char* argv[], char testChar )
{
	// make it caseinsensitive...

	if ( testChar >= 'A' && testChar <= 'Z' )
	{
		// to lowercase
		testChar = testChar - 'A' + 'a';
	}

	if( argc > 1 )
	{
		for ( int i = 1; i < argc; i++ )
		{
			if( argv[i][0] == '-' )
			{
				char argChar = argv[i][1];
				if ( argChar >= 'A' && argChar <= 'Z' )
				{
					// to lowercase
					argChar = argChar - 'A' + 'a';
				}

				if ( testChar == argChar )
				{
					return &argv[i][2];
				}
			}
		}
	}

	return NULL;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool UpToDate( const char* pSrcName, const char* pDstName, const char* pExeName )
{
	int theDstTimeStamp = Utils::GetTimeStamp(pDstName);
	if ( theDstTimeStamp != -1 )
	{
		int theExeTimeStamp = Utils::GetTimeStamp(pExeName);
		if ( theExeTimeStamp == -1 )
		{
			fprintf( stderr, "Cannot find .exe file: %s\n", pExeName );
			exit(1);
		}

		int theSrcTimeStamp = Utils::GetTimeStamp(pSrcName);
		if ( theSrcTimeStamp < theDstTimeStamp 
			&& theExeTimeStamp < theDstTimeStamp )
		{
			//printf( "Up to date.\n" );
			return true;
		}
	}
	
	// needs updating
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int GetTimeStamp( const char* pSearchFileName )
{
	struct stat SourceStatBuf;
	if ( stat(pSearchFileName, &SourceStatBuf) != -1 )
	{
		return SourceStatBuf.st_mtime;
	}
	else
	{
		return -1;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int GetFileSize( const char* pSearchFileName )
{
	struct stat SourceStatBuf;
	if ( stat(pSearchFileName, &SourceStatBuf) != -1 )
	{
		return SourceStatBuf.st_size;
	}
	else
	{
		return -1;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// Remove directory and any directory above that is empty
void RemoveDirs(char* dirs)
{
	char curdir[1024];

	strcpy(curdir, dirs);

	// Get rid of trailing backslashes
	while(curdir[strlen(curdir) - 1] == '\\')
	{
		curdir[strlen(curdir) - 1] = '\0';
	}

	while(_rmdir(curdir) == 0)
	{
		printf("Removed empty directory %s\n", curdir);

		char* cpos = strrchr(curdir, '\\');

		if (cpos)
		{
			// go up one directory
			*cpos = '\0';
			printf("Trying to remove directory %s\n", curdir);
		}
		else
		{
			// We are done
			break;
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void SplitFileExt( const char* pSrcBuf, char* pFileBuf, char* pExtBuf )
{
	strcpy( pFileBuf, pSrcBuf );
	strcpy( pExtBuf, "" );
	
	for ( int i = strlen( pFileBuf )-1; i >= 0; i-- )
	{
		if ( pFileBuf[i] == '.' )
		{
			strcpy( pExtBuf, &pFileBuf[i+1] );
			pFileBuf[i] = NULL;
			break;
		}
	}

//	printf( "splitting '%s' into '%s' and '%s'\n", pSrcBuf, pFileBuf, pExtBuf );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

};