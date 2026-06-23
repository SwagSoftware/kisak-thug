// qcomp.cpp :
//

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <math.h>
#include <string.h>
#include <fstream>
#include <sys/types.h>
#include <sys/stat.h>
#if defined(_WIN32)
#include <io.h>		// _findfirst / _findnext directory walking
#endif

#include <Gel/Scripting/tokens.h>

#include <stdint.h>

// LWSS: when building against the game's <Core/Defines.h> (pulled in via skiptoken.cpp below
// with __PLAT_WN32__ defined), it already typedefs uint32/uint8/uint16 - and as different
// underlying types (unsigned long vs unsigned int), which clashed (C2371). Only define our own
// aliases when those headers aren't providing them.
#ifndef __PLAT_WN32__
typedef uint32_t uint32;
typedef uint8_t uint8;
typedef uint16_t uint16;
#endif

#if defined(_MSC_VER)
#define stricmp _stricmp		// MSVC has no strcasecmp; stricmp/_stricmp is the equivalent
#else
#define stricmp strcasecmp
#endif

#include <Gel/Scripting/skiptoken.cpp>
using namespace Script;

void _MessageBox(const char *body, const char *title);
FILE *_qcomp_fopen(const char *path, char *acess);



// This is so that skiptoken.cpp can be #included.
#define Dbg_MsgAssert( _c, _params )							\
																\
if( !( _c ))													\
{																\
	MsgAssert_PrintfIntoBuffer _params;							\
	Assert( 0, pMsgAssert_Buffer );								\
}


#define FALSE 0
#define TRUE 1

#define MAX_LOG_FILE_CHARS 100
#define LOG_FILE_SUB_PATH "qcomp.log"
FILE *gpLogFile=NULL;

char *FindChecksumName(uint32 Checksum);
void Prt(int x, int Hex=0);
void Prt(float x);
void Prt(const char *pString);
void CheckForInfiniteLoops(uint8 *pQB);
uint8 *CheckLoop(uint8 *pCh);

uint32 GenerateChecksum(const char *pString);
void Message(const char *pMessage);
void Assert(int Condition, char *pMessage);

char *pOutputBuffer=NULL;

#define WORDBUFSIZE 10000
char WordBuffer[WORDBUFSIZE]={0};

bool IncludeLineNumbers=true;
bool CreateTextFile=false;
bool CreateSlickEditErrorMessages=false;
bool ChecksumNames=true;
bool DisplayErrorsInWindow=true;
bool CreateMapFile=false;

enum EEndianness
{
	INTEL,
	MOTOROLA
};

EEndianness Endianness=INTEL;

#define MAXFILENAMELEN 1000
char pSourceName[MAXFILENAMELEN+1]={0};
char pOutputDirectory[MAXFILENAMELEN+1]={0};
char pOutputName[MAXFILENAMELEN+1]={0};

#define MSGASSERT_BUFFER_SIZE 1000
static char pMsgAssert_Buffer[MSGASSERT_BUFFER_SIZE];
void MsgAssert_PrintfIntoBuffer(const char* p_text, ...)
{
	pMsgAssert_Buffer[0]=0;
	if (p_text)
	{
		va_list args;
		va_start( args, p_text );

		sprintf( pMsgAssert_Buffer, p_text, args);
		
		va_end( args );
	}
}

namespace Script
{
	// Used when dumping out a text file.
	const char *GetTokenName(EScriptToken Token)
	{
		switch (Token)
		{
		case ESCRIPTTOKEN_ENDOFFILE:			return "ENDOFFILE"; break;
		case ESCRIPTTOKEN_ENDOFLINE:			return "ENDOFLINE"; break;
		case ESCRIPTTOKEN_ENDOFLINENUMBER:		return "ENDOFLINENUMBER"; break;
		case ESCRIPTTOKEN_STARTSTRUCT:			return "STARTSTRUCT"; break;
		case ESCRIPTTOKEN_ENDSTRUCT:			return "ENDSTRUCT"; break;
		case ESCRIPTTOKEN_STARTARRAY:			return "STARTARRAY"; break;
		case ESCRIPTTOKEN_ENDARRAY:				return "ENDARRAY"; break;
		case ESCRIPTTOKEN_EQUALS:				return "EQUALS"; break;
		case ESCRIPTTOKEN_DOT:					return "DOT"; break;
		case ESCRIPTTOKEN_COMMA:				return "COMMA"; break;
		case ESCRIPTTOKEN_MINUS:				return "MINUS";		break;
		case ESCRIPTTOKEN_ADD:					return "ADD";			break;
		case ESCRIPTTOKEN_DIVIDE:				return "DIVIDE";		break;
		case ESCRIPTTOKEN_MULTIPLY:				return "MULTIPLY";	break;
		case ESCRIPTTOKEN_OPENPARENTH:			return "OPENPARENTH";break;
		case ESCRIPTTOKEN_CLOSEPARENTH:			return "CLOSEPARENTH";break;
		case ESCRIPTTOKEN_DEBUGINFO:			return "DEBUGINFO"; break;
		case ESCRIPTTOKEN_SAMEAS:				return "SAMEAS"; break;
		case ESCRIPTTOKEN_LESSTHAN:				return "LESSTHAN"; break;
		case ESCRIPTTOKEN_LESSTHANEQUAL:		return "LESSTHANEQUAL"; break;
		case ESCRIPTTOKEN_GREATERTHAN:			return "GREATERTHAN"; break;
		case ESCRIPTTOKEN_GREATERTHANEQUAL:		return "GREATERTHANEQUAL"; break;
		case ESCRIPTTOKEN_NAME:					return "NAME"; break;
		case ESCRIPTTOKEN_INTEGER:				return "INTEGER"; break;
		case ESCRIPTTOKEN_HEXINTEGER:			return "HEXINTEGER"; break;
		case ESCRIPTTOKEN_FLOAT:				return "FLOAT"; break;
		case ESCRIPTTOKEN_STRING:				return "STRING"; break;
		case ESCRIPTTOKEN_LOCALSTRING:			return "LOCALSTRING"; break;
		case ESCRIPTTOKEN_ARRAY:				return "ARRAY"; break;
		case ESCRIPTTOKEN_VECTOR:				return "VECTOR"; break;
		case ESCRIPTTOKEN_PAIR:					return "PAIR"; break;
		case ESCRIPTTOKEN_KEYWORD_BEGIN:		return "KEYWORD_BEGIN"; break;
		case ESCRIPTTOKEN_KEYWORD_REPEAT:		return "KEYWORD_REPEAT"; break;
		case ESCRIPTTOKEN_KEYWORD_BREAK:		return "KEYWORD_BREAK"; break;
		case ESCRIPTTOKEN_KEYWORD_SCRIPT:		return "KEYWORD_SCRIPT"; break;
		case ESCRIPTTOKEN_KEYWORD_ENDSCRIPT:	return "KEYWORD_ENDSCRIPT"; break;
		case ESCRIPTTOKEN_KEYWORD_IF:			return "KEYWORD_IF"; break;
		case ESCRIPTTOKEN_KEYWORD_ELSE:			return "KEYWORD_ELSE"; break;
		case ESCRIPTTOKEN_KEYWORD_ELSEIF:		return "KEYWORD_ELSEIF"; break;
		case ESCRIPTTOKEN_KEYWORD_ENDIF:		return "KEYWORD_ENDIF"; break;
		case ESCRIPTTOKEN_KEYWORD_RETURN:		return "KEYWORD_RETURN"; break;
		case ESCRIPTTOKEN_KEYWORD_ALLARGS:		return "KEYWORD_ALLARGS"; break;
		case ESCRIPTTOKEN_ARG:					return "ARG"; break;
		case ESCRIPTTOKEN_CHECKSUM_NAME:		return "CHECKSUM_NAME"; break;
		case ESCRIPTTOKEN_JUMP:					return "JUMP"; break;
		case ESCRIPTTOKEN_KEYWORD_RANDOM:		return "KEYWORD_RANDOM"; break;
		case ESCRIPTTOKEN_KEYWORD_RANDOM_RANGE:	return "KEYWORD_RANDOM_RANGE"; break;
		case ESCRIPTTOKEN_KEYWORD_RANDOM2:		return "KEYWORD_RANDOM2"; break;
		case ESCRIPTTOKEN_KEYWORD_RANDOM_RANGE2:return "KEYWORD_RANDOM_RANGE2"; break;
		case ESCRIPTTOKEN_KEYWORD_RANDOM_NO_REPEAT:return "KEYWORD_RANDOM_NO_REPEAT"; break;
		case ESCRIPTTOKEN_KEYWORD_RANDOM_PERMUTE:return "KEYWORD_RANDOM_PERMUTE"; break;

		case ESCRIPTTOKEN_OR:					return "OR"; break;
		case ESCRIPTTOKEN_AND:					return "AND"; break;
		case ESCRIPTTOKEN_XOR:					return "XOR"; break;
		case ESCRIPTTOKEN_SHIFT_LEFT:			return "SHIFT_LEFT"; break;
		case ESCRIPTTOKEN_SHIFT_RIGHT:			return "SHIFT_RIGHT"; break;

		case ESCRIPTTOKEN_KEYWORD_NOT:			return "KEYWORD_NOT"; break;
		//case ESCRIPTTOKEN_KEYWORD_AND:		return "KEYWORD_AND"; break;
		//case ESCRIPTTOKEN_KEYWORD_OR:			return "KEYWORD_OR"; break;
		case ESCRIPTTOKEN_KEYWORD_SWITCH:		return "KEYWORD_SWITCH"; break;
		case ESCRIPTTOKEN_KEYWORD_ENDSWITCH:	return "KEYWORD_ENDSWITCH"; break;
		case ESCRIPTTOKEN_KEYWORD_CASE:			return "KEYWORD_CASE"; break;
		case ESCRIPTTOKEN_KEYWORD_DEFAULT:		return "KEYWORD_DEFAULT"; break;

		case ESCRIPTTOKEN_COLON:				return "COLON"; break;

		default: Assert(0,"Unknown token type in call to GetTokenName"); break;
		}
		return "";
	}
}

#define STRINGS_BUFFER_CHUNK_SIZE 1000

class CStringList
{
	char *mp_strings;
	// The total size of the strings buffer, which gets realloc'd when need be.
	uint32 m_strings_buffer_size;
	// How many bytes in the strings buffer are being used.
	uint32 m_strings_buffer_used;
public:
	CStringList();
	~CStringList();

	void AddString(const char *p_string);
	void SetStrings(const char *p_stringlist, uint32 size);
	uint32 GetSize() {return m_strings_buffer_used;}
	const char *GetNextString(const char *p_string=NULL);
	uint8 *WriteToBuffer(uint8 *p_buffer);
};

CStringList::CStringList()
{
	mp_strings=NULL;
	m_strings_buffer_size=0;
	m_strings_buffer_used=0;
}

CStringList::~CStringList()
{
	if (mp_strings)
	{
		free(mp_strings);
	}
}

const char *CStringList::GetNextString(const char *p_string)
{
	if (p_string==NULL)
	{
		return mp_strings;
	}
	p_string+=strlen(p_string)+1;
	if (p_string>=mp_strings+m_strings_buffer_used)
	{
		return NULL;
	}
	return p_string;
}

void CStringList::AddString(const char *p_string)
{
	Assert(p_string!=NULL,"NULL p_string");

	// Don't add it if it is there already.
	const char *p_scan=mp_strings;
	const char *p_end=mp_strings+m_strings_buffer_used;
	while (p_scan < p_end)
	{
		if (stricmp(p_scan,p_string)==0)
		{
			return;
		}
		p_scan+=strlen(p_scan)+1;
	}

	uint32 string_size=strlen(p_string)+1;

	if (mp_strings==NULL)
	{
		// Create the buffer for the first time.
		mp_strings=(char*)malloc(string_size);
		m_strings_buffer_size=string_size;
		m_strings_buffer_used=string_size;
		strcpy(mp_strings,p_string);
	}
	else
	{
		// The buffer already exists.

		// The buffer gets bigger by a fixed size when need be, to minimize
		// the number of alloc's done (for speed)
		// It's a compromise between having a fixed size buffer which I'd probably be
		// constantly having to increase the size of, and dynamically allocating each string,
		// which would be slow.
		while (m_strings_buffer_used+string_size > m_strings_buffer_size)
		{
			// Note: This needs to be a while loop because in theory the length
			// of p_name could be longer than STRINGS_BUFFER_CHUNK_SIZE.
			// Probably won't be though.
			m_strings_buffer_size+=STRINGS_BUFFER_CHUNK_SIZE;
			mp_strings=(char*)realloc(mp_strings,m_strings_buffer_size);
			Assert(mp_strings!=NULL,"Failed to realloc model name buffer");
		}

		// Stick the new string on the end.
		strcpy(mp_strings+m_strings_buffer_used,p_string);
		m_strings_buffer_used+=string_size;
	}
}

// Note: The size needs to be passed because p_stringlist contains many strings
// concatenated, so can't use strlen cos it will only give the length of the first one.
void CStringList::SetStrings(const char *p_stringlist, uint32 size)
{
	Assert(p_stringlist!=NULL,"NULL p_stringlist");

	if (mp_strings)
	{
		free (mp_strings);
	}

	if (size==0)
	{
		mp_strings=NULL;
		m_strings_buffer_size=0;
		m_strings_buffer_used=0;
		return;
	}

	mp_strings=(char*)malloc(size);
	Assert(mp_strings!=NULL,"Could not allocate buffer in SetStrings");

	char *p_dest=mp_strings;
	for (uint32 i=0; i<size; ++i)
	{
		*p_dest++=*p_stringlist++;
	}
	// Quick check
	Assert(p_dest[-1]==0,"Eh? p_stringlist not null terminated ?");

	m_strings_buffer_size=size;
	m_strings_buffer_used=size;
}

uint8 *CStringList::WriteToBuffer(uint8 *p_buffer)
{
	Assert(p_buffer!=NULL,"NULL p_buffer");

	if (mp_strings==NULL)
	{
		// Nothing to write.
		return p_buffer;
	}

	const uint8 *p_source=(const uint8*)mp_strings;
	for (uint32 i=0; i<m_strings_buffer_used; ++i)
	{
		*p_buffer++=*p_source++;
	}
	return p_buffer;
}

////////////////////////////////////////////////////////////////////////
// Hash table stuff
////////////////////////////////////////////////////////////////////////
#define HASH_TABLE_BUFFER_SIZE 500000
char pHashTableBuffer[HASH_TABLE_BUFFER_SIZE];
struct SChecksumEntry
{
	uint32 Checksum;
	SChecksumEntry *pNext;
};

SChecksumEntry *pRemainingHashTableBuffer=NULL;

#define HASHBITS 12
SChecksumEntry *ppHashTableEntries[1<<HASHBITS];

void InitHashTable()
{
	for (uint32 i=0; i<(1<<HASHBITS); ++i)
	{
		ppHashTableEntries[i]=NULL;
	}
	pRemainingHashTableBuffer=(SChecksumEntry *)pHashTableBuffer;
}

