//****************************************************************************
//* MODULE:         Tools/MakePRE
//* FILENAME:       MakePRE.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  ???
//****************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <fstream>
#include <stddef.h>

#include <sys/stat.h>

#include <Core/Defines.h>

#include "../GenLib/Utility.h"
#include "../GenLib/VirtualFile.h"

using namespace std;

#define OUT_BUFFER_SIZE			12000000
#define COMPRESS_BUFFER_SIZE	16000000

#define IDEAL_COMPRESSION_LIMIT	.85f

#define vMAJOR_REV 2
#define vMINOR_REV 0
#define vCURRENT_VERSION		0xabcd0003 //( (vMAJOR_REV << 16) | (vMINOR_REV) )

#define MAXFILES			4096
#define _MAX_PATH 4096

int platform = Utils::vPLATFORM_PS2;

extern int Encode(char *pIn, char *pOut, int bytes_to_read, bool print_progress);
int NonCompressedBytes;
int CompressedBytes;

char DirFileName[_MAX_PATH];
char PreFileName[_MAX_PATH];



/*****************************************************************************
**								 Private Data								**
*****************************************************************************/
static uint32 CRCTable[256] = // CRC polynomial 0xedb88320
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



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
uint32 GenerateCRCFromString( const char *pName )
{
	
    // A checksum of zero is used to mean no name.
    if (!pName) 
	{
		return 0;
	}	

    // Initializing the CRC to all one bits avoids failure of detection
	// should entire data stream get cyclically bit-shifted by one position.
	// The calculation of the probability of this happening is left as
	// an exercise for the reader.
	uint32 rc = 0xffffffff;
	const char *pCh=pName;
    while (true)
    {
        char ch=*pCh++;
		if (!ch)
		{
			break;
		}
			
        // Convert to lower case.
        if (ch>='A' && ch<='Z') 
		{
			ch='a'+ch-'A';
		}	
		// Convert forward slashes to backslashes, otherwise two filenames which are
		// effectively the same but with different slashes will give different checksums.
		if (ch=='/')
		{
			ch='\\';
		}	
		
        rc = CRCTable[(rc^ch) & 0xff] ^ ((rc>>8) & 0x00ffffff);
    }

	return rc;
}





void TestAligned(void *ptr, char *pMessage)
{
	if ((ptrdiff_t) ptr & 3)
	{
		printf("BAD ALIGNMENT: ");
		printf(pMessage);
		printf("\n");
		exit(1);
	}
}

struct _SourceFileInfo
{
	// File name buffer.
	char			FullFileName[_MAX_PATH+1];
	// with 'c:\skate3\data\' stripped off
	char			RelativeFileName[_MAX_PATH+1];
	unsigned int	SourceFileSize;
	bool			Fresh;
	bool			NewToList;
};


struct _PreHeader
{
	int		size;
	int		version;
	int		numFiles;
	char	data[1];
};


struct _PreContained
{
	int		dataSize;
	int		compressedSize;
	int		nameSize;
	int 	checksum;	// Mick: added this as we generally search for files by checksum
	char	name[1];
};


bool				PreFileChanged;	
_SourceFileInfo		SourceInfo[MAXFILES];
int					NumSourceFiles;

char *				pPreBuf=NULL;
_PreHeader *		pPreHead;
int					NumFilesInPre;

char				CompressBuffer[COMPRESS_BUFFER_SIZE];

enum EEndianChangeDirection
{
	TO_GAMECUBE,
	FROM_GAMECUBE
};

void ChangePreEndianness(EEndianChangeDirection dir);
char *ChangeContainedFileEndianness(char *p_contained_header, EEndianChangeDirection dir);
uint32 ChangeEndianness4(uint32 v);
uint16 ChangeEndianness2(uint16 v);

