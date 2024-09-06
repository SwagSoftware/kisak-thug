/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 2002 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Skate4													**
**																			**
**	Module:			GameNet			 										**
**																			**
**	File name:		p_buddy.h												**
**																			**
**	Created by:		02/28/02	-	SPG										**
**																			**
**	Description:	XBox Buddy List Code 									**
**																			**
*****************************************************************************/

#ifndef __GAMENET_XBOX_P_BUDDY_H
#define __GAMENET_XBOX_P_BUDDY_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

// LWSS: This was gimped from Xbox before release, it's just placeholder so it compiles

#include <core/defines.h>
#include <core/dynamictable.h>
//#include <Xbox.h>
//#include <XOnline.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

//LWSS: Taken from XBox XDK
#define XONLINE_GAMERTAG_SIZE                   16
#define XONLINE_MAX_GAMERTAG_LENGTH             (XONLINE_GAMERTAG_SIZE - 1)
#define XONLINE_PASSCODE_LENGTH                  4
#define XONLINE_MAX_LOGON_USERS                  4
#define XONLINE_USER_RESERVED_SIZE              72
#define XONLINE_MAX_STORED_ONLINE_USERS         16
#define MAX_FRIENDS         100
#define MAX_STATEDATA_SIZE  32
#define MAX_USERDATA_SIZE   0
typedef struct {
	ULONGLONG qwUserID;
	DWORD dwUserFlags;
} XUID;
typedef struct {
	XUID xuid;
	CHAR szGamertag[XONLINE_GAMERTAG_SIZE];
	DWORD dwUserOptions;
	BYTE passcode[XONLINE_PASSCODE_LENGTH];
	BYTE reserved[XONLINE_USER_RESERVED_SIZE];
	HRESULT hr;
} XONLINE_USER, * PXONLINE_USER;

typedef struct {
	BYTE ab[8];
} XNKID;
typedef struct {
	XUID xuid;
	CHAR szGamertag[XONLINE_GAMERTAG_SIZE];
	DWORD dwFriendState;
	FILETIME gameinviteTime;
	XNKID sessionID;
	DWORD dwTitleID;
	BYTE StateDataSize;
	BYTE StateData[MAX_STATEDATA_SIZE];
	BYTE bReserved;
} XONLINE_FRIEND, * PXONLINE_FRIEND;

enum
{
	vSTATE_FILL_BUDDY_LIST,
	vSTATE_UPDATE,
	vSTATE_SUCCESS,
	vSTATE_CANCEL,
	vSTATE_ERROR,
	vSTATE_WAIT,
};

namespace GameNet
{

class BuddyMan
{
public:
	BuddyMan( void );

	void	SpawnBuddyList( int user_index );

//private:

	void	update_buddy_list( void );
	void	fill_buddy_list( void );

	int		m_current_user;
	int		m_num_friends;
	int		m_state;
	int		m_next_state;
	//XONLINETASK_HANDLE	mh_friends_task;
	//XONLINETASK_HANDLE	mh_friends_enum_task;
	Lst::DynamicTable< XONLINE_USER > m_potential_friends_list;
	Lst::DynamicTable< XONLINE_FRIEND > m_friends_list;
	//
	//static	Tsk::Task< BuddyMan >::Code  s_buddy_state_code; 
	//Tsk::Task< BuddyMan >*		mp_buddy_state_task;
};


/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/

/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace GameNet

#endif	// __GAMENET_XBOX_P_BUDDY_H