void AddChecksum(const char *pName, uint32 Checksum)
{
	int StringLength=strlen(pName)+1;
	// Round up to a multiple of 4, in case reading from an unaligned pointer is slower.
	//StringLength=(StringLength+3)&(~3); // Hmm, it's actually bit faster if they're not aligned ???

	// Check that there is enough space left in the buffer.
	int SpaceRequired=sizeof(SChecksumEntry)+StringLength;
	Assert( HASH_TABLE_BUFFER_SIZE - (((char*)pRemainingHashTableBuffer)-pHashTableBuffer)>=SpaceRequired,"Hash table buffer not big enough");

	// Get the head pointer of the list of entries for these hashbits.
	SChecksumEntry **ppTableEntry=&ppHashTableEntries[Checksum&((1<<HASHBITS)-1)];
	SChecksumEntry *pHead=*ppTableEntry;

	// Check to see if the checksum is already present in the list.
	SChecksumEntry *pEntry=pHead;
	while (pEntry!=NULL)
	{
		if (pEntry->Checksum==Checksum)
		{
			// It is already listed.
			// Check to see whether the name matches,
			if (stricmp((char*)(pEntry+1),pName)==0)
			{
				// It matches, so nothing to do.
				return;
			}
			else
			{
				// Oops! A checksum clash! 
				char pBuf[1000];
				sprintf(pBuf,"Aaaargh! '%s' and '%s' have the same checksum!",(char*)(pEntry+1),pName);
				Assert(0,pBuf);
			}
		}
		pEntry=pEntry->pNext;
	}

	// Load in the new checksum & name, attach the pointer to the start of the list, and update
	// the buffer pointer.
	pRemainingHashTableBuffer->Checksum=Checksum;
	pRemainingHashTableBuffer->pNext=pHead;

	*ppTableEntry=pRemainingHashTableBuffer;

	char *pNewString=(char*)(pRemainingHashTableBuffer+1);
	pRemainingHashTableBuffer=(SChecksumEntry*)(pNewString+StringLength);
	while (*pName)
	{
		*pNewString++=*pName++;
	}
	*pNewString++=0;
}

char *FindChecksumName(uint32 Checksum)
{
	SChecksumEntry *pEntry=ppHashTableEntries[Checksum&((1<<HASHBITS)-1)];
	while (pEntry!=NULL)
	{
		if (pEntry->Checksum==Checksum)
		{
			return (char*)(pEntry+1);
		}
		pEntry=pEntry->pNext;
	}
	return "UNKNOWN";
}

////////////////////////////////////////////////////////////
// MAP file stuff.
////////////////////////////////////////////////////////////

struct SMapEntry
{
	uint32 QFilenameChecksum;
	uint8 SymbolType;
	bool New;
	uint32 SymbolChecksum;
};

#define MAX_MAP_ENTRIES 20000
SMapEntry pMapEntries[MAX_MAP_ENTRIES];
uint32 NumMapEntries=0;

void AddMapEntry(uint32 SymbolChecksum, uint8 SymbolType, uint32 QFilenameChecksum, bool New)
{
	Assert(NumMapEntries<MAX_MAP_ENTRIES,"Too many map entries.");

	pMapEntries[NumMapEntries].SymbolChecksum=SymbolChecksum;
	pMapEntries[NumMapEntries].SymbolType=SymbolType;
	pMapEntries[NumMapEntries].QFilenameChecksum=QFilenameChecksum;
	pMapEntries[NumMapEntries].New=New;

	++NumMapEntries;
}

void PrintEntriesOfType(FILE *fp, uint8 Type)
{
	size_t MaxLen=0;
	for (uint32 i=0; i<NumMapEntries; ++i)
	{
		if (pMapEntries[i].SymbolType==Type)
		{
			const char *p_symbol_name=FindChecksumName(pMapEntries[i].SymbolChecksum);
			size_t Len=strlen(p_symbol_name);
			if (Len>MaxLen)
			{
				MaxLen=Len;
			}
		}
	}

	size_t Width=MaxLen+3;
	for (uint32 i=0; i<NumMapEntries; ++i)
	{
		if (pMapEntries[i].SymbolType==Type)
		{
			const char *p_symbol_name=FindChecksumName(pMapEntries[i].SymbolChecksum);

			fprintf(fp,"%s",p_symbol_name);
			for (size_t j=0; j<Width-strlen(p_symbol_name); ++j)
			{
				fprintf(fp," ");
			}
			fprintf(fp,"%s\n",FindChecksumName(pMapEntries[i].QFilenameChecksum));
		}
	}
}