// Ken addition: This will parse through pPreBuf changing the endianness, but
// will leave the contained files as they were.
// This is for the GameCube.
void ChangePreEndianness(EEndianChangeDirection dir)
{
	Utils::Assert(pPreBuf!=NULL,"NULL pPreBuf ?");
	_PreHeader *p_pre_header=(_PreHeader*)pPreBuf;

	if (dir==FROM_GAMECUBE)
	{
		p_pre_header->numFiles=ChangeEndianness4(p_pre_header->numFiles);
		p_pre_header->size=ChangeEndianness4(p_pre_header->size);
		p_pre_header->version=ChangeEndianness4(p_pre_header->version);
	}

	int num_files=p_pre_header->numFiles;
	char *p_contained=p_pre_header->data;

	if (dir==TO_GAMECUBE)
	{
		p_pre_header->numFiles=ChangeEndianness4(p_pre_header->numFiles);
		p_pre_header->size=ChangeEndianness4(p_pre_header->size);
		p_pre_header->version=ChangeEndianness4(p_pre_header->version);
	}

	for (int i=0; i<num_files; ++i)
	{
		p_contained=ChangeContainedFileEndianness(p_contained,dir);
	}
}

// Changes the endianness of the passed contained file, and returns a pointer to the next one.
char *ChangeContainedFileEndianness(char *p_contained_header, EEndianChangeDirection dir)
{
	_PreContained *p_contained=(_PreContained*)p_contained_header;

	if (dir==FROM_GAMECUBE)
	{
		p_contained->compressedSize=ChangeEndianness4(p_contained->compressedSize);
		p_contained->dataSize=ChangeEndianness4(p_contained->dataSize);
		p_contained->nameSize=((uint32)ChangeEndianness2(p_contained->nameSize>>16) << 16) |
							   ChangeEndianness2(p_contained->nameSize);
		p_contained->checksum=ChangeEndianness4(p_contained->checksum);
	}

	int size=p_contained->compressedSize ? p_contained->compressedSize:p_contained->dataSize;
	size=(size+3)&~3;
	char *p_next=p_contained->name+p_contained->nameSize+size;

	if (dir==TO_GAMECUBE)
	{
		p_contained->compressedSize=ChangeEndianness4(p_contained->compressedSize);
		p_contained->dataSize=ChangeEndianness4(p_contained->dataSize);
		p_contained->nameSize=((uint32)ChangeEndianness2(p_contained->nameSize>>16) << 16) |
							   ChangeEndianness2(p_contained->nameSize);
		p_contained->checksum=ChangeEndianness4(p_contained->checksum);
	}

	return p_next;
}

uint32 ChangeEndianness4(uint32 v)
{
	return	(((v>>0)&0xff)<<24) |
			(((v>>8)&0xff)<<16) |
			(((v>>16)&0xff)<<8) |
			(((v>>24)&0xff)<<0);
}

uint16 ChangeEndianness2(uint16 v)
{
	return	(((v>>0)&0xff)<<8) |
			(((v>>8)&0xff)<<0);
}

char s_char_buffer[OUT_BUFFER_SIZE];

void MakeEmptyPre()
{
	pPreBuf = &s_char_buffer[0];//new char[OUT_BUFFER_SIZE];
	pPreHead = (_PreHeader *) pPreBuf;
	pPreHead->numFiles = 0;
}



void LoadPre()
{
	pPreBuf = &s_char_buffer[0];//new char[OUT_BUFFER_SIZE];
	pPreHead = (_PreHeader *) pPreBuf;

	fstream pre(PreFileName, ios::in | ios::binary);
	pre.read(pPreBuf, OUT_BUFFER_SIZE);
	pre.close();

	if (platform == Utils::vPLATFORM_NGC)
	{
		ChangePreEndianness(FROM_GAMECUBE);
	}

	if (pPreHead->version != vCURRENT_VERSION)
	{
//		delete[] pPreBuf;
		MakeEmptyPre();
	}
}



void PossibleUpdateMessage()
{
	static bool did_update = false;

	if (!did_update)
	{
		printf("\nMakePRE version %s\n", __DATE__);
		printf("Updating PRE file %s...\n", PreFileName);
		did_update = true;
	}
}



