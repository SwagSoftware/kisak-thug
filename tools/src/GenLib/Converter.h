//****************************************************************************
//* MODULE:         Tools/Utils
//* FILENAME:       Converter.h
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  2/19/2002
//****************************************************************************

// This file contains the CBaseConverter class, which
// contains a bunch of the repeated functionality of
// our asset conversion utilities...

#ifndef __CONVERTER_H__
#define __CONVERTER_H__

#include <stdlib.h>

#include <core/defines.h>

namespace IoUtils
{
	class CVirtualInputFile;
	class CVirtualOutputFile;
}

namespace Utils
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

class CBaseConverter
{
public:
	virtual ~CBaseConverter();

public:
	virtual void	Reset() = 0;
	virtual void	PrintUsage() = 0;
	virtual bool	Convert( const char* pInputFileName, const char* pOutputFileName, int platform );
	void			SetDebugMode( bool debugMode );
	void			SetArgs( int argc, char** argv );
	void			SetPlatform( int platform );

protected:
	CBaseConverter();

protected:
	virtual bool	ReadInputFile( IoUtils::CVirtualInputFile* pInputFile );
	virtual bool	WriteOutputFile( IoUtils::CVirtualOutputFile* pOutputFile, bool reverseByteOrder );

protected:
	bool			m_debugMode;
	int				m_argc;
	char**			m_argv;
	int				m_platform;
	char			m_currentInputFile[_MAX_PATH];
	char			m_currentOutputFile[_MAX_PATH];
};

//ConverterMain() is an easy way of running a utility, given the main() function:
//void main( int argc, char* argv[] )
//{
//		CSkeletonConverter theSkeletonConverter;
//		Utils::ConverterMain( &theSkeletonConverter, argc, argv );
//}

void ConverterMain( CBaseConverter* pConverter, int argc, char* argv[] );

}

#endif