void WriteMapFile(const char *pMapFilename)
{
	FILE *ifp=_qcomp_fopen(pMapFilename,"wb");
	Assert(ifp!=NULL,"Could not open qcomp.map for writing.");

	fprintf(ifp,"QCOMP.MAP    Generated by qcomp.exe\n\n");

	fprintf(ifp,"<Scripts>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_KEYWORD_SCRIPT);

// The only thing that uses the map file now is the max plugin, which only needs the names of the
// scripts, so don't bother exporting anything else (to keep the map file size down)
#if 0
	fprintf(ifp,"\n<Integers>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_INTEGER);

	fprintf(ifp,"\n<Floats>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_FLOAT);

	fprintf(ifp,"\n<Vectors>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_VECTOR);

	fprintf(ifp,"\n<Pairs>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_PAIR);

	fprintf(ifp,"\n<Strings>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_STRING);

	fprintf(ifp,"\n<LocalStrings>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_LOCALSTRING);

	fprintf(ifp,"\n<Arrays>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_STARTARRAY);

	fprintf(ifp,"\n<Structures>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_STARTSTRUCT);

	fprintf(ifp,"\n<Names>\n");
	PrintEntriesOfType(ifp,ESCRIPTTOKEN_NAME);
#endif

	fclose(ifp);
}

uint8 *SkipEndOfLines(uint8 *pToken)
{
	while (*pToken==ESCRIPTTOKEN_ENDOFLINE || *pToken==ESCRIPTTOKEN_ENDOFLINENUMBER)
	{
		pToken=SkipToken(pToken);
	}
	return pToken;
}

const char *GetWord(const char *pCh)
{
	while (*pCh && (*pCh==' ' || *pCh=='\t' || *pCh==0x0d || *pCh==0x0a))
	{
		++pCh;
	}

	int c=0;
	while (*pCh && !(*pCh==' ' || *pCh=='\t' || *pCh==0x0d || *pCh==0x0a))
	{
		Assert(c<WORDBUFSIZE-1,"Word too long in qcomp.map");
		WordBuffer[c++]=*pCh++;
	}
	WordBuffer[c]=0;
	return pCh;
}

uint8 GetType()
{
	if (stricmp(WordBuffer,"<Scripts>")==0)
	{
		return ESCRIPTTOKEN_KEYWORD_SCRIPT;
	}
	else if (stricmp(WordBuffer,"<Integers>")==0)
	{
		return ESCRIPTTOKEN_INTEGER;
	}
	else if (stricmp(WordBuffer,"<Floats>")==0)
	{
		return ESCRIPTTOKEN_FLOAT;
	}
	else if (stricmp(WordBuffer,"<Vectors>")==0)
	{
		return ESCRIPTTOKEN_VECTOR;
	}
	else if (stricmp(WordBuffer,"<Pairs>")==0)
	{
		return ESCRIPTTOKEN_PAIR;
	}
	else if (stricmp(WordBuffer,"<Strings>")==0)
	{
		return ESCRIPTTOKEN_STRING;
	}
	else if (stricmp(WordBuffer,"<LocalStrings>")==0)
	{
		return ESCRIPTTOKEN_LOCALSTRING;
	}
	else if (stricmp(WordBuffer,"<Arrays>")==0)
	{
		return ESCRIPTTOKEN_STARTARRAY;
	}
	else if (stricmp(WordBuffer,"<Structures>")==0)
	{
		return ESCRIPTTOKEN_STARTSTRUCT;
	}
	else if (stricmp(WordBuffer,"<Names>")==0)
	{
		return ESCRIPTTOKEN_NAME;
	}
	Assert(0,"Unknown type in WordBuffer");
	return ESCRIPTTOKEN_UNDEFINED;
}

void ReadMapFile(const char *pMapFilename)
{
	FILE *ifp=_qcomp_fopen(pMapFilename,"rb");
	if (ifp==NULL)
	{
		return;
	}
	fseek(ifp,0,SEEK_END);
	long MapSize=ftell(ifp);
	fseek(ifp,0,SEEK_SET);
	char *pMapFile=(char*)malloc(MapSize+1); // +1 for a terminating 0
	Assert(pMapFile!=NULL,"Could not allocate memory to hold map file");
	Assert(fread(pMapFile,MapSize,1,ifp)==1,"fread failed when loading map file");
	pMapFile[MapSize]=0;

	NumMapEntries=0;

	const char *pCh=pMapFile;
	WordBuffer[0]=0;

	// Skip over the initial words until the first type specifier is found.
	while (*pCh && WordBuffer[0]!='<')
	{
		pCh=GetWord(pCh);
	}

	while (*pCh)
	{
		uint8 Type=GetType();
		while (true)
		{
			pCh=GetWord(pCh);
			if (*pCh==0 || WordBuffer[0]=='<')
			{
				break;
			}
			uint32 SymbolChecksum=GenerateChecksum(WordBuffer);

			Assert(*pCh,"Missing .q file name in map file.");
			pCh=GetWord(pCh);

			AddMapEntry(SymbolChecksum,Type,GenerateChecksum(WordBuffer),false);
		}
	}

	free(pMapFile);
	pMapFile=NULL;
	fclose(ifp);
	ifp=NULL;
}

char *PrintTypeName(EScriptToken Token)
{
	switch (Token)
	{
	case ESCRIPTTOKEN_STARTSTRUCT:		return "Structure"; break;
	case ESCRIPTTOKEN_STARTARRAY:		return "Array"; break;
	case ESCRIPTTOKEN_INTEGER:			return "Integer"; break;
	case ESCRIPTTOKEN_HEXINTEGER:		return "HexInteger"; break;
	case ESCRIPTTOKEN_FLOAT:			return "Float"; break;
	case ESCRIPTTOKEN_STRING:			return "String"; break;
	case ESCRIPTTOKEN_LOCALSTRING:		return "LocalString"; break;
	case ESCRIPTTOKEN_VECTOR:			return "Vector"; break;
	case ESCRIPTTOKEN_PAIR:				return "Pair"; break;
	case ESCRIPTTOKEN_KEYWORD_SCRIPT:	return "Script"; break;
	case ESCRIPTTOKEN_NAME:				return "Name"; break;
	default: Assert(0,"Unknown token type in call to PrintTypeName"); break;
	}
	return "";
}

#define MAX_MAP_FILE_CHARS 100
#define MAP_FILE_SUB_PATH "data\\scripts\\qcomp.map"
void UpdateMapFile()
{
	// Create the map file name.
	char *pPath=getenv("PROJ_ROOT");
	Assert(pPath!=NULL,"Creation of the map file requires that the environment variable PROJ_ROOT is set.");

	char pMapFilename[MAX_MAP_FILE_CHARS+1];
	Assert(strlen(pPath)+1+strlen(MAP_FILE_SUB_PATH)<=MAX_MAP_FILE_CHARS,"Filename too long.");
	strcpy(pMapFilename,pPath);
	if (pMapFilename[strlen(pMapFilename)-1]!='\\') strcat(pMapFilename,"\\");
	strcat(pMapFilename,MAP_FILE_SUB_PATH);

	ReadMapFile(pMapFilename);

	// Get the checksum of the source file name.
	uint32 SourceFilenameChecksum=GenerateChecksum(pSourceName);

	// Add all the symbols in the qb that has just been compiled to the map entry list.
	Assert(pOutputBuffer!=NULL,"Eh ?");
	uint8 *pToken=(uint8*)pOutputBuffer;
	bool InScript=false;
	int StructCount=0;
	while (*pToken!=ESCRIPTTOKEN_ENDOFFILE)
	{
		switch (*pToken)
		{
		case ESCRIPTTOKEN_STARTSTRUCT:
			++StructCount;
			break;
		case ESCRIPTTOKEN_ENDSTRUCT:
			Assert(StructCount,"Zero StructCount");
			--StructCount;
			break;
		case ESCRIPTTOKEN_KEYWORD_SCRIPT:
			InScript=true;
			pToken=SkipToken(pToken);
			pToken=SkipEndOfLines(pToken);
			Assert(*pToken==ESCRIPTTOKEN_NAME,"Expected a name to follow script keyword.");
			// Don't add if inside a structure, since that is a structure component, not a global.
			if (!StructCount) 
			{
				AddMapEntry(*(uint32*)(pToken+1),ESCRIPTTOKEN_KEYWORD_SCRIPT,SourceFilenameChecksum,true);
			}
			break;
		case ESCRIPTTOKEN_KEYWORD_ENDSCRIPT:
			InScript=false;
			break;

// The only thing that uses the map file now is the max plugin, which only needs the names of the
// scripts, so don't bother exporting anything else (to keep the map file size down)
#if 0
		case ESCRIPTTOKEN_NAME:
			if (InScript || StructCount)
			{
				break;
			}

			uint32 NameChecksum;
			NameChecksum=*(uint32*)(pToken+1);
			pToken=SkipToken(pToken);
			pToken=SkipEndOfLines(pToken);

			if (*pToken==ESCRIPTTOKEN_EQUALS)
			{
				pToken=SkipToken(pToken);
				pToken=SkipEndOfLines(pToken);

				switch (*pToken)
				{
			    case ESCRIPTTOKEN_STARTSTRUCT:
					++StructCount;
					AddMapEntry(NameChecksum,ESCRIPTTOKEN_STARTSTRUCT,SourceFilenameChecksum,true);
					break;
				case ESCRIPTTOKEN_STARTARRAY:
				case ESCRIPTTOKEN_NAME:
				case ESCRIPTTOKEN_INTEGER:
				case ESCRIPTTOKEN_HEXINTEGER:
				case ESCRIPTTOKEN_FLOAT:
				case ESCRIPTTOKEN_VECTOR:
				case ESCRIPTTOKEN_PAIR:
				case ESCRIPTTOKEN_STRING:
				case ESCRIPTTOKEN_LOCALSTRING:
					AddMapEntry(NameChecksum,*pToken,SourceFilenameChecksum,true);
					break;
				default:
					break;
				}
			}
			break;
#endif

		default:
			break;
		}
		pToken=SkipToken(pToken);
	}
	Assert(StructCount==0,"StructCount not zero ?");
	Assert(!InScript,"InScript still set ?");

#if 0
	// Before writing out the map file, do a horribly complex bit of logic to check for
	// duplicate symbols.

	// Note: This bit is slow! Should optimize it at some point.

	// For each map entry ...
	for (uint32 i=0; i<NumMapEntries; ++i)
	{
		// Don't worry about the symbols 'NodeArray','TriggerScripts' or 'LoadTerrain' being duplicated, 
		// because they will be. They are symbols that are defined in each level's .qn file.
		if (pMapEntries[i].SymbolChecksum!=0xc472ecc5/*NodeArray*/ &&
			pMapEntries[i].SymbolChecksum!=0x40f3a3c4/*TriggerScripts*/ &&
			pMapEntries[i].SymbolChecksum!=0xa4f9a278/*LoadTerrain*/)
		{
			// Check each of the remaining entries to see if there is a symbol checksum match.
			for (int j=i+1; j<NumMapEntries; ++j)
			{
				if (pMapEntries[i].SymbolChecksum==pMapEntries[j].SymbolChecksum)
				{
					// Found a match, but don't know if this is a problem yet.

					if (!pMapEntries[i].New && !pMapEntries[j].New)
					{
						// Both the entries are old, which implies they are duplicated in the map file.
						// ('New' entries came from the .q file just compiled, old entries came from the map file)

						// Note: Changed this to not give a message at all, so that moving a symbol from one file
						// to another won't cause any messages.

						//char pBuf[1000];
						//sprintf(pBuf,"Error in map file, duplicate symbol '%s'",FindChecksumName(pMapEntries[i].SymbolChecksum));
						//Assert(0,pBuf);
					}
					else if ((pMapEntries[i].New && !pMapEntries[j].New) ||
							 (pMapEntries[j].New && !pMapEntries[i].New))
					{
						// One of the entries is old, and one is new.
						// This will often happen, because when a .q file is compiled most of the symbols in
						// it will already be in the map file. However, one would expect the source files to match
						// in this case. If the source files do not match, then either there is a genuine symbol clash,
						// or a symbol has been moved from one source file to another.
						if (pMapEntries[i].QFilenameChecksum!=pMapEntries[j].QFilenameChecksum)
						{
							// Get the old source file name, ie the source file of the symbol in the map file already.
							uint32 OldFilenameChecksum;
							if (!pMapEntries[i].New)
							{
								OldFilenameChecksum=pMapEntries[i].QFilenameChecksum;
							}
							else
							{
								OldFilenameChecksum=pMapEntries[j].QFilenameChecksum;
							}

							if (pMapEntries[i].SymbolType==pMapEntries[j].SymbolType)
							{
								// The symbol types match, so it is likely that the symbol has been moved. So give
								// an warning message indicating this.
								char pBuf[1000];
								sprintf(pBuf,"The %s '%s' is already defined in %s\n\nIf you have moved the symbol from that file, you'll need to recompile it too.",PrintTypeName((EScriptToken)pMapEntries[i].SymbolType),FindChecksumName(pMapEntries[i].SymbolChecksum),FindChecksumName(OldFilenameChecksum));
								Message(pBuf);
							}
							else
							{
								// The symbol types do not match, so it is likely a genuine symbol clash.
								char pBuf[1000];
								sprintf(pBuf,"Duplicate symbol names! The %s '%s' is already defined to be a %s in %s\n\n",PrintTypeName((EScriptToken)pMapEntries[j].SymbolType),FindChecksumName(pMapEntries[i].SymbolChecksum),PrintTypeName((EScriptToken)pMapEntries[i].SymbolType),FindChecksumName(OldFilenameChecksum));
								// Actually, only give a warning, to ensure that a new map file is still created.
								// (An assert would bail out altogether)
								Message(pBuf);
							}
						}
					}
					else
					{
						// Both symbols are new, ie they came from the source file just compiled.
						// So that's definitely an error.
						// But still don't assert, to be consistent with the above checks not asserting.
						char pBuf[1000];
						sprintf(pBuf,"The symbol '%s' is defined twice in this source file.",FindChecksumName(pMapEntries[i].SymbolChecksum));
						Message(pBuf);
					}
				}
			}
		}
	}
#endif

	// The source file just compiled might have had some symbols removed from it. 
	// These symbols can be detected because they will be flagged as old, since they would 
	// have been in the map file before, and they will have
	// their source file name equalling that of the source file just compiled.
	// So scan through and remove them by flagging as them as having an undefined type.
	// They will then not get included in the new map file about to be created.
	for (uint32 i=0; i<NumMapEntries; ++i)
	{
		if (!pMapEntries[i].New && pMapEntries[i].QFilenameChecksum==SourceFilenameChecksum)
		{
			pMapEntries[i].SymbolType=ESCRIPTTOKEN_UNDEFINED;
		}
	}

	WriteMapFile(pMapFilename);
}

// Used for converting longs to Motorola format.
void ReverseLong(char *pCh)
{
	pCh[0]^=pCh[3];
	pCh[3]^=pCh[0];
	pCh[0]^=pCh[3];
	pCh[1]^=pCh[2];
	pCh[2]^=pCh[1];
	pCh[1]^=pCh[2];
}

// --------------------- Debug stuff --------------------------

void Message(const char *pMessage)
{
	char pTitle[1000];
	sprintf(pTitle,"QComp warning message: File %s",pSourceName);
	_MessageBox(pMessage,pTitle);
}

// _ASSERT won't print a passed message (other than the condition), so wrote this.
void Assert(int Condition, char *pMessage)
{
	if (!Condition)
	{
		if (DisplayErrorsInWindow)
		{
			char pTitle[1000];
			sprintf(pTitle,"QComp assertion failed: File %s\n",pSourceName);
			_MessageBox(pMessage,pTitle);
		}
		else
		{
			// Print error to a file.
			FILE *ofp=_qcomp_fopen("qcomp.err","w");
			if (ofp)
			{
				fprintf(ofp,"QComp assertion failed: File %s\n",pSourceName);
				fprintf(ofp,"0:%s\n\n",pMessage);
			}
			else
			{
				_MessageBox("Could not open qcomp.err","QComp.exe");
			}
			fclose(ofp);
		}
		exit(EXIT_FAILURE);
	}
}

int LineNumber=0;
void ParseAssert(char *pMessage)
{
	// Adding 1 to LineNumber in the following cos editors don't have a line 0.
	
	if (CreateSlickEditErrorMessages)
	{
		fprintf(stderr,"%s:%d: %s\n",pSourceName,LineNumber+1,pMessage);
	}
	else if (DisplayErrorsInWindow)
	{
		char pTitle[1000];
		sprintf(pTitle,"QComp parse error in file %s",pSourceName);
		char pBuf[1000];
		sprintf(pBuf,"Line %d: %s\n%s\n\n",LineNumber+1,WordBuffer,pMessage);

		_MessageBox(pBuf,pTitle);
	}
	else
	{
		// Print error to a file.
		FILE *ofp=_qcomp_fopen("qcomp.err","w");
		if (ofp)
		{
			fprintf(ofp,"QComp parse error in file %s\n",pSourceName);
			fprintf(ofp,"%d: %s\n%s\n\n",LineNumber+1,WordBuffer,pMessage);
		}
		else
		{
			_MessageBox("Could not open qcomp.err","QComp.exe");
		}
		fclose(ofp);
	}

	exit(EXIT_FAILURE);
}

void ParseAssert(int Condition, char *pMessage)
{
	if (!Condition) ParseAssert(pMessage);
}

// Some handy functions.
void Prt(int x, int Hex)
{
	char Buf[100];
	if (Hex)
		sprintf(Buf,"Integer = 0x%08x",x);
	else
		sprintf(Buf,"Integer = %d",x);
	_MessageBox(Buf,"Prt(int x)");
}

void Prt(float x)
{
	char Buf[100];
	sprintf(Buf,"Float = %f",x);
	_MessageBox(Buf,"Prt(float x)");
}
void Prt(const char *pString)
{
	_MessageBox(pString,"Prt(char *pString)");
}

// -------------------- Checksum stuff ------------------------

unsigned long CRC_TABLE[256] = // CRC polynomial 0xedb88320
{
      0x00000000, 0x77073096, 0xee0e612c, 0x990951ba,
      0x076dc419, 0x706af48f, 0xe963a535, 0x9e6495a3,
      0x0edb8832, 0x79dcb8a4, 0xe0d5e91e, 0x97d2d988,
      0x09b64c2b, 0x7eb17cbd, 0xe7b82d07, 0x90bf1d91,
      0x1db71064, 0x6ab020f2, 0xf3b97148, 0x84be41de,
      0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7,
      0x136c9856, 0x646ba8c0, 0xfd62f97a, 0x8a65c9ec,
      0x14015c4f, 0x63066cd9, 0xfa0f3d63, 0x8d080df5,
      0x3b6e20c8, 0x4c69105e, 0xd56041e4, 0xa2677172,
      0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b,
      0x35b5a8fa, 0x42b2986c, 0xdbbbc9d6, 0xacbcf940,
      0x32d86ce3, 0x45df5c75, 0xdcd60dcf, 0xabd13d59,
      0x26d930ac, 0x51de003a, 0xc8d75180, 0xbfd06116,
      0x21b4f4b5, 0x56b3c423, 0xcfba9599, 0xb8bda50f,
      0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
      0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d,
      0x76dc4190, 0x01db7106, 0x98d220bc, 0xefd5102a,
      0x71b18589, 0x06b6b51f, 0x9fbfe4a5, 0xe8b8d433,
      0x7807c9a2, 0x0f00f934, 0x9609a88e, 0xe10e9818,
      0x7f6a0dbb, 0x086d3d2d, 0x91646c97, 0xe6635c01,
      0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e,
      0x6c0695ed, 0x1b01a57b, 0x8208f4c1, 0xf50fc457,
      0x65b0d9c6, 0x12b7e950, 0x8bbeb8ea, 0xfcb9887c,
      0x62dd1ddf, 0x15da2d49, 0x8cd37cf3, 0xfbd44c65,
      0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2,
      0x4adfa541, 0x3dd895d7, 0xa4d1c46d, 0xd3d6f4fb,
      0x4369e96a, 0x346ed9fc, 0xad678846, 0xda60b8d0,
      0x44042d73, 0x33031de5, 0xaa0a4c5f, 0xdd0d7cc9,
      0x5005713c, 0x270241aa, 0xbe0b1010, 0xc90c2086,
      0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
      0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4,
      0x59b33d17, 0x2eb40d81, 0xb7bd5c3b, 0xc0ba6cad,
      0xedb88320, 0x9abfb3b6, 0x03b6e20c, 0x74b1d29a,
      0xead54739, 0x9dd277af, 0x04db2615, 0x73dc1683,
      0xe3630b12, 0x94643b84, 0x0d6d6a3e, 0x7a6a5aa8,
      0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1,
      0xf00f9344, 0x8708a3d2, 0x1e01f268, 0x6906c2fe,
      0xf762575d, 0x806567cb, 0x196c3671, 0x6e6b06e7,
      0xfed41b76, 0x89d32be0, 0x10da7a5a, 0x67dd4acc,
      0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5,
      0xd6d6a3e8, 0xa1d1937e, 0x38d8c2c4, 0x4fdff252,
      0xd1bb67f1, 0xa6bc5767, 0x3fb506dd, 0x48b2364b,
      0xd80d2bda, 0xaf0a1b4c, 0x36034af6, 0x41047a60,
      0xdf60efc3, 0xa867df55, 0x316e8eef, 0x4669be79,
      0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
      0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f,
      0xc5ba3bbe, 0xb2bd0b28, 0x2bb45a92, 0x5cb36a04,
      0xc2d7ffa7, 0xb5d0cf31, 0x2cd99e8b, 0x5bdeae1d,
      0x9b64c2b0, 0xec63f226, 0x756aa39c, 0x026d930a,
      0x9c0906a9, 0xeb0e363f, 0x72076785, 0x05005713,
      0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38,
      0x92d28e9b, 0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21,
      0x86d3d2d4, 0xf1d4e242, 0x68ddb3f8, 0x1fda836e,
      0x81be16cd, 0xf6b9265b, 0x6fb077e1, 0x18b74777,
      0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c,
      0x8f659eff, 0xf862ae69, 0x616bffd3, 0x166ccf45,
      0xa00ae278, 0xd70dd2ee, 0x4e048354, 0x3903b3c2,
      0xa7672661, 0xd06016f7, 0x4969474d, 0x3e6e77db,
      0xaed16a4a, 0xd9d65adc, 0x40df0b66, 0x37d83bf0,
      0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
      0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6,
      0xbad03605, 0xcdd70693, 0x54de5729, 0x23d967bf,
      0xb3667a2e, 0xc4614ab8, 0x5d681b02, 0x2a6f2b94,
      0xb40bbe37, 0xc30c8ea1, 0x5a05df1b, 0x2d02ef8d
};

uint32 GenerateChecksum(const char *pString)
{
	// Initializing the CRC to all one bits avoids failure of detection
	// should entire data stream get cyclically bit-shifted by one position.
	// The calculation of the probability of this happening is left as
	// an exercise for the reader.
	unsigned long rc = 0xffffffff;
	int Len=strlen(pString);
	for (int i=0; i<Len; i++)
	{
		char ch=pString[i];
        // Convert to lower case.
        if (ch>='A' && ch<='Z') ch='a'+ch-'A';
		rc = CRC_TABLE[(rc^ch) & 0xff] ^ ((rc>>8) & 0x00ffffff);
	}
	ParseAssert(rc,"Checksum is zero !!!     You win a banana ! \n(A word must not have a checksum of 0, since that is reserved to mean no word)");
	
	// Add the name and checksum to the hash table for fast lookup.
	AddChecksum(pString,rc);	

	return rc;
}

// ----------------------- Comment stripping -------------------------

// This will usually just return **ppCh, but if it encounters the \
// symbol it will skip ppCh to after the end of the line.
int NumSkips=0;
char ReadChar(char **ppCh)
{
	char *pCh=*ppCh;
	// Removed this, cos people like to use \ in path names.
	// I should really fix it so that when the \ is encountered between
	// quotes, then it is not treated as a line continuation character.
	/*
	while (*pCh=='\\')
	{
		++pCh;
		while (*pCh && *pCh!=0x0a)
		{
			ParseAssert(*pCh==' ' || *pCh=='\t' || *pCh==0x0d,"Preprocess error:  Bad character following \\");
			++pCh;
		}
		if (*pCh==0x0a) ++pCh;
		// Count how many lines got skipped, needed later. (See StripCommentsAndMergeLines below)
		++NumSkips;
		++LineNumber;
		*ppCh=pCh;
	}
	*/
	return *pCh;
}

char *SkipOverMultiLineComment(char *pCh, int *pLineNumber)
{
	if (pCh[0]=='/' && pCh[1]=='*')
	{
		pCh+=2;
		
		while (true)
		{
			Assert(*pCh!=0,"Unterminated /* ... */ style comment");

			if (*pCh==0x0a)
			{
				++*pLineNumber;
			}

			if (pCh[0]=='/' && pCh[1]=='*')
			{
				pCh=SkipOverMultiLineComment(pCh,pLineNumber);
			}
			else
			{
				if (pCh[0]=='*' && pCh[1]=='/')
				{
					return pCh+2;
				}
				++pCh;
			}
		}
	}
	return pCh;
}

// Returns the character at *ppCh, and increments *ppCh.
// Does skipping over comments and the line continue (\) character.
char GetNextChar(char **ppCh, int *pLineNumber, bool SkipComments)
{
	char RetVal;
	char ch;

	switch (RetVal=ReadChar(ppCh))
	{
	case ';':
		++*ppCh;
		if (!SkipComments)
		{
			break;
		}

		while (TRUE)
		{
			ch=ReadChar(ppCh);
			if (ch==0 || ch==0x0a) break;
			++*ppCh;
		}
		RetVal=ch;
		++*ppCh;
		break;
	case '/':
		++*ppCh;
		if (!SkipComments)
		{
			break;
		}
		ch=ReadChar(ppCh);
		if (ch=='*')
		{
			*ppCh=SkipOverMultiLineComment(*ppCh-1,pLineNumber);
			RetVal=ReadChar(ppCh);
			++*ppCh;
			if (RetVal==0x0d)
			{
				RetVal=ReadChar(ppCh);
				++*ppCh;
			}
		}
		else
		{
			if (ch!='/') return '/';
		
			++*ppCh;
			while (TRUE)
			{
				ch=ReadChar(ppCh);
				if (ch==0 || ch==0x0a) break;
				++*ppCh;
			}
			RetVal=ch;
			++*ppCh;
		}
		break;
	case 0x0d:
		++*ppCh;
		Assert(**ppCh==0x0a,"0x0d not followed by 0x0a?");
		RetVal=0x0a;
		++*ppCh;
		break;
	default:
		++*ppCh;
		break;
	}
	Assert(RetVal!=0x0d,"RetVal=0x0d ???");
	return RetVal;
}

// This copies pSource back into itself using the GetNextChar function, which skips
// over comments and line breaks.
// Safe to copy back into itself, because after stripping comments and line breaks the
// result must be either smaller or the same as the original.
void StripCommentsAndMergeLines(char *pSource)
{
	char *pSrc=pSource;
	char *pDest=pSource;
	NumSkips=0;
	LineNumber=0;
	int InString=0;
	int InLocalString=0;
	bool last_was_backslash=false;
	while (TRUE)
	{
		char ch=GetNextChar(&pSrc,
							&NumSkips, 
							// Do skip over comments if not in a string.
							// Needed so that semi-colons can be put in strings.
							!(InString || InLocalString));

		// Update the InString & InLocalString flags.
		switch (ch)
		{
		case '\\':
			if (InString || InLocalString)
			{
				if (last_was_backslash)
				{
					last_was_backslash=false;
				}
				else
				{
					last_was_backslash=true;
				}
			}
			else
			{
				// The flag refers to whether the last char was a backslash
				// whilst in a string, hence setting it to false here.
				last_was_backslash=false;
			}
			break;

		case '"':
			if (!last_was_backslash)
			{
				if (!InLocalString)
				{
					InString^=1;
				}
			}
			last_was_backslash=false;
			break;
		case '\'':
			if (!last_was_backslash)
			{
				if (!InString)
				{
					InLocalString^=1;
				}
			}
			last_was_backslash=false;
			break;
		default:
			last_was_backslash=false;
			break;
		}
		Assert(!(InString && InLocalString),"Eh? In both strings");
			
		// Pad with however many lines the GetNextChar function skipped over.
		// This ensures that line numbers in the stripped file match up with line
		// numbers in the source, which is needed for if later parsing reports
		// an error on some line.
		for (int i=0; i<NumSkips; ++i) *pDest++=0x0a;
		NumSkips=0;

		*pDest++=ch;
		if (ch==0) break;
	}
}

// ----------------------- Word extraction -------------------------

// Skips white space & loads the next 'thing' into WordBuffer.
// Returns the pointer to the first char after the word.
const char *GetNextWord(const char *pCh)
{
	// Skip white space.
	while (*pCh==' ' || *pCh=='\t') ++pCh;
	
	// Check for the special <...> keyword.
	if (pCh[0]=='<' && pCh[1]=='.' && pCh[2]=='.' && pCh[3]=='.' && pCh[4]=='>')
	{
		strcpy(WordBuffer,"<...>");
		pCh+=5;
		return pCh;
	}

	// Current position in WordBuffer 
	int c=0;

	// Check for the # character which may precede a string, indicating that it is to be
	// treated as a checksum. This is so that checksums of strings with spaces can be specified
	// by using the syntax #"Hello Mum"
	if (*pCh=='#')
	{
		++pCh;
		// Skip white space.
		while (*pCh==' ' || *pCh=='\t') ++pCh;
		ParseAssert(*pCh=='"',"# character must be followed by a string in double quotes");
		WordBuffer[c++]='#';
	}

	switch (*pCh)
	{
	case 0:
		// Special single characters.
	case '{': case '}':
	case '[': case ']':
	case '(': case ')':
	case '<': case '>':
	case '=': 
	case '+': case '/': case '*':
	case ',':
	case '@':
	case ':':
		WordBuffer[0]=*pCh++;
		WordBuffer[1]=0;
		return pCh;
		break;
	case '.':case '-':
		// If . or - are not followed by valid number characters,
		// or if they are followed by '0x', then treat them as individual words.
		if ((pCh[0]=='-' && !((pCh[1]>='0' && pCh[1]<='9') || pCh[1]=='.' || (pCh[1]=='0' && (pCh[2]=='x' || pCh[2]=='X')))) ||
			(pCh[0]=='.' && !((pCh[1]>='0' && pCh[1]<='9') || (pCh[1]=='0' && (pCh[2]=='x' || pCh[2]=='X')))))
		{
			WordBuffer[0]=*pCh++;
			WordBuffer[1]=0;
			return pCh;
		}
		else
		{
			// What follows is a number so load in the . or -.
			WordBuffer[c++]=*pCh++;
		}
		break;
	case 0x0a:
		// line-feed.
		++pCh;
		WordBuffer[0]=0x0a;
		WordBuffer[1]=0;
		return pCh;
		break;
	case '"':
		// A string.
		WordBuffer[c++]=*pCh++;

		while (*pCh!='"')
		{
			ParseAssert(c<WORDBUFSIZE-1,"Word too long");
			if (*pCh==0 || *pCh==0x0a)
			{
				WordBuffer[c]=0;
				ParseAssert("Missing end quotes in string");
			}
			// Allow ' and " by preceding them with a '\'
			// Also make two backslashes equate to one so that a string consisting of
			// one backslash can be made without the backslash removing the last quote.
			if (pCh[0]=='\\' && (pCh[1]=='\'' || pCh[1]=='\"' || pCh[1]=='\\'))
			{
				++pCh; // Skip over the backslash
			}
			WordBuffer[c++]=*pCh++;
		}
		ParseAssert(c<WORDBUFSIZE-1,"Word too long");
		WordBuffer[c++]=*pCh++;
		// Terminate the string.
		WordBuffer[c]=0;
		return pCh;
		break;
	case '\'':
		// A local string, same as above just using single quotes.
		WordBuffer[0]=*pCh++;
		++c;
		while (*pCh!='\'')
		{
			ParseAssert(c<WORDBUFSIZE-1,"Word too long");
			if (*pCh==0 || *pCh==0x0a)
			{
				WordBuffer[c]=0;
				ParseAssert("Missing end quote in local string");
			}
			// Allow ' and " by preceding them with a '\'
			// Also make two backslashes equate to one so that a string consisting of
			// one backslash can be made without the backslash removing the last quote.
			if (pCh[0]=='\\' && (pCh[1]=='\'' || pCh[1]=='\"' || pCh[1]=='\\'))
			{
				++pCh; // Skip over the backslash
			}
			WordBuffer[c++]=*pCh++;
		}
		ParseAssert(c<WORDBUFSIZE-1,"Word too long");
		WordBuffer[c++]=*pCh++;
		// Terminate the string.
		WordBuffer[c]=0;
		return pCh;
		break;
	default:
		break;
	}

	// Check for hex numbers prefixed with 0x
	if (pCh[0]=='0' && (pCh[1]=='x' || pCh[1]=='X'))
	{
		WordBuffer[0]='0';
		WordBuffer[1]='x';
		pCh+=2;
		c=2;
		while ((*pCh>='0' && *pCh<='9') || (*pCh>='a' && *pCh<='z') || (*pCh>='A' && *pCh<='Z'))
		{
			ParseAssert(c<WORDBUFSIZE-1,"Hex too long");
			WordBuffer[c++]=*pCh++;
		}
		// Terminate the string.
		WordBuffer[c]=0;
		return pCh;
	}

	// Check for hex numbers prefixed with $
	if (pCh[0]=='$')
	{
		WordBuffer[0]='$';
		++pCh;
		c=1;
		while ((*pCh>='0' && *pCh<='9') || (*pCh>='a' && *pCh<='z') || (*pCh>='A' && *pCh<='Z'))
		{
			ParseAssert(c<WORDBUFSIZE-1,"Hex too long");
			WordBuffer[c++]=*pCh++;
		}
		// Terminate the string.
		WordBuffer[c]=0;
		return pCh;
	}

	int IsNumber=FALSE;
	while (*pCh=='.' || (*pCh>='0' && *pCh<='9'))
	{
		WordBuffer[c++]=*pCh++;
		IsNumber=TRUE;
	}
	if (IsNumber)
	{
		// Terminate the string.
		WordBuffer[c]=0;

		// Check that the number is not immediately followed by a word, and report
		// a warning if it is.
		// This is to detect bad names for nodes in the levels' qn files, such as
		// 3rd_something, which will get compiled to 3 and rd_something causing problems
		// in the game code.
		// Could just make qcomp support such words, but then that would cause further
		// problems when the designer does want the number and name separated, such as
		// when specifying a speed of 15fps with no whitespace between the 15 and fps.
		if (*pCh=='_' || (*pCh>='a' && *pCh<='z') || (*pCh>='A' && *pCh<='Z'))
		{
			char p_bad_word[1024];
			strcpy(p_bad_word,WordBuffer);

			const char *p_rest_of_word=pCh;
			// Copy the rest of the word into WordBuffer so that ParseAssert correctly
			// displays the whole bad word.
			while (*p_rest_of_word=='_' || 
				  (*p_rest_of_word>='a' && *p_rest_of_word<='z') || 
				  (*p_rest_of_word>='A' && *p_rest_of_word<='Z'))
			{
				p_bad_word[c++]=*p_rest_of_word++;
			}
			p_bad_word[c]=0;

			char p_title[1024];
			sprintf(p_title,"QComp error in file %s",pSourceName);
			char p_buf[1024];
			sprintf(p_buf,"Line %d: %s\n\n%s\n\n",LineNumber+1,p_bad_word,"Words cannot start with a number!");

			_MessageBox(p_buf,p_title);
		}
		return pCh;
	}

	// Load the word into the buffer.
	int Type=-1;
	while (!(*pCh==0 || *pCh==0x0a || *pCh==' ' || *pCh=='\t'))
	{
		int NewType=(*pCh=='_')||
					(*pCh>='0' && *pCh<='9')||
					(*pCh>='a' && *pCh<='z')||
					(*pCh>='A' && *pCh<='Z');
		if (Type>=0 && NewType!=Type) break;
		Type=NewType;
		ParseAssert(c<WORDBUFSIZE-1,"Word too long");
		WordBuffer[c++]=*pCh++;
	}
	// Terminate the string.
	WordBuffer[c]=0;
	return pCh;
}

// Analyses the word in WordBuffer to find out what sort of thing it is.
// If it is an integer or hex integer the value is loaded into pInt.
// If it is a float, it is loaded into pFloatValue.
EScriptToken DetermineTokenType(int *pInt, float *pFloatValue)
{
	if (WordBuffer[0]==0) return ESCRIPTTOKEN_ENDOFFILE;
	if (WordBuffer[0]==0x0a) return ESCRIPTTOKEN_ENDOFLINE;

	// Special single characters.
	if (WordBuffer[1]==0)
	{
		switch (WordBuffer[0])
		{
		case '{': return ESCRIPTTOKEN_STARTSTRUCT; break;
		case '}': return ESCRIPTTOKEN_ENDSTRUCT; break;
		case '(': return ESCRIPTTOKEN_OPENPARENTH; break;
		case ')': return ESCRIPTTOKEN_CLOSEPARENTH; break;
		case '[': return ESCRIPTTOKEN_STARTARRAY; break;
		case ']': return ESCRIPTTOKEN_ENDARRAY; break;
		case '<': return ESCRIPTTOKEN_LESSTHAN; break;
		case '>': return ESCRIPTTOKEN_GREATERTHAN; break;
		case '=': return ESCRIPTTOKEN_EQUALS; break;
		case ',': return ESCRIPTTOKEN_COMMA; break;
		case '.': return ESCRIPTTOKEN_DOT; break;

		case '-': return ESCRIPTTOKEN_MINUS; break;
		case '+': return ESCRIPTTOKEN_ADD; break;
		case '/': return ESCRIPTTOKEN_DIVIDE; break;
		case '*': return ESCRIPTTOKEN_MULTIPLY; break;
		
		case '|': return ESCRIPTTOKEN_OR; break;
		case '&': return ESCRIPTTOKEN_AND; break;
		case '^': return ESCRIPTTOKEN_XOR; break;

		case '@': return ESCRIPTTOKEN_AT; break;

		case ':': return ESCRIPTTOKEN_COLON; break;

		default: break;
		}
	}

	if (stricmp(WordBuffer,"||")==0)	return ESCRIPTTOKEN_OR;
	if (stricmp(WordBuffer,"&&")==0)	return ESCRIPTTOKEN_AND;

	// Check if it is a shift operator.
	//if (stricmp(WordBuffer,"<<")==0)	return ESCRIPTTOKEN_SHIFT_LEFT;
	//if (stricmp(WordBuffer,">>")==0)	return ESCRIPTTOKEN_SHIFT_RIGHT;

	// Check if it is a string or local string.
	int Len=strlen(WordBuffer);
	if (WordBuffer[0]=='"')
	{
		ParseAssert(WordBuffer[Len-1]=='"',"Eh? Missing end quotes in string");
		return ESCRIPTTOKEN_STRING;
	}
	if (WordBuffer[0]=='\'')
	{
		ParseAssert(WordBuffer[Len-1]=='\'',"Eh? Missing end quote in local string");
		return ESCRIPTTOKEN_LOCALSTRING;
	}

	// Check if it is a string that is to be treated as a checksum
	if (WordBuffer[0]=='#' && WordBuffer[1]=='"')
	{
		ParseAssert(WordBuffer[Len-1]=='"',"Eh? Missing end quotes in string");
		// Wordbuffer contains a string of the form #"Hello Mum"
		// This is to be treated as a checksum, so shift it down two characters and remove the
		// last ", so that when the checksum of the WordBuffer contents is calculated it will
		// be the checksum of the string contained within the quotes (including any spaces)
		char *pDest=WordBuffer;
		char *pSource=WordBuffer+2;
		while (*pSource && *pSource!='"')
		{
			*pDest++=*pSource++;
		}
		*pDest=0;
		return ESCRIPTTOKEN_NAME;
	}

	// Check if it is a hex integer that uses the 0x format.
	if (WordBuffer[0]=='0' && (WordBuffer[1]=='x' || WordBuffer[1]=='X'))
	{
		ParseAssert(Len>2,"No digits in hex value. Make sure there is no white space between the 0x and the value.");
		*pInt=0;
		for (int i=2; i<Len; ++i)
		{
			ParseAssert((WordBuffer[i]>='0' && WordBuffer[i]<='9')||
					   (WordBuffer[i]>='a' && WordBuffer[i]<='f')||
					   (WordBuffer[i]>='A' && WordBuffer[i]<='F'),"Bad character in hex value");
			ParseAssert((*pInt&0xf0000000)==0,"Hex value too big");
			if (WordBuffer[i]>='0' && WordBuffer[i]<='9')
				*pInt=(*pInt<<4)|(WordBuffer[i]-'0');
			else if (WordBuffer[i]>='a' && WordBuffer[i]<='f')
				*pInt=(*pInt<<4)|(WordBuffer[i]-'a'+10);
			else
				*pInt=(*pInt<<4)|(WordBuffer[i]-'A'+10);
		}
		return ESCRIPTTOKEN_HEXINTEGER;
	}

	// Check if it is a hex integer that uses the $ format.
	if (WordBuffer[0]=='$')
	{
		ParseAssert(Len>1,"No digits in hex value. Make sure there is no white space between the $ and the value.");
		*pInt=0;
		for (int i=1; i<Len; ++i)
		{
			ParseAssert((WordBuffer[i]>='0' && WordBuffer[i]<='9')||
					   (WordBuffer[i]>='a' && WordBuffer[i]<='f')||
					   (WordBuffer[i]>='A' && WordBuffer[i]<='F'),"Bad character in hex value");
			ParseAssert((*pInt&0xf0000000)==0,"Hex value too big");
			if (WordBuffer[i]>='0' && WordBuffer[i]<='9')
				*pInt=(*pInt<<4)|(WordBuffer[i]-'0');
			else if (WordBuffer[i]>='a' && WordBuffer[i]<='f')
				*pInt=(*pInt<<4)|(WordBuffer[i]-'a'+10);
			else
				*pInt=(*pInt<<4)|(WordBuffer[i]-'A'+10);
		}
		return ESCRIPTTOKEN_HEXINTEGER;
	}

	// Check if it is a number.
	if (WordBuffer[0]=='-' || WordBuffer[0]=='.' || (WordBuffer[0]>='0' && WordBuffer[0]<='9'))
	{
		char *pCh=WordBuffer;
		int Negative;
		if (*pCh=='-')
		{
			Negative=TRUE;
			++pCh;
		}
		else
			Negative=FALSE;

		ParseAssert(*pCh,"Numeric value with no digits");
		int IntVal=0;
		while (*pCh && *pCh!='.')
		{
			ParseAssert(*pCh>='0' && *pCh<='9',"Bad character in number");
			ParseAssert(IntVal*10.0+*pCh-'0'<=(double)0x7fffffff,"Integer value out of range");
			IntVal=IntVal*10+*pCh-'0';
			++pCh;
		}

		if (*pCh==0)
		{
			if (Negative) IntVal=-IntVal;
			*pInt=IntVal;
			return ESCRIPTTOKEN_INTEGER;
		}

		++pCh; // Skip over the '.'

		double FloatVal=IntVal;
		double d=10;
		while (*pCh)
		{
			ParseAssert(*pCh>='0' && *pCh<='9',"Bad character in fractional part of float");
			FloatVal+=(*pCh-'0')/d;
			ParseAssert(d<10000000000,"Too many digits in fractional part of float");
			d*=10;
			++pCh;
		}

		if (Negative) FloatVal=-FloatVal;
		*pFloatValue=(float)FloatVal;
		return ESCRIPTTOKEN_FLOAT;
	}

	// Check if it is a keyword.
	if (stricmp(WordBuffer,"begin")==0)		return ESCRIPTTOKEN_KEYWORD_BEGIN;
	if (stricmp(WordBuffer,"repeat")==0)	return ESCRIPTTOKEN_KEYWORD_REPEAT;
	if (stricmp(WordBuffer,"break")==0)		return ESCRIPTTOKEN_KEYWORD_BREAK;
	if (stricmp(WordBuffer,"script")==0)	return ESCRIPTTOKEN_KEYWORD_SCRIPT;
	if (stricmp(WordBuffer,"endscript")==0)	return ESCRIPTTOKEN_KEYWORD_ENDSCRIPT;
	if (stricmp(WordBuffer,"if")==0)		return ESCRIPTTOKEN_KEYWORD_IF;
	if (stricmp(WordBuffer,"else")==0)		return ESCRIPTTOKEN_KEYWORD_ELSE;
	if (stricmp(WordBuffer,"elseif")==0)	return ESCRIPTTOKEN_KEYWORD_ELSEIF;
	if (stricmp(WordBuffer,"endif")==0)		return ESCRIPTTOKEN_KEYWORD_ENDIF;
	if (stricmp(WordBuffer,"return")==0)	return ESCRIPTTOKEN_KEYWORD_RETURN;
	if (stricmp(WordBuffer,"<...>")==0)		return ESCRIPTTOKEN_KEYWORD_ALLARGS;
	if (stricmp(WordBuffer,"random")==0)	return ESCRIPTTOKEN_KEYWORD_RANDOM;
	if (stricmp(WordBuffer,"randomrange")==0)	return ESCRIPTTOKEN_KEYWORD_RANDOM_RANGE;
	if (stricmp(WordBuffer,"random2")==0)		return ESCRIPTTOKEN_KEYWORD_RANDOM2;
	if (stricmp(WordBuffer,"randomrange2")==0)	return ESCRIPTTOKEN_KEYWORD_RANDOM_RANGE2;
	if (stricmp(WordBuffer,"randomnorepeat")==0)return ESCRIPTTOKEN_KEYWORD_RANDOM_NO_REPEAT;
	if (stricmp(WordBuffer,"randompermute")==0) return ESCRIPTTOKEN_KEYWORD_RANDOM_PERMUTE;
	if (stricmp(WordBuffer,"randomshuffle")==0) return ESCRIPTTOKEN_KEYWORD_RANDOM_PERMUTE;
	if (stricmp(WordBuffer,"not")==0)		return ESCRIPTTOKEN_KEYWORD_NOT;
	//if (stricmp(WordBuffer,"and")==0)		return ESCRIPTTOKEN_KEYWORD_AND;
	//if (stricmp(WordBuffer,"or")==0)		return ESCRIPTTOKEN_KEYWORD_OR;
	if (stricmp(WordBuffer,"switch")==0)	return ESCRIPTTOKEN_KEYWORD_SWITCH;
	if (stricmp(WordBuffer,"endswitch")==0)	return ESCRIPTTOKEN_KEYWORD_ENDSWITCH;
	if (stricmp(WordBuffer,"case")==0)		return ESCRIPTTOKEN_KEYWORD_CASE;
	if (stricmp(WordBuffer,"default")==0)	return ESCRIPTTOKEN_KEYWORD_DEFAULT;
	if (stricmp(WordBuffer,"return")==0)	return ESCRIPTTOKEN_KEYWORD_RETURN;

	// Check if it is a name.
	int IsName=TRUE;
	for (int i=0; i<Len; ++i)
	{
		if (!(WordBuffer[i]=='_' || 
			  (WordBuffer[i]>='0' && WordBuffer[i]<='9') ||
			  (WordBuffer[i]>='a' && WordBuffer[i]<='z') ||
			  (WordBuffer[i]>='A' && WordBuffer[i]<='Z')))
		{
		  IsName=FALSE;
		  break;
		}
	}
	if (IsName) 
	{
		return ESCRIPTTOKEN_NAME;
	}

	// Error if none of the above.
	ParseAssert("Unrecognized character sequence");
	return ESCRIPTTOKEN_ENDOFFILE;
}

unsigned long SpaceRemaining=0;
unsigned long OutputBufferSize=0;
char *pWritePos=NULL;
void CreateOutputBuffer(int Size)
{
	Assert(pOutputBuffer==NULL,"pOutputBuffer not NULL ?");
	pOutputBuffer=(char*)malloc(Size);
	Assert(pOutputBuffer!=NULL,"Could not allocate memory for pOutputBuffer");
	OutputBufferSize=Size;
	SpaceRemaining=Size;
	pWritePos=pOutputBuffer;
}

#define TOKENBUFSIZE 10
char *pLastToken[TOKENBUFSIZE]={NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
int MostRecent=0;

#define MAXNESTEDRANDOMS 362
struct SRandom
{
	uint16 *pWeights;
	uint32 *pOffsets;
	uint32 NumOffsets;
	uint32 CurrentOffset;
	int ParenthCount;
};
SRandom pRandoms[MAXNESTEDRANDOMS];
int NumRandoms=0;

const char *SkipOverRandomOperator(const char *pCh)
{
	while (true)
	{
		pCh=GetNextWord(pCh);
		if (WordBuffer[0]!=0x0a)
		{
			break;
		}
	}
	ParseAssert(WordBuffer[0]=='(',"'Random' keyword must be followed by an open parenthesis");

	int ParCount=1;

	while (true)
	{
		pCh=GetNextWord(pCh);
		if (WordBuffer[0]=='(')
		{
			++ParCount;
		}
		if (WordBuffer[0]==')')
		{
			--ParCount;
		}

		if (ParCount==0)
		{
			break;
		}

		if (stricmp(WordBuffer,"random")==0 || stricmp(WordBuffer,"random2")==0)
		{
			pCh=SkipOverRandomOperator(pCh);
		}
	}
	return pCh;
}

char *GetLastTokenPointer(int i)
{
	if (i>=TOKENBUFSIZE) return NULL;
	i+=MostRecent;
	if (i>=TOKENBUFSIZE) i-=TOKENBUFSIZE;
	return pLastToken[i];
}

void AddNewTokenPointer(char *pToken)
{
	--MostRecent;
	if (MostRecent<0) MostRecent=TOKENBUFSIZE-1;
	pLastToken[MostRecent]=pToken;
}

void Pop()
{
	int FreedSpace=pWritePos-pLastToken[MostRecent];
	Assert(FreedSpace>=0,"Pop error, negative freed space");
	SpaceRemaining+=FreedSpace;

	pWritePos=pLastToken[MostRecent];
	Assert(pWritePos!=NULL,"Bad Pop");
	++MostRecent;
	if (MostRecent>=TOKENBUFSIZE) MostRecent=0;
}

// Integer.
void WriteToken(int n)
{
	Assert(SpaceRemaining>=1+sizeof(uint32),"Output buffer too small");
	AddNewTokenPointer(pWritePos);
	*pWritePos++=ESCRIPTTOKEN_INTEGER;
	*(int*)pWritePos=n;
	pWritePos+=sizeof(uint32);
	SpaceRemaining-=1+sizeof(uint32);
}

// Float.
void WriteToken(float n)
{
	Assert(SpaceRemaining>=1+sizeof(float),"Output buffer too small");
	AddNewTokenPointer(pWritePos);
	*pWritePos++=ESCRIPTTOKEN_FLOAT;
	*(float*)pWritePos=n;
	pWritePos+=sizeof(float);
	SpaceRemaining-=1+sizeof(float);
}

// Single token.
void WriteToken(EScriptToken Type)
{
	Assert(SpaceRemaining>=1,"Output buffer too small");
	AddNewTokenPointer(pWritePos);
	*pWritePos++=Type;
	--SpaceRemaining;
}

// String or local string, endoflinenumber, name.
void WriteToken(EScriptToken Type, int n)
{
	switch (Type)
	{
	case ESCRIPTTOKEN_ENDOFLINENUMBER:
	case ESCRIPTTOKEN_NAME:
		Assert(SpaceRemaining>=1+sizeof(uint32),"Output buffer too small");
		AddNewTokenPointer(pWritePos);
		*pWritePos++=Type;
		*(int*)pWritePos=n;
		pWritePos+=sizeof(uint32);
		SpaceRemaining-=1+sizeof(uint32);
		break;
	case ESCRIPTTOKEN_STRING:
	case ESCRIPTTOKEN_LOCALSTRING:
		if (Type==ESCRIPTTOKEN_STRING)
			Assert(WordBuffer[0]=='"' && WordBuffer[1+n]=='"',"Bad WordBuffer");
		else
			Assert(WordBuffer[0]=='\'' && WordBuffer[1+n]=='\'',"Bad WordBuffer");

		Assert(SpaceRemaining>=1+sizeof(uint32)+n+1,"Output buffer too small");
		AddNewTokenPointer(pWritePos);
		*pWritePos++=Type;
		*(int*)pWritePos=n+1;
		pWritePos+=sizeof(uint32);
		strcpy(pWritePos,WordBuffer+1);
		pWritePos+=n;
		*pWritePos++=0;
		SpaceRemaining-=1+sizeof(uint32)+n+1;
		break;
	default:
		Assert(0,"Bad token type sent to WriteToken(EScriptToken Type, int n)");
		break;
	}
}

// Vector.
void WriteToken(float x, float y, float z)
{
	Assert(SpaceRemaining>=1+3*sizeof(float),"Output buffer too small");
	AddNewTokenPointer(pWritePos);
	*pWritePos++=ESCRIPTTOKEN_VECTOR;
	*(float*)pWritePos=x;
	pWritePos+=sizeof(float);
	*(float*)pWritePos=y;
	pWritePos+=sizeof(float);
	*(float*)pWritePos=z;
	pWritePos+=sizeof(float);
	SpaceRemaining-=1+3*sizeof(float);
}

// Pair.
void WriteToken(float x, float y)
{
	Assert(SpaceRemaining>=1+2*sizeof(float),"Output buffer too small");
	AddNewTokenPointer(pWritePos);
	*pWritePos++=ESCRIPTTOKEN_PAIR;
	*(float*)pWritePos=x;
	pWritePos+=sizeof(float);
	*(float*)pWritePos=y;
	pWritePos+=sizeof(float);
	SpaceRemaining-=1+2*sizeof(float);
}

// Checksum & Name
void WriteToken(SChecksumEntry *pStoredChecksum)
{
	unsigned int NameLength=strlen((char*)(pStoredChecksum+1));
	Assert(SpaceRemaining>=1+sizeof(uint32)+NameLength+1,"Output buffer too small to add checksum names");
	AddNewTokenPointer(pWritePos);
	*pWritePos++=ESCRIPTTOKEN_CHECKSUM_NAME;
	*(unsigned long*)pWritePos=pStoredChecksum->Checksum;
	pWritePos+=sizeof(uint32);
	strcpy(pWritePos,(char*)(pStoredChecksum+1));
	pWritePos+=NameLength+1;
	SpaceRemaining-=1+sizeof(uint32)+NameLength+1;
}

// 'Random' operator
void WriteRandomToken(uint32 n, EScriptToken Type, int ParenthCount)
{
	Assert(Type==ESCRIPTTOKEN_KEYWORD_RANDOM || 
		   Type==ESCRIPTTOKEN_KEYWORD_RANDOM2 ||
		   Type==ESCRIPTTOKEN_KEYWORD_RANDOM_PERMUTE ||
		   Type==ESCRIPTTOKEN_KEYWORD_RANDOM_NO_REPEAT,"Bad Type sent to WriteRandomToken");
	uint32 SpaceRequired=1+sizeof(uint32)+n*sizeof(uint16)+n*sizeof(uint32);
	Assert(SpaceRemaining>=SpaceRequired,"Output buffer too small");
	SpaceRemaining-=SpaceRequired;

	AddNewTokenPointer(pWritePos);

	// Write the token
	*pWritePos++=Type;

	// Write the number of offsets that follow.
	*(uint32*)pWritePos=n;
	pWritePos+=sizeof(uint32);

	// Store a pointer to the offsets array so that they can be filled in later.
	ParseAssert(NumRandoms<MAXNESTEDRANDOMS,"Too many nested 'Random' operators");
	pRandoms[NumRandoms].pWeights=(uint16*)pWritePos;
	pRandoms[NumRandoms].pOffsets=(uint32*)(pWritePos+n*sizeof(uint16));
	pRandoms[NumRandoms].CurrentOffset=0;
	pRandoms[NumRandoms].NumOffsets=n;
	pRandoms[NumRandoms].ParenthCount=ParenthCount;
	++NumRandoms;

	// Reserve space for the weights
	for (uint32 i=0; i<n; ++i)
	{
		*(uint16*)pWritePos=0x6969;
		pWritePos+=sizeof(uint16);
	}

	// Reserve space for the offsets, filling them with 0x69696969 to
	// make it easy to see if any have not been filled in.
	for (uint32 i=0; i<n; ++i)
	{
		*(uint32*)pWritePos=0x69696969;
		pWritePos+=sizeof(uint32);
	}
}

void WriteJumpToken(uint32 Offset)
{
	uint32 SpaceRequired=1+sizeof(uint32);
	Assert(SpaceRemaining>=SpaceRequired,"Output buffer too small");
	SpaceRemaining-=SpaceRequired;

	AddNewTokenPointer(pWritePos);

	// Write the token
	*pWritePos++=ESCRIPTTOKEN_JUMP;

	// Write in the offset.
	*(uint32*)pWritePos=Offset;
	pWritePos+=sizeof(uint32);
}

void QComp(const char *_pSourceName)
{
	// Store the passed source name into a global so that error messages can use it.
	Assert(strlen(_pSourceName)<=MAXFILENAMELEN-20,"Source file name too long");
	strcpy(pSourceName,_pSourceName);

	// Check that the passed file name has extension .q or .qb
	int NameLen=strlen(pSourceName);
	Assert(NameLen>2,"Source file name too short");
	Assert(stricmp(pSourceName+NameLen-2,".q")==0 || stricmp(pSourceName+NameLen-3,".qn")==0,"Source file must have extension .q or .qn");

	// Use the same directory as that of the source file for the qb.
	strcpy(pOutputDirectory,pSourceName);
	// Find the last occurrence of the backslash character.
	char *pBackslash=strrchr(pOutputDirectory,'\\');
	
	if (pBackslash==NULL)
	{
		// If no backslash found, the directory is the empty string.
		pOutputDirectory[0]=0;
	}
	else
	{
		// Otherwise terminate after the backslash.
		*(pBackslash+1)=0;
	}
	
	// Load the whole .q into memory for ease of parsing.
	// Must be binary: in text mode on Windows ftell counts CRLF as 2 bytes but
	// fread collapses them, so fread() would come up short and fail.
	FILE *ifp=_qcomp_fopen(pSourceName,"rb");
	Assert(ifp!=NULL,"Could not open source file");
	fseek(ifp,0,SEEK_END);
	long SourceSize=ftell(ifp);
	fseek(ifp,0,SEEK_SET);
	char *pSource=(char*)malloc(SourceSize+1); // +1 for a terminating 0
	Assert(pSource!=NULL,"Could not allocate memory to hold input file");
	Assert(fread(pSource,SourceSize,1,ifp)==1,"fread failed");
	fclose(ifp);
	ifp=NULL;
	// Put a terminating 0 on the end so that the end of file can be detected easily
	// without having to compare some counter to SourceSize.
	pSource[SourceSize]=0; 

	// Create the output buffer using the same size as the input file plus a bit, which should be safe since the
	// output file will very likely be smaller than the source. (An assert will go off if not)
	// In rare cases it is possible that the buffer will be too small, eg when the source file contains nothing
	// but an array of small integers such as [1 2 3 4]. These will get converted to 4 bytes each, hence the
	// output file will be bigger than the source. This is why the 1000 is added. Just make it bigger if any problems!
	// Note: Not easy to just realloc, because of the buffer of pointers to previous tokens. The realloc may move the
	// buffer in memory.
	CreateOutputBuffer(SourceSize+100000);

	// Initialise the checksum name hash table.
	InitHashTable();

	// Preprocessing stage.
	// Strip all the comments out, and merge any lines split using the \ character.
	StripCommentsAndMergeLines(pSource);

	
	// Loop through all the things in the source file, check for errors, and write
	// everything in compacted form into the output buffer.
	LineNumber=0;
	const char *pSrc=pSource;
	int ParenthCount=0;
	int CurlyCount=0;
	int SquareCount=0;
	char *pPrevious=NULL;
	char *pNextPrevious=NULL;
	char *pPrevious0=NULL;
	char *pPrevious1=NULL;
	char *pPrevious2=NULL;
	int LastWasEndOfLine=FALSE;
	int LastWasAt=FALSE;
	int InScript=FALSE;
	int NumBegins=0;
	int NumIfs=0;
	int NumSwitches=0;
	while (TRUE)
	{
		// Get the next thing from the source file.
		pSrc=GetNextWord(pSrc);
		// Determine what type of thing it is.
		int IntValue;
		float FloatValue;
		EScriptToken TokenType=DetermineTokenType(&IntValue,&FloatValue);
		
		// Only export switch statement tokens if they are the first on
		// their line, and inside a script.
		// This is to get around the fact that the words 'switch' and 'default'
		// are used quite a bit in structures already.
		// 'case' and 'endswitch' aren't actually used anywhere in structures,
		// but I thought I'd include them too just for neatness.
		if (TokenType==ESCRIPTTOKEN_KEYWORD_SWITCH ||
			TokenType==ESCRIPTTOKEN_KEYWORD_ENDSWITCH ||
			TokenType==ESCRIPTTOKEN_KEYWORD_CASE ||
			TokenType==ESCRIPTTOKEN_KEYWORD_DEFAULT)
		{
			if (!(InScript && LastWasEndOfLine))
			{
				// Convert it back to a name token.
				TokenType=ESCRIPTTOKEN_NAME;
			}
		}

		// If the word 'repeat' is used inside a structure, then treat it
		// as a name, not a keyword, hence allowing things like repeat=1
		// inside structures.
		if (TokenType==ESCRIPTTOKEN_KEYWORD_REPEAT)
		{
			if (CurlyCount)
			{
				// Convert it back to a name token.
				TokenType=ESCRIPTTOKEN_NAME;
			}
		}

		switch (TokenType)
		{
		case ESCRIPTTOKEN_KEYWORD_BEGIN:
			ParseAssert(InScript,"begin keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"begin keyword must be the first word on its line");
			++NumBegins;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_REPEAT:
			ParseAssert(InScript,"repeat keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"repeat keyword must be the first word on its line");
			ParseAssert(NumBegins>0,"repeat without begin");
			--NumBegins;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_BREAK:
			ParseAssert(InScript,"break keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"break keyword must be the first word on its line");
			ParseAssert(NumBegins>0,"break keyword must be inside a begin-repeat loop");
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_RETURN:
			ParseAssert(InScript,"return keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"return keyword must be the first word on its line");
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_IF:
			ParseAssert(InScript,"if keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"if keyword must be the first word on its line");
			++NumIfs;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_ELSE:
			ParseAssert(InScript,"else keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"else keyword must be the first word on its line");
			ParseAssert(NumIfs,"else keyword must be inside an if-endif statement");
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_ELSEIF:
			ParseAssert(InScript,"elseif keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"elseif keyword must be the first word on its line");
			ParseAssert(NumIfs,"elseif keyword must be inside an if-endif statement");
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_ENDIF:
			ParseAssert(InScript,"endif keyword can only be used inside scripts");
			ParseAssert(LastWasEndOfLine,"endif keyword must be the first word on its line");
			ParseAssert(NumIfs,"endif without if");
			--NumIfs;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_SWITCH:
			++NumSwitches;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_ENDSWITCH:
			ParseAssert(NumSwitches!=0,"endswitch without corresponding switch");
			--NumSwitches;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_CASE:
			ParseAssert(NumSwitches>0,"case keyword not in a switch statement");
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_DEFAULT:
			ParseAssert(NumSwitches>0,"default keyword not in a switch statement");
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_SCRIPT:
			ParseAssert(InScript==FALSE,"Missing endscript");
			InScript=TRUE;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_KEYWORD_ENDSCRIPT:
			ParseAssert(InScript==TRUE,"endscript without corresponding script");
			ParseAssert(NumBegins==0,"Missing repeat");
			ParseAssert(NumIfs==0,"Missing endif");
			ParseAssert(NumSwitches==0,"Missing endswitch");
			InScript=FALSE;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_STARTARRAY:
			++SquareCount;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_ENDARRAY:
			--SquareCount;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_STARTSTRUCT:
			++CurlyCount;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_ENDSTRUCT:
			--CurlyCount;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_OPENPARENTH:
			++ParenthCount;
			WriteToken(TokenType);
			break;
		case ESCRIPTTOKEN_CLOSEPARENTH:
			--ParenthCount;
			
			// Check if need to reexport as a vector.
			pPrevious=GetLastTokenPointer(5);
			if (pPrevious!=NULL && *pPrevious==(char)ESCRIPTTOKEN_OPENPARENTH)
			{
				char *pX=GetLastTokenPointer(4);
				if (pX!=NULL && (*pX==(char)ESCRIPTTOKEN_INTEGER || *pX==(char)ESCRIPTTOKEN_FLOAT))
				{
					char *pComma1=GetLastTokenPointer(3);
					if (pComma1!=NULL && *pComma1==(char)ESCRIPTTOKEN_COMMA)
					{
						char *pY=GetLastTokenPointer(2);
						if (pY!=NULL && (*pY==(char)ESCRIPTTOKEN_INTEGER || *pY==(char)ESCRIPTTOKEN_FLOAT))
						{
							char *pComma2=GetLastTokenPointer(1);
							if (pComma2!=NULL && *pComma2==(char)ESCRIPTTOKEN_COMMA)
							{
								char *pZ=GetLastTokenPointer(0);
								if (pZ!=NULL && (*pZ==(char)ESCRIPTTOKEN_INTEGER || *pZ==(char)ESCRIPTTOKEN_FLOAT))
								{
									Pop();
									Pop();
									Pop();
									Pop();
									Pop();
									Pop();
									float x=(*pX==(char)ESCRIPTTOKEN_INTEGER)?*(int*)(pX+1):*(float*)(pX+1);
									float y=(*pY==(char)ESCRIPTTOKEN_INTEGER)?*(int*)(pY+1):*(float*)(pY+1);
									float z=(*pZ==(char)ESCRIPTTOKEN_INTEGER)?*(int*)(pZ+1):*(float*)(pZ+1);
									WriteToken(x,y,z);
									break;
								}
							}
						}
					}
				}
			}

			// Check if need to reexport as a pair.
			pPrevious=GetLastTokenPointer(3);
			if (pPrevious!=NULL && *pPrevious==(char)ESCRIPTTOKEN_OPENPARENTH)
			{
				char *pX=GetLastTokenPointer(2);
				if (pX!=NULL && (*pX==(char)ESCRIPTTOKEN_INTEGER || *pX==(char)ESCRIPTTOKEN_FLOAT))
				{
					char *pComma=GetLastTokenPointer(1);
					if (pComma!=NULL && *pComma==(char)ESCRIPTTOKEN_COMMA)
					{
						char *pY=GetLastTokenPointer(0);
						if (pY!=NULL && (*pY==(char)ESCRIPTTOKEN_INTEGER || *pY==(char)ESCRIPTTOKEN_FLOAT))
						{
							Pop();
							Pop();
							Pop();
							Pop();
							float x=(*pX==(char)ESCRIPTTOKEN_INTEGER)?*(int*)(pX+1):*(float*)(pX+1);
							float y=(*pY==(char)ESCRIPTTOKEN_INTEGER)?*(int*)(pY+1):*(float*)(pY+1);
							WriteToken(x,y);
							break;
						}
					}
				}
			}

			if (NumRandoms)
			{
				// Get the most recent SRandom
				SRandom *pRand=&pRandoms[NumRandoms-1];
				if (pRand->ParenthCount==ParenthCount)
				{
					// Check that all the offsets have been filled in.
					ParseAssert(pRand->CurrentOffset==pRand->NumOffsets,"Unexpected close parenthesis in 'Random' operator");

					// Make each of the jump commands at the end of each block jump to after the random operator.
					for (uint32 i=1; i<pRand->NumOffsets; ++i)
					{
						uint8 *pAfterJump=(uint8*)(pRand->pOffsets+i+1)+pRand->pOffsets[i];
						uint8 *pJump=pAfterJump-5;
						Assert(*pJump==ESCRIPTTOKEN_JUMP,"pJump does not point to a jump instruction ???");
						Assert((uint8*)pWritePos>=pAfterJump,"pWritePos less than pAfterJump ???");
						*(uint32*)(pJump+1)=(uint8*)pWritePos-pAfterJump;
					}
					--NumRandoms;
					break;
				}
			}

			// The close parenth does not belong to a vector, pair, or Random, so
			// export it as a token.
			WriteToken(TokenType);
			break;

		case ESCRIPTTOKEN_GREATERTHAN:
			// Check if need to reexport as ESCRIPTTOKEN_ARG.
			// If a word is surrounded by <,> then the token ESCRIPTTOKEN_ARG is inserted before it
			// and the brackets are removed.
			pPrevious=GetLastTokenPointer(1);
			if (pPrevious!=NULL && *pPrevious==(char)ESCRIPTTOKEN_LESSTHAN)
			{
				char *pName=GetLastTokenPointer(0);
				if (pName!=NULL && *pName==(char)ESCRIPTTOKEN_NAME)
				{
					uint32 NameChecksum=*(uint32*)(pName+1);					
					Pop();
					Pop();
					WriteToken(ESCRIPTTOKEN_ARG);
					WriteToken(ESCRIPTTOKEN_NAME,NameChecksum);
					break;
				}
			}
			WriteToken(TokenType);
			break;
		
		//case ESCRIPTTOKEN_COMMA:
			// Commas are ignored.
		//	break;
		case ESCRIPTTOKEN_HEXINTEGER:
		case ESCRIPTTOKEN_INTEGER:
			WriteToken(IntValue);
			break;
		case ESCRIPTTOKEN_FLOAT:
			WriteToken(FloatValue);
			break;
		case ESCRIPTTOKEN_NAME:
			WriteToken(TokenType,GenerateChecksum(WordBuffer));
			break;
		case ESCRIPTTOKEN_STRING:
		case ESCRIPTTOKEN_LOCALSTRING:
			// The -2 is the space occupied by the quotes.
			WriteToken(TokenType,strlen(WordBuffer)-2);
			break;
		case ESCRIPTTOKEN_ENDOFLINE:
			++LineNumber;

			// Don't write out repeated end-of-line tokens, or end-of-lines
			// that are within array or structure declarations.
			// This is just for space efficiency, it isn't essential for
			// the interpreter.
			//if (!LastWasEndOfLine && CurlyCount==0 && SquareCount==0)
			// Note: Would be good if it did actually include line number info inside
			// structures and arrays, but this currently causes 2 problems:
			// 1) Sometimes the output buffer for the qb is no longer big enough, due to
			//    all the extra line number info.
			// 2) The game code asserts, because it is not expecting line number info tokens
			//    inside structures or arrays. 
			// Fix at some point, then I can comment in the if below.
			if (!LastWasEndOfLine)
			{
				if (IncludeLineNumbers)
					WriteToken(ESCRIPTTOKEN_ENDOFLINENUMBER,LineNumber);
				else
					WriteToken(ESCRIPTTOKEN_ENDOFLINE);
				LastWasEndOfLine=TRUE;
			}
			break;
		case ESCRIPTTOKEN_ENDOFFILE:
			ParseAssert(InScript==FALSE,"Missing endscript");
			ParseAssert(NumBegins==0,"Missing repeat");
			ParseAssert(NumIfs==0,"Missing endif");
			ParseAssert(NumSwitches==0,"Missing endswitch");
			if (ParenthCount)
			{
				if (ParenthCount<0)
					ParseAssert("More close parentheses than open parentheses");
				else
					ParseAssert("More open parentheses than close parentheses");
			}
			if (CurlyCount)
			{
				if (CurlyCount<0)
					ParseAssert("More close curly brackets than open curly brackets");
				else
					ParseAssert("More open curly brackets than close curly brackets");
			}
			if (SquareCount)
			{
				if (SquareCount<0)
					ParseAssert("More close square brackets than open square brackets");
				else
					ParseAssert("More open square brackets than close square brackets");
			}
			break;
		case ESCRIPTTOKEN_KEYWORD_RANDOM:
		case ESCRIPTTOKEN_KEYWORD_RANDOM2:
		case ESCRIPTTOKEN_KEYWORD_RANDOM_NO_REPEAT:
		case ESCRIPTTOKEN_KEYWORD_RANDOM_PERMUTE:
		{
			ParseAssert(InScript,"'Random' operator can only be used inside scripts");
			// Skip over the 'random' keyword so that we get to the (
			const char *pCh=pSrc;
			while (true)
			{
				pCh=GetNextWord(pCh);
				if (WordBuffer[0]!=0x0a)
				{
					break;
				}
				++LineNumber;
			}
			ParseAssert(WordBuffer[0]=='(',"'Random' keyword must be followed by an open parenthesis");
			++ParenthCount;

			// Skip to the first @
			pSrc=pCh;
			while (true)
			{
				pCh=GetNextWord(pCh);
				if (WordBuffer[0]!=0x0a)
				{
					break;
				}
			}
			ParseAssert(WordBuffer[0]=='@',"Missing the initial '@' in 'Random' operator");

			// Count how many @'s are in this random
			int ParCount=0;
			uint32 NumItems=1;
			bool Finished=false;
			while (!Finished)
			{
				pCh=GetNextWord(pCh);

				// Skip over any nested randoms so that we don't count their @'s
				if (stricmp(WordBuffer,"random")==0 || 
					stricmp(WordBuffer,"random2")==0 ||
					stricmp(WordBuffer,"randomnorepeat")==0 || 
					stricmp(WordBuffer,"randompermute")==0 ||
					stricmp(WordBuffer,"randomshuffle")==0)
				{
					pCh=SkipOverRandomOperator(pCh);
					pCh=GetNextWord(pCh);
				}

				switch (WordBuffer[0])
				{
				case 0:
					ParseAssert("Missing close parenthesis after 'Random'");
					break;
				case '@':
					++NumItems;
					break;
				case '(':
					++ParCount;
					break;
				case ')':
					if (ParCount)
					{
						--ParCount;
					}
					else
					{
						Finished=true;
					}
					break;
				default:
					break;
				}
			}

			// Note: Recording what the ParenthCount was at the time the Random keyword
			// was encountered, hence the ParenthCount-1
			// (the random keyword is followed by an open parenth)
			// Recording the ParenthCount so that when a close parenth is encountered later
			// we can tell whether it is the close parenth of the random rather than of some
			// sub expression by comparing counts.
			WriteRandomToken(NumItems,TokenType,ParenthCount-1);
			break;
		}
		case ESCRIPTTOKEN_AT:
		{
			ParseAssert(NumRandoms,"Got an '@' character outside of a 'Random' operator");

			SRandom *pRand=&pRandoms[NumRandoms-1];
			Assert(pRand->CurrentOffset<pRand->NumOffsets,"Too many '@'s inside Random operator ???");

			if (pRand->CurrentOffset)
			{
				// Use a dummy offset of 0 for the moment, cos we don't
				// know the true value yet.
				WriteJumpToken(0);
			}

			pRand->pOffsets[pRand->CurrentOffset]=pWritePos-(char*)(pRand->pOffsets+pRand->CurrentOffset+1);
			pRand->pWeights[pRand->CurrentOffset]=1;
			++pRand->CurrentOffset;
			LastWasAt=TRUE;
			break;
		}

		case ESCRIPTTOKEN_KEYWORD_RANDOM_RANGE:
		case ESCRIPTTOKEN_KEYWORD_RANDOM_RANGE2:
		{
			ParseAssert(InScript,"'RandomRange' operator can only be used inside scripts");
			WriteToken(TokenType);
			break;
		}

		case ESCRIPTTOKEN_MULTIPLY:
		{
			if (LastWasAt)
			{
				pSrc=GetNextWord(pSrc);
				int weight_value;
				float dummy;
				EScriptToken next_token_type=DetermineTokenType(&weight_value,&dummy);
				switch (next_token_type)
				{
				case ESCRIPTTOKEN_INTEGER:
					break;
				case ESCRIPTTOKEN_ENDOFLINE:
				case ESCRIPTTOKEN_ENDOFLINENUMBER:
					ParseAssert(0,"In the 'random' operator, @* must be followed by an integer with no line breaks");
					break;
				default:
					ParseAssert(0,"In the 'random' operator, @* must be followed by an integer");
					break;
				}

				ParseAssert(weight_value>=0,"'Random' operator weight values cannot be negative.");

				// weight_value is going into a uint16, and also the sum of the weights must
				// not exceed 32767, so limit each value to 32767.
				ParseAssert(weight_value<=32767,"'Random' operator weight value is too large. Max is 32767");

				ParseAssert(NumRandoms,"Got an '@*' weight value outside of a 'Random' operator");
				SRandom *pRand=&pRandoms[NumRandoms-1];
				Assert(pRand->CurrentOffset<=pRand->NumOffsets,"LastWasAt: pRand->CurrentOffset>pRand->NumOffsets ???");
				Assert(pRand->CurrentOffset>0,"LastWasAt: pRand->CurrentOffset<=0 ???");
				// Note: pRand->CurrentOffset will have been incremented by the last @, so need
				// to subtract 1 when indexing into the pWeights array
				pRand->pWeights[pRand->CurrentOffset-1]=weight_value;

				if (pRand->CurrentOffset==pRand->NumOffsets)
				{
					// Whilst we're here, check the sum of the weights. The game code will assert if
					// it is too big, but we may as well catch it here.
					uint32 sum_of_weights=0;
					for (uint32 i=0; i<pRand->NumOffsets; ++i)
					{
						sum_of_weights+=pRand->pWeights[i];
					}
					ParseAssert(sum_of_weights>0,"The sum of the 'Random' operator weight values must be greater than zero.");
					ParseAssert(sum_of_weights<=32767,"The sum of the 'Random' operator weight values is too large.\nThe sum of the weights must not exceed 32767 otherwise the calculations in the game code will overflow.");
				}
				break;
			}
			WriteToken(TokenType);
			break;
		}

		default:
			WriteToken(TokenType);
			break;
		}

		if (TokenType!=ESCRIPTTOKEN_AT)
		{
			if (TokenType==ESCRIPTTOKEN_ENDOFLINE || 
				TokenType==ESCRIPTTOKEN_ENDOFLINENUMBER)
			{
				// Allow end-of-lines in between the @ and any weight value.
			}
			else
			{
				LastWasAt=FALSE;
			}
		}
		if (TokenType!=ESCRIPTTOKEN_ENDOFLINE) LastWasEndOfLine=FALSE;
		if (TokenType==ESCRIPTTOKEN_ENDOFFILE) break;
	}

	Assert(NumRandoms==0,"Expected NumRandoms to be 0 ???");

	// Write out the checksum names if required. (Useful when debugging)
	if (ChecksumNames)
	{
		for (uint32 i=0; i<(1<<HASHBITS); ++i)
		{
			SChecksumEntry *pEntry=ppHashTableEntries[i];
			while (pEntry!=NULL)
			{
				WriteToken(pEntry);
				pEntry=pEntry->pNext;
			}
		}
	}

	WriteToken(ESCRIPTTOKEN_ENDOFFILE);

	if (CreateTextFile)
	{
		// Copy the directory path into the output file name.
		strcpy(pOutputName,pOutputDirectory);
		// Find the start of the filename in the source name.
		char *pName=strrchr(pSourceName,'\\');
		if (pName==NULL)
			pName=pSourceName;
		else
			++pName;
		// Append it to the path.
		strcat(pOutputName,pName);
		// Find the dot.
		char *pExt=strrchr(pOutputName,'.');
		Assert(pExt!=NULL,"No dot in output name?");
		// Change the extension to .txt
		++pExt;
		*pExt++='t';
		*pExt++='x';
		*pExt++='t';
		*pExt++=0;
		// Open the .txt and write out the buffer into it.
		FILE *ofp=_qcomp_fopen(pOutputName,"w");
		Assert(ofp!=NULL,"Could not open .txt file for writing.");
	
		const char *pCh=pOutputBuffer;
		while (TRUE)
		{
			EScriptToken Token=(EScriptToken)*pCh;

			// Print the token name.
			fprintf(ofp,"%-15s ",GetTokenName(Token));
			
			switch (Token)
			{
			case ESCRIPTTOKEN_NAME:
				fprintf(ofp,"0x%08x",*(unsigned long*)(pCh+1));
				break;
			case ESCRIPTTOKEN_INTEGER:
			case ESCRIPTTOKEN_HEXINTEGER:
			case ESCRIPTTOKEN_ENDOFLINENUMBER:
				fprintf(ofp,"%d",*(int*)(pCh+1));
				break;
			case ESCRIPTTOKEN_FLOAT:
				fprintf(ofp,"%f",*(float*)(pCh+1));
				break;
			case ESCRIPTTOKEN_STRING:
				fprintf(ofp,"Bytes=%d  \"%s\"",*(unsigned long*)(pCh+1),pCh+5);
				break;
			case ESCRIPTTOKEN_LOCALSTRING:
				fprintf(ofp,"Bytes=%d  \"%s\"",*(unsigned long*)(pCh+1),pCh+5);
				break;
			case ESCRIPTTOKEN_VECTOR:
				fprintf(ofp,"(%f %f %f)",*(float*)(pCh+1),*(float*)(pCh+5),*(float*)(pCh+9));
				break;
			case ESCRIPTTOKEN_PAIR:
				fprintf(ofp,"(%f %f)",*(float*)(pCh+1),*(float*)(pCh+5));
				break;
			case ESCRIPTTOKEN_CHECKSUM_NAME:
				fprintf(ofp,"Checksum=0x%08x  \"%s\"",*(unsigned long*)(pCh+1),pCh+5);
				break;
			case ESCRIPTTOKEN_JUMP:
				fprintf(ofp,"Offset=%d",*(unsigned long*)(pCh+1));
				break;
			case ESCRIPTTOKEN_KEYWORD_RANDOM:
			case ESCRIPTTOKEN_KEYWORD_RANDOM2:
			case ESCRIPTTOKEN_KEYWORD_RANDOM_NO_REPEAT:
			case ESCRIPTTOKEN_KEYWORD_RANDOM_PERMUTE:
			{
				uint32 NumItems=*(unsigned long*)(pCh+1);
				fprintf(ofp,"NumItems=%d Weights=",NumItems);

				uint16 *pWeights=(uint16*)(pCh+5);
				for (uint32 i=0; i<NumItems; ++i)
				{
					fprintf(ofp,"%d",pWeights[i]);
					if (i<NumItems-1)
					{
						fprintf(ofp,",");
					}
				}

				fprintf(ofp," Offsets=");

				uint32 *pOffsets=(uint32*)(pWeights+NumItems);
				for (uint32 i=0; i<NumItems; ++i)
				{
					fprintf(ofp,"%d",pOffsets[i]);
					if (i<NumItems-1)
					{
						fprintf(ofp,",");
					}
				}
				break;
			}
			default:
				break;
			}

			fprintf(ofp,"\n");
			if (Token==ESCRIPTTOKEN_ENDOFFILE) break;
			pCh=(const char*)SkipToken((uint8*)pCh);
		}
		
		fclose(ofp);
		ofp=NULL;
	}

	if (CreateMapFile)
	{
		UpdateMapFile();
	}

	// If Motorola byte ordering is required, scan through the output buffer and reverse the
	// byte ordering.
	if (Endianness==MOTOROLA)
	{
		char *pCh=pOutputBuffer;
		while (TRUE)
		{
			EScriptToken Token=(EScriptToken)*pCh++;

			switch (Token)
			{
			case ESCRIPTTOKEN_INTEGER:
			case ESCRIPTTOKEN_HEXINTEGER:
			case ESCRIPTTOKEN_ENDOFLINENUMBER:
			case ESCRIPTTOKEN_FLOAT:
			case ESCRIPTTOKEN_NAME:
				ReverseLong(pCh);
				pCh+=4;
				break;
			case ESCRIPTTOKEN_STRING:
			case ESCRIPTTOKEN_LOCALSTRING:
				unsigned long Len;
				Len=*(unsigned long*)pCh;
				ReverseLong(pCh);
				pCh+=4+Len;
				break;
			case ESCRIPTTOKEN_VECTOR:
				ReverseLong(pCh);
				ReverseLong(pCh+4);
				ReverseLong(pCh+8);
				pCh+=12;
				break;
			case ESCRIPTTOKEN_PAIR:
				ReverseLong(pCh);
				ReverseLong(pCh+4);
				pCh+=8;
				break;
			case ESCRIPTTOKEN_CHECKSUM_NAME:
				ReverseLong(pCh);
				pCh+=4;
				pCh+=strlen(pCh);
				++pCh;
				break;
			default:
				break;
			}

			if (Token==ESCRIPTTOKEN_ENDOFFILE) break;
		}
	}

	//CheckForInfiniteLoops((const uint8*)pOutputBuffer);

	// Write the output .qb file.

	// Copy the directory path into the output file name.
	strcpy(pOutputName,pOutputDirectory);
	// Find the start of the filename in the source name.
	char *pName=strrchr(pSourceName,'\\');
	if (pName==NULL)
		pName=pSourceName;
	else
		++pName;
	// Append it to the path.
	strcat(pOutputName,pName);
	// Find the dot.
	char *pExt=strrchr(pOutputName,'.');
	Assert(pExt!=NULL,"No dot in output name?");
	// Change the extension to .qb
	++pExt;
	*pExt++='q';
	*pExt++='b';
	*pExt++=0;
	
	// Open the .qb and write out the buffer into it.
	FILE *ofp=_qcomp_fopen(pOutputName,"wb");
	Assert(ofp!=NULL,"\nCould not open .qb file for writing. \n\nIt may have been checked in to SourceSafe by mistake.\nMake sure it is not in SourceSafe, then make your local copy writable.");
	Assert(OutputBufferSize>=SpaceRemaining,"Strange value for SpaceRemaining");
	Assert(fwrite(pOutputBuffer,OutputBufferSize-SpaceRemaining,1,ofp)==1,"fwrite failed");
	fclose(ofp);
	ofp=NULL;

	// Clean up
	if (pSource!=NULL) free (pSource);
	pSource=NULL;
	if (pOutputBuffer!=NULL) free (pOutputBuffer);
	pOutputBuffer=NULL;

	// Add to the log file, which gets printed to the DOS prompt by qcompall.bat after
	// calling qcomp. This is because QComp itself cannot printf to the DOS prompt because
	// it is a windows application.
	Assert(gpLogFile!=NULL,"NULL gpLogFile ?");
	fprintf(gpLogFile,"Compiled %s\n",pSourceName);
}

// Scans through the passed QB giving warning messages if any scripts are found with
// infinite loops in them, which are infinite begin-repeat loops with no break anywhere
// in between.
// This might miss some infinite loops, eg if the break is in an if statement that is
// never true.
// But it might be handy nonetheless.
void CheckForInfiniteLoops(uint8 *pQB)
{
	uint8 *pCh=pQB;
	bool InScript=false;
	uint32 ScriptChecksum=0;

	while (*pCh!=ESCRIPTTOKEN_ENDOFFILE)
	{
		switch (*pCh)
		{
		case ESCRIPTTOKEN_KEYWORD_SCRIPT:
			Assert(!InScript,"Encountered Script keyword inside a script");
			Assert(pCh[1]==ESCRIPTTOKEN_NAME,"Script token not followed by a name ?");
			ScriptChecksum=*(uint32*)(pCh+2);
			InScript=true;
			break;
		case ESCRIPTTOKEN_KEYWORD_ENDSCRIPT:
			Assert(InScript,"Encountered EndScript keyword outside a script");
			InScript=false;
			break;
		case ESCRIPTTOKEN_KEYWORD_BEGIN:
			pCh=CheckLoop(pCh);
			break;
		default:
			break;
		}
		pCh=SkipToken(pCh);
	}
}

uint8 *CheckLoop(uint8 *pCh)
{
	Assert(*pCh==ESCRIPTTOKEN_KEYWORD_BEGIN,"pCh does not point to a loop");
	pCh=SkipToken(pCh);

	bool GotBreak=false;
	while (*pCh!=ESCRIPTTOKEN_KEYWORD_REPEAT)
	{
		switch (*pCh)
		{
		case ESCRIPTTOKEN_KEYWORD_BREAK:
			GotBreak=true;
			break;
		case ESCRIPTTOKEN_KEYWORD_BEGIN:
			pCh=CheckLoop(pCh);
			break;
		default:
			break;
		}
		pCh=SkipToken(pCh);
	}
	if (pCh[1]==ESCRIPTTOKEN_INTEGER)
	{
	}
	else
	{
		if (!GotBreak)
		{
			_MessageBox("Infinite loop !","QComp.exe");
		}
	}
	pCh=SkipToken(pCh);
	return pCh;
}


void search_sub_dir( char* path, CStringList *p_string_list )
{
	struct _finddata_t file_info;
	intptr_t handle;
	char search_string[_MAX_PATH];

	Assert(p_string_list!=NULL,"NULL p_string_list ");

	sprintf( search_string, "%s\\*.*", path );
	handle = _findfirst( search_string, &file_info );
	if( handle >= 0 )
	{
		char ext[_MAX_EXT];

		_splitpath( file_info.name, NULL, NULL, NULL, ext );
		if( file_info.attrib & _A_SUBDIR )
		{
			if( ( stricmp( file_info.name, "." ) != 0 ) &&
				( stricmp( file_info.name, ".." ) != 0 ))
			{
				char new_path[_MAX_PATH];

				sprintf( new_path, "%s\\%s", path, file_info.name );
				search_sub_dir( new_path, p_string_list );
			}
		}
		else if( stricmp( ext, ".q" ) == 0 || stricmp( ext, ".qn" ) == 0 )
		{
			char p_full_name[1000];
			sprintf(p_full_name,"%s\\%s",path,file_info.name);
			p_string_list->AddString(p_full_name);
		}

		while( _findnext( handle, &file_info ) == 0 )
		{
			_splitpath( file_info.name, NULL, NULL, NULL, ext );
			if( file_info.attrib & _A_SUBDIR )
			{
				if( ( stricmp( file_info.name, "." ) != 0 ) &&
					( stricmp( file_info.name, ".." ) != 0 ))
				{
					char new_path[_MAX_PATH];

					sprintf( new_path, "%s\\%s", path, file_info.name );
					search_sub_dir( new_path, p_string_list );
				}
			}
			else if( stricmp( ext, ".q" ) == 0 || stricmp( ext, ".qn" ) == 0 )
			{
				char p_full_name[1000];
				sprintf(p_full_name,"%s\\%s",path,file_info.name);
				p_string_list->AddString(p_full_name);
			}
		}

		_findclose( handle );
	}
}


/*int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)*/
int main(int argc, const char *argv[])
{
	/*
	#define NUMCHECKSUMS 16732 // THPS4, 1 May 2002
	double Tot=pow(2,32);
	double t=0;
	for (int ii=0; ii<NUMCHECKSUMS; ++ii)
		t+=log(Tot-ii);
	t-=NUMCHECKSUMS*log(Tot);

	char Buf[200];
	sprintf(Buf,"Probability of checksum clash amongst %d checksums is %.2f%%",NUMCHECKSUMS,100*(1-exp(t)));
	MessageBox(NULL,Buf,"Probability",MB_OK);
	*/

	if (argc == 1)
	{
		char pBuf[1000];
		sprintf(pBuf,"QCOMP.EXE  %s  %s\n",__DATE__,__TIME__);
		strcat(pBuf,"Compiles the specified list of q or qn files.\n");
		strcat(pBuf,"Example: qcomp  c:\\skate5\\data\\scripts\\ken.q  data\\scripts\\poo.qn\n");
		strcat(pBuf,"(Note that the skate5 path may be omitted)\n\n");
		strcat(pBuf,"Options are:\n");
		strcat(pBuf,"-all\t\t\tCompile all q and qn files in the listed directories (will recurse subdirectories)\n");
		strcat(pBuf,"\t\t\tExample:  qcomp -all  data\\scripts  data\\levels\n");
		strcat(pBuf,"-update\t\t\tCompile only those q and qn files in the listed directories that need compiling (will recurse subdirectories)\n");
		strcat(pBuf,"-nolinenumbers\t\tDo not include line number information in the qb\n");
		strcat(pBuf,"-textfile\t\t\tCreate a .txt file dump of the .qb\n");
		strcat(pBuf,"-slickedit\t\t\tOutput slickedit readable error messages (not working yet)\n");
		strcat(pBuf,"-motorola\t\t\tOutput with Motorola endianness\n");
		strcat(pBuf,"-nochecksumnames\t\tOutput with no checksum name information\n");
		strcat(pBuf,"-nomessageboxes\t\tOutput error messages to qcomp.err rather than a message box\n");
		strcat(pBuf,"-createmap\t\tUpdate the map file\n");
		strcat(pBuf,"\t\t\tNote: It will also update the map file if the CREATEMAP environment variable is set.\n");


		_MessageBox(pBuf,"QComp.exe");
		return -1;
	}

	int lpCmdLineSize = 0;
	for(int i=1;i<argc;i++) {
		lpCmdLineSize += strlen(argv[i]) + 1;
	}

	char *lpCmdLine = (char *)malloc(lpCmdLineSize+1);
	char *p = (char *)lpCmdLine;
	// Convert to lower case, since there is no case-insensitive version of strstr
	for(int i=1;i<argc;i++) {
		int arg_len = strlen(argv[i]);
		for(int c=0;c<arg_len;c++) {
			*p = tolower(argv[i][c]);
			p++;
		}
		*p = ' ';
		p++;
	}
	*p = 0;

	IncludeLineNumbers=true;
	CreateTextFile=false;
	CreateSlickEditErrorMessages=false;
	Endianness=INTEL;
	ChecksumNames=true;
	DisplayErrorsInWindow=true;
	CreateMapFile=false;

	// Note: Any new switches added here must not begin with an 'f', due to a quick
	// hack added to make qcomp support the -f switch so as to be consistent with
	// other utilities.
	if (strstr(lpCmdLine,"-nolinenumbers"))		IncludeLineNumbers=false;
	if (strstr(lpCmdLine,"-textfile"))			CreateTextFile=true;
	if (strstr(lpCmdLine,"-slickedit"))			CreateSlickEditErrorMessages=true;
	if (strstr(lpCmdLine,"-motorola"))			Endianness=MOTOROLA;
	if (strstr(lpCmdLine,"-nochecksumnames"))	ChecksumNames=false;
	if (strstr(lpCmdLine,"-nomessageboxes"))	DisplayErrorsInWindow=false;
	if (strstr(lpCmdLine,"-createmap"))			CreateMapFile=true;

	// If this environment variable is set then also set the CreateMapFile option.
	if (getenv("CREATEMAP")!=NULL)
	{
		CreateMapFile=true;
	}

	bool qcomp_all=false;
	bool qcomp_update=false;
	if (strstr(lpCmdLine,"-all")) qcomp_all=true;
	if (strstr(lpCmdLine,"-update")) qcomp_update=true;

	#define MAX_COMMAND_LINE_WORDS 20
	const char *pp_words[MAX_COMMAND_LINE_WORDS];
	int num_words=0;

	char *p_ch=lpCmdLine;
	while (true)
	{
		// Skip until we hit the end of the command line or a non-white-space character,
		// ie the start of a word.
		while (*p_ch && (*p_ch==' ' || *p_ch=='\t'))
		{
			++p_ch;
		}

		if (*p_ch==0)
		{
			// Got to the end of the command line so stop.
			break;
		}

		// Must've got to a word.
		// If it is not a switch, add it to the list.
		if (*p_ch != '-' || 
			// -f's don't count as a switch, since -f is used to precede a filename
			// to make qcomp consistent with other utilities.
			(p_ch[0]=='-' && tolower(p_ch[1]=='f')))
		{
			// Add it to the list.
			Assert(num_words<MAX_COMMAND_LINE_WORDS,"Too many words on command line");
			pp_words[num_words++]=p_ch;
		}

		// Find the end of the word.
		while (*p_ch && *p_ch!=' ' && *p_ch!='\t')
		{
			++p_ch;
		}

		if (*p_ch==0)
		{
			// Got to the end of the command line so stop.
			break;
		}

		// Otherwise, terminate the string with a 0 and continue.
		*p_ch++=0;
	}

	char *p_path=getenv("PROJ_ROOT");
	Assert(p_path!=NULL,"QComp requires that the environment variable PROJ_ROOT is set.");

	// Open the log file, which will contain a list of all the q or qn files compiled.
	char p_log_file_name[MAX_LOG_FILE_CHARS+1];
	Assert(strlen(p_path)+1+strlen(LOG_FILE_SUB_PATH)<=MAX_LOG_FILE_CHARS,"Log file name too long.");
	strcpy(p_log_file_name,p_path);
	if (p_log_file_name[strlen(p_log_file_name)-1]!='\\') strcat(p_log_file_name,"\\");
	strcat(p_log_file_name,LOG_FILE_SUB_PATH);

	gpLogFile=_qcomp_fopen(p_log_file_name,"w");
	Assert(gpLogFile!=NULL,"\nCould not open qcomp.log for writing.");



	if (qcomp_all || qcomp_update)
	{
		// The -all option means to qcomp every q or qn file contained in the specified
		// directories, regardless of whether the .qb is newer.
		// Since we are making fresh qb's, we do not want to import the existing
		// qcomp.ass, so that it is made fresh too.

		// The words in pp_words are all to be treated as directories, specified relative
		// to the PROJ_ROOT path.

		// Generate a list of q and qn files.
		CStringList q_and_qn_file_names;

		for (int i=0; i<num_words; ++i)
		{
			char p_full_path[1000];
			strcpy(p_full_path,p_path);
			if (p_full_path[strlen(p_full_path)-1]!='\\')
			{
				strcat(p_full_path,"\\");
			}
			strcat(p_full_path,pp_words[i]);
			if (p_full_path[strlen(p_full_path)-1]=='\\')
			{
				p_full_path[strlen(p_full_path)-1]=0;
			}

			search_sub_dir(p_full_path,&q_and_qn_file_names);
		}

		if (qcomp_all)
		{
			// QComp everything, no matter what.
			const char *p_string=q_and_qn_file_names.GetNextString();
			while (p_string)
			{
				QComp(p_string);
				p_string=q_and_qn_file_names.GetNextString(p_string);
			}
		}
		else
		{
			// QComp just those q & qn files that need qcomp'ing, ie those
			// whose qb file is older than the source, or whose qb file does not exist.
			char qb_name[1000];
			const char *p_string=q_and_qn_file_names.GetNextString();
			while (p_string)
			{
				// Generate the qb name.
				int len=strlen(p_string);
				Assert(len<999,"q file name too long !");
				strcpy(qb_name,p_string);
				if (qb_name[len-1]=='q')
				{
					// Append a b if it has extension .q
					qb_name[len]='b';
					qb_name[len+1]=0;
				}
				else
				{
					// Otherwise it has extension .qn, so change the n to a b
					qb_name[len-1]='b';
				}

				bool need_to_compile=false;

				struct stat qb_stat_buf;
				int return_code=stat(qb_name,&qb_stat_buf);
				if (return_code==-1)
				{
					// The qb file does not exist, so we need to compile.
					need_to_compile=true;
				}
				else
				{
					Assert(return_code==0,"Unexpected return_code when running stat on qb filename");

					struct stat q_stat_buf;
					return_code=stat(p_string,&q_stat_buf);
					Assert(return_code==0,"Unexpected return_code when running stat on source filename");

					if (q_stat_buf.st_mtime>qb_stat_buf.st_mtime)
					{
						// The source file is newer than the qb, so we need to compile.
						need_to_compile=true;
					}
				}

				if (need_to_compile)
				{
					QComp(p_string);
				}

				p_string=q_and_qn_file_names.GetNextString(p_string);
			}
		}

		fclose(gpLogFile);
		gpLogFile=NULL;

		//Assert(0,"Finished!!");
		return 0;
	}

	// QComp each of the files on the command line.
	for (int i=0; i<num_words; ++i)
	{
		if (pp_words[i][0]=='-' && tolower(pp_words[i][1])=='f')
		{
			// If preceded by -f, then assume the file is in the current directory.
			// Needed by Gary for when calling qcomp from the libconv utility.
			QComp(pp_words[i]+2);
		}
		else
		{
			char p_full_path[1000];

			// Check whether pp_words[i] is already prefixed with the PROJ_ROOT path.
			const char *pA=p_path;
			const char *pB=pp_words[i];
			while (*pA && *pB)
			{
				char a=*pA; if (a>='A' && a<='Z') a=a-'A'+'a';
				char b=*pB; if (b>='A' && b<='Z') b=b-'A'+'a';
				if (a!=b) break;
				++pA;
				++pB;
			}
			#if 0
			if (*pA==0)
			{
				// pp_words[i] is already prefixed with the PROJ_ROOT path, so use it as is.
				strcpy(p_full_path,pp_words[i]);
			}
			else
			{
				// Stick the PROJ_ROOT path on the front.
				strcpy(p_full_path,p_path);
				if (p_full_path[strlen(p_full_path)-1]!='\\')
				{
					strcat(p_full_path,"\\");
				}
				strcat(p_full_path,pp_words[i]);
			}
			#else
				// use current working directory
				strcpy(p_full_path,pp_words[i]);
			#endif

			QComp(p_full_path);
		}
	}

	fclose(gpLogFile);
	gpLogFile=NULL;

	//Assert(0,"Finished!!");
	return 0;
}


void _MessageBox(const char *body, const char *title) {
	fprintf(stderr, "%s: %s\n", title, body);
}

FILE *_qcomp_fopen(const char *path, char *access) {
	char *converted = strdup(path);
	for(int i=0;i<strlen(converted);i++) {
		converted[i] = tolower(converted[i]);
		if(converted[i] == '\\') {
			converted[i] == '/';
		}
	}
	FILE *fd = fopen(converted, access);
	free((void *)converted);
	return fd;
}