// A file will be considered outdated if not in the source list, or if there is a newer version
bool IsFileOutdated(char *filename, int &index)
{
	bool outdated = true;

	// replace the backslashes
	uint32 c1 = GenerateCRCFromString( filename );

	for (int i = 0; i < NumSourceFiles; i++)
	{
		uint32 c2 = GenerateCRCFromString( SourceInfo[i].RelativeFileName );
	
		if ( ( c1 == c2 ) && !SourceInfo[i].Fresh)
		{
			outdated = false;
			index = i;
			break;
		}
	}

	return outdated;
}



// removes outdated files and shifts the remaining ones down in memory
char* RemoveOutdatedFiles()
{	
	int num_files = pPreHead->numFiles;
	NumFilesInPre = num_files;
	char *pData = pPreHead->data;

	char *pCopyTo = NULL;
	
	for (int i = 0; i < num_files; i++)
	{
		_PreContained *pFile = (_PreContained *) pData;
		// size of contained file
		int contained_size = (pFile->compressedSize != 0) ? pFile->compressedSize : pFile->dataSize;
		// size of entire _PreContained struct
		int size = (contained_size + pFile->nameSize + 16 + 3) & ~3; 
		
		int index_of_preserved;

		// should we remove file?
		if (IsFileOutdated(pFile->name, index_of_preserved))
		{
			NumFilesInPre--;
			if (!pCopyTo) 
			{
				pCopyTo = pData;
				PossibleUpdateMessage();
			}
			PreFileChanged = true;
			printf("Removing file: %s\n", pFile->name);
		}
		// if file was not removed, but a previous one was, copy it backwards in memory
		else if (pCopyTo)
		{
			// confirms that file was not added to source list since PRE was last built
			SourceInfo[index_of_preserved].NewToList = false;
			
			// update stats, for user info only
			CompressedBytes += contained_size;
			NonCompressedBytes += pFile->dataSize;

			memmove(pCopyTo, pData, size);
			pCopyTo += size;
		}
		// if file was not removed and not copied, still update stats
		else
		{
			// confirms that file was not added to source list since PRE was last built
			SourceInfo[index_of_preserved].NewToList = false;
			
			// update stats, for user info only
			CompressedBytes += contained_size;
			NonCompressedBytes += pFile->dataSize;
		}
		
		pData += size;
		TestAligned(pData, "RemoveOutDatedFiles(), pData");
		TestAligned(pCopyTo, "RemoveOutDatedFiles(), pCopyTo");
	}

	if (pCopyTo) return pCopyTo;
	return pData;
}



