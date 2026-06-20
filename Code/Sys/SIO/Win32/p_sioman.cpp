/*****************************************************************************
**																			**
**			              Neversoft Entertainment			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		SYS Library												**
**																			**
**	Module:			SYS (SYS_) 												**
**																			**
**	File name:		sioman.cpp												**
**																			**
**	Created:		05/26/2000	-	spg										**
**																			**
**	Description:	Serial IO Manager										**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

//#include <xtl.h>

#include <core/defines.h>

#include <sys/sioman.h>
#include <sys/siodev.h>
#include <sys/sio/keyboard.h>

#include <gel/module.h>
#include <gel/soundfx/soundfx.h>
#include <gel/SoundFX/SDL/p_sfx.h>
#include <gel/music/music.h>

#include <SDL.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

extern int KeyboardInit(void);
       
namespace SIO
{

/*****************************************************************************
**								  Externals									**
*****************************************************************************/


/*****************************************************************************
**								Private Types								**
*****************************************************************************/


/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

DefineSingletonClass( Manager, "Serial IO Manager" );

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/



/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/


/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

void Manager::process_devices( const Tsk::Task< Manager::DeviceList >& task )
{
	Device*					device;
	Lst::Search< Device >	    sh;
	Manager::DeviceList&	device_list = task.GetData();

	device = sh.FirstItem ( device_list );

	while ( device )
	{
		Dbg_AssertType ( device, Device );

		device->process();
		device = sh.NextItem();
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Device* Manager::create_device( int index, int port, int slot )
{
    Device *device;
        
    device = new Device( index, port, slot );

    return device;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Manager::Manager ( void )
{
    int i, index;

	//XDEVICE_PREALLOC_TYPE xdpt[] = {{ XDEVICE_TYPE_GAMEPAD,			4 },
	//								{ XDEVICE_TYPE_MEMORY_UNIT,		1 }};
    //
	//// Initialize the peripherals.
	//XInitDevices( sizeof( xdpt ) / sizeof( XDEVICE_PREALLOC_TYPE ), xdpt );

	// Create the keyboard queue.
//	XInputDebugInitKeyboardQueue( &xdkp );

    // Enable HIDAPI rumble for Sony pads. SDL talks to a DualSense/DualShock 4 directly via HIDAPI,
    // but rumble on those pads needs the "extended input report" mode, which SDL leaves OFF by
    // default (it can interfere with non-SDL DirectInput apps). Without these, a DualSense reports
    // its buttons/sticks fine but SDL_GameControllerRumble() is a silent no-op (notably over
    // Bluetooth). Hints must be set before SDL_Init / before the controller is opened.
    SDL_SetHint( SDL_HINT_JOYSTICK_HIDAPI,            "1" );	// HIDAPI drivers on (default, but be explicit)
    SDL_SetHint( SDL_HINT_JOYSTICK_HIDAPI_PS5,        "1" );	// DualSense driver
    SDL_SetHint( SDL_HINT_JOYSTICK_HIDAPI_PS5_RUMBLE, "1" );	// extended reports -> DualSense rumble
    SDL_SetHint( SDL_HINT_JOYSTICK_HIDAPI_PS4,        "1" );	// DualShock 4 driver
    SDL_SetHint( SDL_HINT_JOYSTICK_HIDAPI_PS4_RUMBLE, "1" );	// extended reports -> DualShock 4 rumble

    Dbg_Assert(SDL_Init(SDL_INIT_VIDEO | SDL_INIT_JOYSTICK | SDL_INIT_GAMECONTROLLER | SDL_INIT_AUDIO) >= 0); // the INIT_VIDEO is needed....

    for (int i = 0; i < SDL_NumJoysticks(); i++)
    {
        if (SDL_IsGameController(i))
        {
            printf("Available GameController %s on Slot %d\n", SDL_GameControllerNameForIndex(i), i);
        }
    }

    m_process_devices_task = new Tsk::Task< DeviceList > ( Manager::process_devices, m_devices );
    
	// Pause briefly here to give the system time to enumerate the attached devices.
	Sleep( 1000 );

    index = 0;
    for( i = 0; i < SIO::vMAX_PORT; i++ )
    {
	    Device* p_device;

		if(( p_device = create_device( index, i, 0 )))
		{
			m_devices.AddToTail( p_device->m_node );
			p_device->Acquire();
			index++;
		}
    }
    
	if( !Pcm::NoMusicPlease())
	{
		Pcm::Init();
	}

	Dbg_Message( "Initialized Controller lib\n" );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Manager::~Manager( void )
{
    Device*					device;
    Device*					next;
    Lst::Search< Device >	sh;
    
    device = sh.FirstItem ( m_devices );
    
    while ( device )
    {
        Dbg_AssertType ( device, Device );
    
        next = sh.NextItem();
    
        delete device;
        device = next;
    }

    delete m_process_devices_task;

#	if KEYBOARD_ON
	// Initialize the keyboard.
	KeyboardDeinit();
#	endif

    SDL_Quit();

	Dbg_Message( "Shut down IOP Controller Lib\n" );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
//void Manager::ProcessDevices( void )
//{
//	Device*					device;
//	Lst::Search< Device >	sh;
//	Manager::DeviceList&	device_list = m_devices;
//
//	device = sh.FirstItem( device_list );
//
//	while( device )
//	{
//		Dbg_AssertType ( device, Device );
//
//		device->process();
//		device = sh.NextItem();
//	}
//}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Device* Manager::GetDevice( int port, int slot )
{
    Device*					device;
    Lst::Search< Device >	sh;
    
    device = sh.FirstItem ( m_devices );
    
    for( device = sh.FirstItem ( m_devices ); device;
            device = sh.NextItem ())
    {
        if( ( device->GetPort() == port ) &&
            ( device->GetSlot() == slot ))
        {
            return device;
        }
    }
    
    return NULL;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Device* Manager::GetDeviceByIndex( int index )
{
    Device*					device;
    Lst::Search< Device >	sh;
    
    device = sh.FirstItem ( m_devices );
    
    for( device = sh.FirstItem ( m_devices ); device;
            device = sh.NextItem ())
    {
        if( device->GetIndex() == index )
        {
            return device;
        }
    }
    
    return NULL;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void Manager::Pause()
{
    Device*					device;
    Lst::Search< Device >	sh;
    
    for( device = sh.FirstItem( m_devices ); device; device = sh.NextItem())
    {
		device->Pause();
    }
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void Manager::UnPause( void )
{
    Device*					device;
    Lst::Search< Device >	sh;
    
    for( device = sh.FirstItem( m_devices ); device; device = sh.NextItem())
    {
		device->UnPause();
    }
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace SIO
