// GameCube Only scripts.

allow_dvd_errors = 1

                                   
                                   
                                   
script ngc_dvd_fatal_f
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Une erreur est survenue." y=128 scale=1.0
    ngc_message font="newtrickfont" text="Eteignez la console et" scale=1.0
    ngc_message font="newtrickfont" text="référez-vous au" scale=1.0
    ngc_message font="newtrickfont" text="manuel d'instructions" scale=1.0
    ngc_message font="newtrickfont" text="Nintendo GameCube  pour" scale=1.0
    ngc_message font="newtrickfont" text="de plus amples informations." scale=1.0
    ngc_message font="newtrickfont" text="TM" x=418 y=230 scale=0.5
endscript

script ngc_dvd_retry_f
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="La lecture du disque a échoué." y=128 scale=1.0
    ngc_message font="newtrickfont" text="Veuillez vous référer au manuel" scale=1.0
    ngc_message font="newtrickfont" text="d'instructions Nintendo GameCube " scale=1.0
    ngc_message font="newtrickfont" text="pur de plus amples informations." scale=1.0
    ngc_message font="newtrickfont" text="TM" x=566 y=178 scale=0.5
endscript

script ngc_dvd_cover_open_f
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Le couvercle est ouvert." y=160 scale=1.0
    ngc_message font="newtrickfont" text="Pour continuer à jouer," scale=1.0
    ngc_message font="newtrickfont" text="veuillez fermer le couvercle." scale=1.0
endscript
             
script ngc_dvd_no_disk_f
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Veuillez insérer le disque" y=160 scale=1.0
    ngc_message font="newtrickfont" text="Tony Hawk's Underground." scale=1.0
endscript
             





script ngc_dvd_fatal_d
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Ein Fehler ist aufgetreten." y=128 scale=1.0
    ngc_message font="newtrickfont" text="Bitte schalten Sie den" scale=1.0
    ngc_message font="newtrickfont" text="Nintendo GameCube  aus und" scale=1.0
    ngc_message font="newtrickfont" text="lesen Sie die Bedienungsanleitung," scale=1.0
    ngc_message font="newtrickfont" text="Bedienungsanleitung, um weitere" scale=1.0
    ngc_message font="newtrickfont" text="Informationen zu erhalten." scale=1.0
    ngc_message font="newtrickfont" text="TM" x=394 y=178 scale=0.5
endscript
             
script ngc_dvd_retry_d
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Diese Game Disc kann nicht" y=128 scale=1.0
    ngc_message font="newtrickfont" text="gelesen werden." scale=1.0
    ngc_message font="newtrickfont" text="Bitte lesen Sie die" scale=1.0
    ngc_message font="newtrickfont" text="Bedienungsanleitung des" scale=1.0
    ngc_message font="newtrickfont" text="Nintendo GameCube  um weitere" scale=1.0
    ngc_message font="newtrickfont" text="Informationen zu erhalten." scale=1.0
    ngc_message font="newtrickfont" text="TM" x=370 y=230 scale=0.5
endscript
                                   
script ngc_dvd_cover_open_d
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Der Disc-Deckel ist geöffnet." y=160 scale=1.0
    ngc_message font="newtrickfont" text="Bitte den Disc-Deckel schließen," scale=1.0
    ngc_message font="newtrickfont" text="um mit dem Spiel fortzufahren." scale=1.0
endscript
             
script ngc_dvd_no_disk_d
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Bitte legen Sie die" y=160 scale=1.0
    ngc_message font="newtrickfont" text="Tony Hawk's Underground-Disc ein." scale=1.0
endscript




             
script ngc_dvd_fatal_e
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="title" text="An error has occurred" y=128 scale=1.3
    ngc_message font="small" text="." scale=1.3 appendx=0 appendy=-5.5
    ngc_message font="title" text="Turn the power off and refer to" scale=1.3
    ngc_message font="title" text="the Nintendo GameCube  Instruction" scale=1.3
    ngc_message font="title" text="Booklet for further instructions" scale=1.3
    ngc_message font="small" text="." scale=1.3 appendx=0 appendy=-5.5
    ngc_message font="title" text="TM" x=390 y=176 scale=0.5
endscript
             
script ngc_dvd_retry_e
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="title" text="The Game Disc could not be read" y=128 scale=1.3
    ngc_message font="small" text="." scale=1.3 appendx=0 appendy=-5.5
    ngc_message font="title" text="Please read the Nintendo GameCube" scale=1.3
    ngc_message font="title" text="Instruction Booklet for" scale=1.3
    ngc_message font="title" text="more information" scale=1.3
    ngc_message font="small" text="." scale=1.3 appendx=0 appendy=-5.5
    ngc_message font="title" text="TM" x=544 y=152 scale=0.5
endscript
             
script ngc_dvd_cover_open_e
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="title" text="The Disc Cover is open" y=160 scale=1.3
    ngc_message font="small" text="." scale=1.3 appendx=0 appendy=-5.5
    ngc_message font="title" text="If you want to continue the game" scale=1.3
    ngc_message font="small" text="," scale=1.3 appendx=0 appendy=-5.5
    ngc_message font="title" text="please close the Disc Cover" scale=1.3
    ngc_message font="small" text="." scale=1.3 appendx=0 appendy=-5.5
endscript
             
script ngc_dvd_no_disk_e
    ngc_bgcolor r=64 g=0 b=0 a=255
    ngc_message font="title" text="Please insert the" y=160 scale=1.3
    ngc_message font="title" text="Tony Hawk s Underground" scale=1.3
    ngc_message font="title" text="Game Disc" scale=1.3
    ngc_message font="small" text="." scale=1.3 appendx=0 appendy=-5.5
    ngc_message font="small" text="'" scale=1.3 x=297 y=176