int AddFreshFiles(char *pWriteTo)
{
	for (int i = 0; i < NumSourceFiles; i++)
	{
		if (SourceInfo[i].Fresh || SourceInfo[i].NewToList)
		{
			Utils::Assert((ptrdiff_t) pWriteTo - (ptrdiff_t) pPreBuf + SourceInfo[i].SourceFileSize + 256 < OUT_BUFFER_SIZE, 
				"overflowed output buffer");
			
			PreFileChanged = true;

			// set up name stuff
			_PreContained *pFile = (_PreContained *) pWriteTo;
			pFile->nameSize = (strlen(SourceInfo[i].RelativeFileName) + 4) & ~3;
			memcpy(pFile->name, SourceInfo[i].RelativeFileName, pFile->nameSize);

			// add the checksum for fast searching
			pFile->checksum = GenerateCRCFromString( SourceInfo[i].RelativeFileName );

			// load up source file, read into compression buffer
			ifstream in(SourceInfo[i].FullFileName, ios::in | ios::binary);
			pFile->dataSize = SourceInfo[i].SourceFileSize;
			in.read(CompressBuffer, pFile->dataSize);
			in.close();
		
			// DO COMPRESSION HERE
			char *data = pFile->name + pFile->nameSize;
			pFile->compressedSize = Encode(CompressBuffer, data, pFile->dataSize, false);
			int padded_file_length;
			
			// Hack, don't compress .COL files for now, as they go in a since .PRE
			// KEN: Temporarily switched off all compression to test my pip stuff.
			// Change to hack_allow_compress = true; to switch it back on.
			bool hack_allow_compress = true; 

			// Ken: Now col files are compressed, hoorah!
			//if (stricmp(SourceInfo[i].FullFileName + strlen(SourceInfo[i].FullFileName) - 7, "col.ps2") == 0)
			//{
			//	//printf("Aaaaarrrrrrrggggg!!!!!!!\n");
			//	hack_allow_compress = false;
			//}

			// is compressed version small enough to keep?
			float compression_ratio = (float) pFile->compressedSize / pFile->dataSize;
			if (compression_ratio <= IDEAL_COMPRESSION_LIMIT && hack_allow_compress)
			{
				// add 32-bit padding
				padded_file_length = (pFile->compressedSize + 3) & (~3);
				// information for user
				CompressedBytes += pFile->compressedSize;
				printf("   Adding %s, size %d [COMPRESSED %.2f]\n", SourceInfo[i].RelativeFileName, pFile->compressedSize, compression_ratio);
			}
			else
			{
				// compressed version not small enough, used uncompressed version
				memcpy(data, CompressBuffer, pFile->dataSize); 
				// add 32-bit padding
				padded_file_length = (pFile->dataSize + 3) & (~3);
				// information for user
				CompressedBytes += pFile->dataSize;
				printf("   Adding %s, size %d (comp %d, %f)\n", SourceInfo[i].RelativeFileName, pFile->dataSize,pFile->compressedSize,compression_ratio);
				pFile->compressedSize = 0;
			}
			
			NonCompressedBytes += pFile->dataSize;
			pWriteTo += 16 + pFile->nameSize + padded_file_length;
			TestAligned(pWriteTo, "AddFreshFiles(), pWriteTo");
			NumFilesInPre++;
		}
	}

	pPreHead->numFiles = NumFilesInPre;
	pPreHead->size = (ptrdiff_t) pWriteTo - (ptrdiff_t) pPreBuf;
	pPreHead->version = vCURRENT_VERSION;

	return pPreHead->size;
}



void WritePreFile(int size)
{
	if (platform == Utils::vPLATFORM_NGC)
	{
		ChangePreEndianness(TO_GAMECUBE);
	}

	fstream pre(PreFileName, ios::out | ios::binary);
	pre.write(pPreBuf, size);
	pre.close();

	printf("Sucessfully wrote PRE file: %s\n", PreFileName);
	printf("%d bytes of source data compressed to %d bytes, ratio of %.3f\n", 
		NonCompressedBytes, CompressedBytes, (double) CompressedBytes / NonCompressedBytes);
}

