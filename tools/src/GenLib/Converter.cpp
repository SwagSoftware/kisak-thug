//****************************************************************************
//* MODULE:         Tools/Utils
//* FILENAME:       Converter.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  2/19/2002
//****************************************************************************

#define __USE_OLD_STREAMS__

#include "Converter.h"

#include "Utility.h"
#include "VirtualFile.h"

// eventually, fstreams should be replaced
// with calls to the virtual file class.
//#include <iostream>
#include <fstream.h>

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

CBaseConverter::CBaseConverter()
{
	m_debugMode = false;

	m_argc = 0;
	m_argv = NULL;

	m_platform = Utils::vPLATFORM_NONE;

	strcpy( m_currentInputFile, "Uninitialized" );
	strcpy( m_currentOutputFile, "Uninitialized" );

	// make sure it starts in a fresh state
	Reset();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseConverter::~CBaseConverter()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBaseConverter::SetArgs( int argc, char** argv )
{
	m_argc = argc;
	m_argv = argv;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBaseConverter::Reset()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBaseConverter::SetDebugMode( bool debugMode )
{
	m_debugMode = debugMode;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBaseConverter::SetPlatform( int platform )
{
	m_platform = platform;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBaseConverter::Convert( const char* pInputFileName, const char* pOutputFileName, int platform )
{
	// before converting, make sure it starts in a fresh state
	Reset();

	// remember the name of the current file being exported
	strcpy( m_currentInputFile, pInputFileName );
	strcpy( m_currentOutputFile, pOutputFileName );

	IoUtils::CVirtualInputFile theInputFile;
	int bytesRead = theInputFile.Load( pInputFileName );
	if ( !bytesRead )
	{
		printf( "Couldn't open input file %s.\n", pInputFileName );
		exit(1);
	}

	if ( ReadInputFile( &theInputFile ) == 0 )
	{
		printf( "Error while reading input file %s\n", pInputFileName );
		exit(1);
	}

	// 10-meg buffer
	IoUtils::CVirtualOutputFile theOutputFile;
	theOutputFile.Init(10*1024*1024);

	bool reverseByteOrder = ( platform == Utils::vPLATFORM_NGC );

	if ( WriteOutputFile( &theOutputFile, reverseByteOrder ) == 0 )
	{
		printf( "Error while writing output file %s\n", pOutputFileName );
		exit(1);
	}

	if ( !theOutputFile.Save( pOutputFileName ) )
	{
		printf( "Error while writing output file %s\n", pOutputFileName );
		return false;
	}

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBaseConverter::ReadInputFile( IoUtils::CVirtualInputFile* pInputFile )
{
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBaseConverter::WriteOutputFile( IoUtils::CVirtualOutputFile* pOutputFile, bool reverseByteOrder )
{
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void ConverterMain( CBaseConverter* pConverter, int argc, char* argv[] )
{
	pConverter->SetArgs( argc, argv );

	pConverter->Reset();

	char* pInputFileName = NULL;
	char* pBatchFileName = NULL;
	int platform = Utils::vPLATFORM_NONE;
	bool debugMode = false;

	char* pArg = NULL;

	if ( pArg = Utils::TestArg( argc, argv, '?' ) )
	{
		pConverter->PrintUsage();
		exit(0);
	}

	if ( pArg = Utils::TestArg( argc, argv, 'P' ) )
	{
		switch ( *pArg )
		{
			case 'P':
			case 'p':
				platform = Utils::vPLATFORM_PS2;
				break;
			case 'G':
			case 'g':
				platform = Utils::vPLATFORM_NGC;
				break;
			case 'X':
			case 'x':
				platform = Utils::vPLATFORM_XBOX;
				break;
		}
	}
	
	if ( platform == Utils::vPLATFORM_NONE )
	{
		pConverter->PrintUsage();
		exit(1);
	}

	if ( pArg = Utils::TestArg( argc, argv, 'D' ) )
	{
		pConverter->SetDebugMode( true );
	}

	pConverter->SetPlatform( platform );

	if ( pArg = Utils::TestArg( argc, argv, 'B' ) )
	{
		pBatchFileName = pArg;

		fstream batchStream( pBatchFileName, ios::in | ios::nocreate );
		if ( !batchStream.is_open() )
		{
			printf( "Error!  Could not open %s\n", pBatchFileName );
			batchStream.close();
			exit(1);
		}

		while ( !batchStream.eof() )
		{
			char lineBuf[256];
			batchStream.getline( &lineBuf[0], 256 );
			if ( batchStream.eof() )
			{
				break;
			}

			char OutputFileName[_MAX_PATH];
			strcpy( OutputFileName, lineBuf );
			strcat( OutputFileName, "." );
			strcat( OutputFileName, Utils::GetPlatformExt( platform ) );

			pConverter->Convert( lineBuf, OutputFileName, platform );
		}

		batchStream.close();
	}
	else if ( pArg = Utils::TestArg( argc, argv, 'F' ) )
	{
		pInputFileName = pArg;

		char OutputFileName[_MAX_PATH];
		strcpy( OutputFileName, pInputFileName );
		strcat( OutputFileName, "." );
		strcat( OutputFileName, Utils::GetPlatformExt( platform ) );

		pConverter->Convert( pInputFileName, OutputFileName, platform );
	}
	else
	{
		pConverter->PrintUsage();
		exit(1);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

};