endscript



             
script ngc_dvd_fatal
    if french
        ngc_dvd_fatal_f
    else
        if german
            ngc_dvd_fatal_d
        else
            ngc_dvd_fatal_e
        endif
    endif
endscript
             
script ngc_dvd_retry
    if french
        ngc_dvd_retry_f
    else
        if german
            ngc_dvd_retry_d
        else
            ngc_dvd_retry_e
        endif
    endif
endscript
             
script ngc_dvd_cover_open
    if french
        ngc_dvd_cover_open_f
    else
        if german
            ngc_dvd_cover_open_d
        else
            ngc_dvd_cover_open_e
        endif
    endif
endscript
             
script ngc_dvd_no_disk
    if french
        ngc_dvd_no_disk_f
    else
        if german
            ngc_dvd_no_disk_d
        else
            ngc_dvd_no_disk_e
        endif
    endif
endscript
             
script ngc_dvd_wrong_disk
    if french
        ngc_dvd_no_disk_f
    else
        if german
            ngc_dvd_no_disk_d
        else
            ngc_dvd_no_disk_e
        endif
    endif
endscript
             
script ngc_dvd_unknown
    if french
        ngc_dvd_fatal_f
    else
        if german
            ngc_dvd_fatal_d
        else
            ngc_dvd_fatal_e
        endif
    endif
endscript





             
script ngc_widescreen
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="title" text="Do you want to display" y=160 scale=1.3
    ngc_message font="title" text="in progressive mode " scale=1.3
    ngc_message font="small" text="?" scale=1.3 appendx=-12 appendy=-5.5
    ngc_menu font="title" sr=128 sg=128 sb=0 sa=255 ur=64 ug=32 ub=0 ua=255 items=2 item0="Yes" item1="No" scale=1.3
    ngc_message font="newtrickfont" text=" "
endscript

script ngc_license
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="title" text="Licensed by Nintendo" y=192 scale=1.3
    ngc_message font="small" text=" "
    ngc_message font="newtrickfont" text=" "
endscript

script ngc_progressive
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="title" text="Screen has been set" y=192  scale=1.3
    ngc_message font="title" text="to progressive mode" scale=1.3
endscript

script ngc_select0
    ngc_setstandard
    ngc_set480p
endscript

script ngc_select1
    ngc_setstandard
    ngc_set480i
endscript

script ngc_pal60_e
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="title" text="Would you like to display" y=160 scale=1.3
    ngc_message font="title" text="in 60 Hz mode " scale=1.3
    ngc_message font="small" text="?" scale=1.3 appendx=-12 appendy=-5.5
    ngc_menu font="title" sr=128 sg=128 sb=0 sa=255 ur=64 ug=32 ub=0 ua=255 items=2 item0="Yes" item1="No" scale=1.3
endscript

script ngc_pal60_f
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Voulez-vous afficher" y=160 scale=1.0
    ngc_message font="newtrickfont" text="l'image en mode 60 Hz?" scale=1.0
    ngc_menu font="newtrickfont" sr=128 sg=128 sb=0 sa=255 ur=64 ug=32 ub=0 ua=255 items=2 item0="Oui" item1="Non" scale=1.0
endscript

script ngc_pal60_d
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Soll die Darstellung im" y=160 scale=1.0
    ngc_message font="newtrickfont" text="60Hz-Modus erfolgen?" scale=1.0
    ngc_menu font="newtrickfont" sr=128 sg=128 sb=0 sa=255 ur=64 ug=32 ub=0 ua=255 items=2 item0="Ja" item1="Nein" scale=1.0
endscript

script ngc_pal60
    if french
        ngc_pal60_f
    else
        if german
            ngc_pal60_d
        else
            ngc_pal60_e
        endif
    endif
endscript

script ngc_60hz_e
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="title" text="Screen display has been set" y=192  scale=1.3
    ngc_message font="title" text="to 60 Hz mode" scale=1.3
endscript

script ngc_60hz_f
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="L'affichage est en" y=192  scale=1.0
    ngc_message font="newtrickfont" text="mode 60 Hz." scale=1.0
endscript

script ngc_60hz_d
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Die Bildschirmdarstellung" y=192  scale=1.0
    ngc_message font="newtrickfont" text="erfolgt im 60Hz-Modus." scale=1.0
endscript

script ngc_60hz
    if french
        ngc_60hz_f
    else
        if german
            ngc_60hz_d
        else
            ngc_60hz_e
        endif
    endif
endscript

script ngc_50hz_e
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="title" text="Screen display has been set" y=192  scale=1.3
    ngc_message font="title" text="to 50 Hz mode" scale=1.3
endscript

script ngc_50hz_f
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="L'affichage est en" y=192  scale=1.0
    ngc_message font="newtrickfont" text="mode 50 Hz." scale=1.0
endscript

script ngc_50hz_d
    ngc_bgcolor r=0 g=0 b=0 a=255
    ngc_message font="newtrickfont" text="Die Bildschirmdarstellung" y=192  scale=1.0
    ngc_message font="newtrickfont" text="erfolgt im 50Hz-Modus." scale=1.0
endscript

script ngc_50hz
    if french
        ngc_50hz_f
    else
        if german
            ngc_50hz_d
        else
            ngc_50hz_e
        endif
    endif
endscript

script ngc_selectPAL0
    ngc_setstandard
    ngc_set60Hz
endscript

script ngc_selectPAL1
    ngc_setstandard
    ngc_set50Hz
endscript