int run_utility( const char* proj_path, const char* pAssetListName, const char* pTargetPreName )
{
	////////////////////////////////////////////////////////////////////////////////

	char DataPathName[_MAX_PATH+1];
	strcpy(DataPathName, proj_path);
	strcat(DataPathName, "\\data\\");

	/*****************************************************

		Open directory file
	
	******************************************************/
	
	strcpy(DirFileName,pAssetListName);

	FILE *listifp=fopen(DirFileName,"r");
	Utils::Assert(listifp!=NULL,"Could not open %s.\n", DirFileName);

	/*****************************************************

		See if PRE file exists and fetch date stamp
	
	******************************************************/
	
	strcpy(PreFileName, proj_path);
	strcat(PreFileName, "\\data\\pre\\");
	strcat(PreFileName, pTargetPreName );
	
	bool new_pre = false;
	struct stat PreStatBuf;
	int ReturnCode=stat(PreFileName, &PreStatBuf);

	if (ReturnCode==-1)
	{
		// PRE doesn't exist
		new_pre = true;
	}
	else
	{
		Utils::Assert(ReturnCode==0,"Unexpected ReturnCode when running stat on PRE filename");
	}
	
	/*****************************************************

		Scan through all source files date stamps to see if a rebuild is needed
	
	******************************************************/
	
	// just used for printfs
	PreFileChanged = false;
	NumSourceFiles = 0;

	int j;
	
	// Check each of the files listed.
	for (j = 0;; j++)
    {
		Utils::Assert(j < MAXFILES, "too many source files");
		
		// Make sure it is terminated in case the "too many chars" Utils::Assert goes off.
        SourceInfo[j].FullFileName[_MAX_PATH]=0;

		char msg[_MAX_PATH];

        // Load each character into the buffer until end-of-line or end-of-file.
        int i=0;
        while ( true )
        {
            Utils::Assert(i<=_MAX_PATH,"Too many chars in filename.");
			char ch=fgetc(listifp);

            // Check if end-of-file or end-of-line.
            if (ch==EOF || ch=='\n')
            {
                // Terminate the current string.
                msg[i]=0;
                break;
            }

			msg[i]=ch;
            ++i;
        }

		SourceInfo[j].FullFileName[0] = 0;
		strcpy( SourceInfo[j].FullFileName, msg );

//		char suppressCode[_MAX_PATH];
//		bool needsUpdating = false;
//		bool suppressTimeCheckFound = false;
//		if ( sscanf( msg, "%s %s", &SourceInfo[j].FullFileName, &suppressCode ) == 2 )
//		{
//			needsUpdating = ( suppressCode[0] == '1' );
//			suppressTimeCheckFound = true;
//		};

        // if we have the name of a source file
		if (SourceInfo[j].FullFileName[0])
		{
			//Utils::Assert(j < 255, "too many files to fit in PRE");
		
			strcpy(SourceInfo[j].RelativeFileName, SourceInfo[j].FullFileName + strlen(DataPathName));
			
			uint32 c1 = GenerateCRCFromString(SourceInfo[j].RelativeFileName);
	
			bool file_already_in = false;
			// Make sure file not in list twice
			for (int x = 0; x < j; x++)
			{
				uint32 c2 = GenerateCRCFromString(SourceInfo[x].RelativeFileName);
				
				if ( c1 == c2 )
				{
					file_already_in = true;
					break;
				}
			}
			
			if (file_already_in)
				j--; // reuse this slot
			else
			{
				//printf("   %s --> %s\n", SourceInfo[j].FullFileName, SourceInfo[j].RelativeFileName);
				
				/*
					See if PRE file exists. Then for each source file, check:
						-If it exists (if no, error)
						-If it's in the PRE file. If not, then automatic rebuild of it and all
						 subsequent members in PRE file.
						-If it's date is the same or older compared to PRE file's. If not, same
						 step as above.
				*/
				
				SourceInfo[j].Fresh = false;

//				if ( suppressTimeCheckFound )
//				{
//					SourceInfo[j].Fresh = needsUpdating;
//				}
//				else
				{
					struct stat SourceStatBuf;
					ReturnCode=stat(SourceInfo[j].FullFileName, &SourceStatBuf);
					Utils::Assert(ReturnCode != -1, "source file %s doesn't exist", SourceInfo[j].FullFileName);
					Utils::Assert(ReturnCode==0,"Unexpected ReturnCode when running stat on source filename");

					SourceInfo[j].SourceFileSize = SourceStatBuf.st_size;
					Utils::Assert(SourceInfo[j].SourceFileSize > 0 && SourceInfo[j].SourceFileSize <= COMPRESS_BUFFER_SIZE, 
						"unlikely file size %d for %s\n", SourceInfo[j].SourceFileSize, SourceInfo[j].FullFileName);
					//printf("size %d for file %s\n", SourceInfo[j].SourceFileSize, SourceInfo[j].FullFileName);

					// true if source file is newer than PRE or if PRE doesn't exist
					SourceInfo[j].Fresh = (new_pre || SourceStatBuf.st_mtime > PreStatBuf.st_mtime);
				}
				// will later be set false if proven not true
				SourceInfo[j].NewToList = true;
				if (SourceInfo[j].Fresh) PreFileChanged = true;
			}
		}
        // if we've reached the end of the file list
		else
            break;
    }
	NumSourceFiles = j;
	//Utils::Assert(NumSourceFiles, "no source files");
	
	fclose (listifp);

	if (new_pre)
	{
		printf("\nMakePRE version %s\n", __DATE__);
		printf("Building new PRE file %s...\n", PreFileName);
		MakeEmptyPre();
	}
	else
	{
		if (PreFileChanged)
			PossibleUpdateMessage();
		LoadPre();
	}
	
	CompressedBytes = 0;
	NonCompressedBytes = 0;
	
	char *pEnd = RemoveOutdatedFiles();
	int size = AddFreshFiles(pEnd);
	if (PreFileChanged)
		WritePreFile(size);
	
	return 0;
}

int main(int argc, char* argv[])
{
	// check that the project was defined
	char* proj_path = getenv( "PROJ_ROOT" );
	if( proj_path == NULL )
	{		
		printf( "You must first define your PROJ_ROOT environment variable\n" );
		exit(1);
	}

	if (argc < 3)
	{
		printf("\n");
		printf("MakePRE.exe, %s\n",__DATE__);
		printf("Parameter 1: project path\n");
		printf("Parameter 2: name of PRE file\n");
		printf("Parameter 3: file containing list of source files [OPTIONAL]\n");
		printf("Parameter (any): (optional) -p<platform> where x = Xbox, g = Gamecube, p = PS2\n(default is PS2)\n\n");

		printf("It will open <project path>\\bin\\win32\\makepre.txt and put all listed files\n");
		printf("into a PRE file named in <output path>\n");
		printf("makepre.txt is just a directory listing generated by a 'dir /b' command.\n\n");
		exit(1);
	}

	char* p_batch_name = NULL;
	bool batch_mode = false;

	// Ken addition: If a '-p' flag is anywhere in the arg list, set the appropriate platform
	// then remove the flag from the arg list.
	for (int i=1; i<argc; ++i)
	{
		if(( argv[i][0] == '-' ) && ( argv[i][1] == 'p' ))
		{
			if( argv[i][2] == 'x' )
			{
				platform = Utils::vPLATFORM_XBOX;
				printf("Switching to Xbox platform\n");
			}
			else if( argv[i][2] == 'g' )
			{
				platform = Utils::vPLATFORM_NGC;
				printf("Switching to Gamecube platform\n");
			}

			// Now remove the flag from the arg list so that I don't have
			// to change any of the original arg list parsing below.
			for (int j=i+1; j<argc; ++j)
			{
				argv[j-1]=argv[j];
			}
			--argc;
		}

		// batch mode
		if(( argv[i][0] == '-' ) && ( argv[i][1] == 'b' ))
		{
			batch_mode = true;
			p_batch_name = argv[i] + 2;

			// Now remove the flag from the arg list so that I don't have
			// to change any of the original arg list parsing below.
			for (int j=i+1; j<argc; ++j)
			{
				argv[j-1]=argv[j];
			}
			--argc;
		}
	}

	Utils::Assert(argc <= 4,"Too many arguments.");

	if ( batch_mode )
	{
		char* pBatchFileName = p_batch_name;

		fstream batchStream( pBatchFileName, ios::in );
		if ( !batchStream.is_open() )
		{
			printf( "Error!  Could not open %s\n", pBatchFileName );
			batchStream.close();
			exit(1);
		}
		printf( "MakePre:  Running batch mode on %s\n", p_batch_name );

		while ( !batchStream.eof() )
		{
			char lineBuf[_MAX_PATH];
			batchStream.getline( &lineBuf[0], _MAX_PATH );
			if ( batchStream.eof() )
			{
				break;
			}

			char tBuf1[_MAX_PATH];
			char tBuf2[_MAX_PATH];

			sscanf( lineBuf, "%s %s", &tBuf1[0], &tBuf2[0] );

			char AssetListName[_MAX_PATH];
			strcpy( AssetListName, proj_path );
			strcat(AssetListName,"\\");
			strcat(AssetListName, tBuf2);
	
//			printf( "Running batch mode on %s %s\n", AssetListName, tBuf1 );
			run_utility( proj_path, AssetListName, tBuf1 );
		}

		batchStream.close();
	}
	else
	{
		char AssetListName[_MAX_PATH];
		strcpy( AssetListName, proj_path );
		if (argc == 4)
		{
			strcat(AssetListName,"\\");
			strcat(AssetListName, argv[3]);
		}
		else
		{
			strcat(AssetListName,"\\bin\\win32\\makepre.txt");
		}
	
		run_utility( proj_path, AssetListName, argv[2] );
	}

	return 0;
}
