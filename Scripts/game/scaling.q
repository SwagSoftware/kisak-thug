// MAYBE PROFILEMANAGER CAN REMOVE ALL THE (1.0f,1.0f,1.0f) PARTS

script update_scaling
    GetSkaterID
    <objID>:Obj_SetBodyShape body_shape=test_scale_info
endscript

// shoulder scaling test for nolan...  these will
// scale outwards, not in place...  (makes the female
// shoulders look better)
nonlocal_bones = [
	Bone_Collar_L
	Bone_Collar_R	
]
 //---------------------Pedestrian Scales-----------------
 
Fatman_scale_info = {

  scale = .95
    ;cloth_hat =                      ( 1.0, .5, .8 ) 
    Bone_head =                      ( .93, 1.0, .98 )     ;X Y Z(length)
    ;Bone_jaw =                       ( 2.0, 1.0, .98 ) 
    Bone_Neck =                      ( 1.2, 1.00, 1.00 )  ;(head length)
    ;Bone_brow =                       ( 2.0, 1.0, .98 )

    Bone_Chest =                     ( .95, 1.5, 1.00 )
    Bone_Stomach_Upper =             ( 1.2, 1.5, 1.00 )
    Bone_Stomach_Lower =             ( 1.3, 1.5, 1.00 )
    Bone_pelvis =                    ( 1.3, 1.5, 1.00 )
  
    Bone_Shoulder_R =                 ( 1.1, 1.1, 1.00 )
    Bone_Shoulder_L =                 (1.1, 1.1, 1.00 )

    Bone_Collar_R =                 (.95,0.95, 1.00 )
    Bone_Collar_L =                (.95, 0.95, 1.00 )
     
    Bone_Bicep_R =                ( 1.1, 0.95, 1.00 )
    Bone_Bicep_L =               ( 1.1, 0.95, 1.00 )

    Bone_Forearm_R =              ( 1.1, 0.95, 1.00 )
    Bone_Forearm_L =             ( 1.1, 0.95, 1.00 )

    Bone_Wrist_R =                ( 0.90, 0.90, 1.00 )
    Bone_Wrist_L =               ( 0.90, 0.90, 1.00 )

    Bone_Palm_R =               ( 0.90, 0.90, 1.00 )                                             
    Bone_Palm_L =              ( 0.90, 0.90, 1.00 )

    Bone_Thumb_R =           ( 0.95, 0.95, 1.00 )
    Bone_Thumb_L =      ( 0.95, 0.95, 1.00 )

    Bone_Forefinger_Base_R =       ( 0.95, 0.95, 1.01 )
    Bone_Forefinger_Base_L =         ( 0.95, 0.95, 1.00 )
    Bone_Forefinger_Tip_R =          ( 0.95, 0.95, 1.01 )
    Bone_Forefinger_Tip_L =          ( 0.95, 0.95, 1.00 )

    Bone_Fingers_Base_R =     ( 0.95, 0.95, 1.00 )
    Bone_Fingers_Tip_R =      ( 0.95, 0.95, 1.01 )
    Bone_Fingers_Base_L =        ( 0.95, 0.95, 1.00 ) 
    Bone_Fingers_Tip_L =         ( 0.95, 0.95, 1.01 ) 
    
     
    Bone_Thigh_R =                  ( 1.10, 1.00, 1.0 )
    Bone_Thigh_L =                 ( 1.10, 1.00, 1.0 )
    
    Bone_Knee_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Knee_L =                ( 1.00, 1.00, 1.00 )
    
    Bone_Ankle_R =                ( 1.00, 1.00, 1.00 )
    Bone_Ankle_L =               ( 1.00, 1.00, 1.00 ) 
    
    Bone_Toe_R=                 ( 1.0, 1.0, 1.0 ) 
    Bone_Toe_L =                ( 1.0, 1.0, 1.0 )
     
}
Fatman2_scale_info = {

  scale = .95
    ;cloth_hat =                      ( 1.0, .5, .8 ) 
    Bone_head =                      ( .93, 1.0, .98 )     ;X Y Z(length)
    ;Bone_jaw =                       ( 2.0, 1.0, .98 ) 
    Bone_Neck =                      ( 1.2, 1.00, 1.00 )  ;(head length)
    ;Bone_brow =                       ( 2.0, 1.0, .98 )

    Bone_Chest =                     ( .95, 1.5, 1.00 )
    Bone_Stomach_Upper =             ( 1.2, 1.5, 1.00 )
    Bone_Stomach_Lower =             ( 1.3, 1.5, 1.00 )
    Bone_pelvis =                    ( 1.3, 1.5, 1.00 )
  
    Bone_Shoulder_R =                 ( 1.1, 1.1, 1.00 )
    Bone_Shoulder_L =                 (1.1, 1.1, 1.00 )

    Bone_Collar_R =                 (.95,0.95, 1.00 )
    Bone_Collar_L =                (.95, 0.95, 1.00 )
     
    Bone_Bicep_R =                ( 1.1, 0.95, 1.00 )
    Bone_Bicep_L =               ( 1.1, 0.95, 1.00 )

    Bone_Forearm_R =              ( 1.1, 0.95, 1.00 )
    Bone_Forearm_L =             ( 1.1, 0.95, 1.00 )

    Bone_Wrist_R =                ( 0.90, 0.90, 1.00 )
    Bone_Wrist_L =               ( 0.90, 0.90, 1.00 )

    Bone_Palm_R =               ( 0.90, 0.90, 1.00 )                                             
    Bone_Palm_L =              ( 0.90, 0.90, 1.00 )

    Bone_Thumb_R =           ( 0.95, 0.95, 1.00 )
    Bone_Thumb_L =      ( 0.95, 0.95, 1.00 )

    Bone_Forefinger_Base_R =       ( 0.95, 0.95, 1.01 )
    Bone_Forefinger_Base_L =         ( 0.95, 0.95, 1.00 )
    Bone_Forefinger_Tip_R =          ( 0.95, 0.95, 1.01 )
    Bone_Forefinger_Tip_L =          ( 0.95, 0.95, 1.00 )

    Bone_Fingers_Base_R =     ( 0.95, 0.95, 1.00 )
    Bone_Fingers_Tip_R =      ( 0.95, 0.95, 1.01 )
    Bone_Fingers_Base_L =        ( 0.95, 0.95, 1.00 ) 
    Bone_Fingers_Tip_L =         ( 0.95, 0.95, 1.01 ) 
    
     
    Bone_Thigh_R =                  ( 1.20, 1.00, 0.8 )
    Bone_Thigh_L =                 ( 1.20, 1.00, 0.8 )
    
    Bone_Knee_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Knee_L =                ( 1.00, 1.00, 1.00 )
    
    Bone_Ankle_R =                ( 1.00, 1.00, 1.00 )
    Bone_Ankle_L =               ( 1.00, 1.00, 1.00 ) 
    
    Bone_Toe_R=                 ( 1.0, 1.0, 1.0 ) 
    Bone_Toe_L =                ( 1.0, 1.0, 1.0 )
     
}

Stocky_scale_info = {

  scale = 1.1
    ;cloth_hat =                      ( 1.0, .5, .8 ) 
    Bone_head =                      ( 1.0, 1.0, .95 )     ;X Y Z(length)
    ;Bone_jaw =                       ( 2.0, 1.0, .98 ) 
    Bone_Neck =                      ( 1.1, 1.00, .95 )  ;(head length)
    ;Bone_brow =                       ( 2.0, 1.0, .98 )

    Bone_Chest =                     ( 1.2, 1.2, 1.00 )
    Bone_Stomach_Upper =             ( 1.2, 1.25, .75 )
    Bone_Stomach_Lower =             ( 1.3, 1.2, .75 )
    Bone_pelvis =                    ( 1.25, 1.15, 1.00 )
  
    Bone_Shoulder_R =                 ( 1.1, 1.1, 1.00 )
    Bone_Shoulder_L =                 (1.1, 1.1, 1.00 )

    Bone_Collar_R =                 (1.10,1.1, 1.00 )
    Bone_Collar_L =                (1.10, 1.1, 1.00 )
     
    Bone_Bicep_R =                ( 1.0, 1.0, 1.00 )
    Bone_Bicep_L =               ( 1.0, 1.0, 1.00 )

    Bone_Forearm_R =              ( 1.0, 1.0, 1.00 )
    Bone_Forearm_L =             ( 1.0, 1.0, 1.00 )

    Bone_Wrist_R =                ( 0.90, 0.90, 1.00 )
    Bone_Wrist_L =               ( 0.90, 0.90, 1.00 )

    Bone_Palm_R =               ( 1.0, 1.0, 1.00 )                                             
    Bone_Palm_L =              ( 1.0, 1.0, 1.00 )

    Bone_Thumb_R =           ( 0.95, 0.95, 1.00 )
    Bone_Thumb_L =      ( 0.95, 0.95, 1.00 )

    Bone_Forefinger_Base_R =       ( 0.95, 0.95, 1.01 )
    Bone_Forefinger_Base_L =         ( 0.95, 0.95, 1.00 )
    Bone_Forefinger_Tip_R =          ( 0.95, 0.95, 1.00 )
    Bone_Forefinger_Tip_L =          ( 0.95, 0.95, 1.00 )

    Bone_Fingers_Base_R =     ( 0.95, 0.95, 1.00 )
    Bone_Fingers_Tip_R =      ( 0.95, 0.95, 1.01 )
    Bone_Fingers_Base_L =        ( 0.95, 0.95, 1.00 ) 
    Bone_Fingers_Tip_L =         ( 0.95, 0.95, 1.01 ) 
    
     
    Bone_Thigh_R =                  ( 1.00, 1.15, .9 )
    Bone_Thigh_L =                 ( 1.00, 1.15, .9 )
    
    Bone_Knee_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Knee_L =                ( 1.00, 1.00, 1.00 )
    
    Bone_Ankle_R =                ( 1.00, 1.00, 1.00 )
    Bone_Ankle_L =               ( 1.00, 1.00, 1.00 ) 
    
    Bone_Toe_R=                 ( 1.0, 1.0, 1.0 ) 
    Bone_Toe_L =                ( 1.0, 1.0, 1.0 )
     
}
// BlkKid1 for Tampa
kid1_scale_info = {
  
  scale = .85  
    Bone_head =                    ( 1.05, 1.05, 1.00 )     ;X Y Z(length)
    Bone_jaw =                     ( 1.00, 1.00, 1.00 ) 
    Bone_Neck =                    ( 1.00, 1.00, 1.00 )  ;(head length)

    Bone_Chest =                   ( 0.90, 1.00, 1.00 )
    Bone_Stomach_Upper =           ( 0.90, 1.00, 1.00 )
    Bone_Stomach_Lower =           ( 0.90, 1.00, 1.00 )
    Bone_pelvis =                  ( 0.90, 1.00, 1.00 )
  
    Bone_Shoulder_R =              ( 1.00, 1.00, 1.00 )
    Bone_Shoulder_L =              ( 1.00, 1.00, 1.00 )

    Bone_Collar_R =                ( 0.90, 1.00, 1.00 )
    Bone_Collar_L =                ( 0.90, 1.00, 1.00 )
                                     
    Bone_Bicep_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Bicep_L =                 ( 1.00, 1.00, 1.00 )

    Bone_Forearm_R =               ( 0.90, 0.90, 1.00 )
    Bone_Forearm_L =               ( 0.90, 0.90, 1.00 )

    Bone_Wrist_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Wrist_L =                 ( 1.00, 1.00, 1.00 )

    Bone_Palm_R =                  ( 1.00, 1.00, 1.00 )                                             
    Bone_Palm_L =                  ( 1.00, 1.00, 1.00 )

    Bone_Thumb_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Thumb_L =                 ( 1.00, 1.00, 1.00 )

    Bone_Forefinger_Base_R =       ( 1.00, 1.00, 1.00 )
    Bone_Forefinger_Base_L =       ( 1.00, 1.00, 1.00 )
    Bone_Forefinger_Tip_R =        ( 1.00, 1.00, 1.00 )
    Bone_Forefinger_Tip_L =        ( 1.00, 1.00, 1.00 )

    Bone_Fingers_Base_R =          ( 1.00, 1.00, 1.00 )
    Bone_Fingers_Tip_R =           ( 1.00, 1.00, 1.00 )
    Bone_Fingers_Base_L =          ( 1.00, 1.00, 1.00 ) 
    Bone_Fingers_Tip_L =           ( 1.00, 1.00, 1.00 ) 
    
     
    Bone_Thigh_R =                 ( 0.90, 1.00, 1.00 )
    Bone_Thigh_L =                 ( 0.90, 1.00, 1.00 )
    
    Bone_Knee_R =                  ( 0.90, 1.00, 1.00 )
    Bone_Knee_L =                  ( 0.90, 1.00, 1.00 )
    
    Bone_Ankle_R =                 ( 0.90, 1.00, 1.00 )
    Bone_Ankle_L =                 ( 0.90, 1.00, 1.00 ) 
    
    Bone_Toe_R=                    ( 1.00, 1.00, 1.00 ) 
    Bone_Toe_L =                   ( 1.00, 1.00, 1.00 )
}



// BlkKid3 for Tampa
kid3_scale_info = {
  
  scale = .8  
    Bone_head =                    ( 1.10, 1.10, 1.00 )     ;X Y Z(length)
    Bone_jaw =                     ( 1.00, 1.00, 1.00 ) 
    Bone_Neck =                    ( 1.00, 1.00, 1.00 )  ;(head length)

    Bone_Chest =                   ( 1.00, 1.00, 1.00 )
    Bone_Stomach_Upper =           ( 1.00, 1.00, 1.00 )
    Bone_Stomach_Lower =           ( 1.00, 1.00, 1.00 )
    Bone_pelvis =                  ( 1.00, 1.00, 1.00 )
  
    Bone_Shoulder_R =              ( 1.00, 1.00, 1.00 )
    Bone_Shoulder_L =              ( 1.00, 1.00, 1.00 )

    Bone_Collar_R =                ( 1.00, 1.00, 1.00 )
    Bone_Collar_L =                ( 1.00, 1.00, 1.00 )
                                     
    Bone_Bicep_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Bicep_L =                 ( 1.00, 1.00, 1.00 )

    Bone_Forearm_R =               ( 1.00, 1.00, 1.00 )
    Bone_Forearm_L =               ( 1.00, 1.00, 1.00 )

    Bone_Wrist_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Wrist_L =                 ( 1.00, 1.00, 1.00 )

    Bone_Palm_R =                  ( 1.00, 1.00, 1.00 )                                             
    Bone_Palm_L =                  ( 1.00, 1.00, 1.00 )

    Bone_Thumb_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Thumb_L =                 ( 1.00, 1.00, 1.00 )

    Bone_Forefinger_Base_R =       ( 1.00, 1.00, 1.00 )
    Bone_Forefinger_Base_L =       ( 1.00, 1.00, 1.00 )
    Bone_Forefinger_Tip_R =        ( 1.00, 1.00, 1.00 )
    Bone_Forefinger_Tip_L =        ( 1.00, 1.00, 1.00 )

    Bone_Fingers_Base_R =          ( 1.00, 1.00, 1.00 )
    Bone_Fingers_Tip_R =           ( 1.00, 1.00, 1.00 )
    Bone_Fingers_Base_L =          ( 1.00, 1.00, 1.00 ) 
    Bone_Fingers_Tip_L =           ( 1.00, 1.00, 1.00 ) 
    
     
    Bone_Thigh_R =                 ( 0.90, 0.90, 0.90 )
    Bone_Thigh_L =                 ( 0.90, 0.90, 0.90 )
    
    Bone_Knee_R =                  ( 1.10, 1.10, 1.10 )
    Bone_Knee_L =                  ( 1.10, 1.10, 1.10 )
    
    Bone_Ankle_R =                 ( 1.05, 1.05, 1.05 )
    Bone_Ankle_L =                 ( 1.05, 1.05, 1.05 ) 
    
    Bone_Toe_R=                    ( 1.00, 1.00, 1.00 ) 
    Bone_Toe_L =                   ( 1.00, 1.00, 1.00 )
}

  female_scale_info = {

// cas female scale goes through new "object_scaling" field
// don't add scale to this structure, or else the body scaling
// won't work properly...
  //scale = .98  
    Bone_head =                      ( 1.0, 1.0, 1.0 )     ;X Y Z(length)
    Bone_jaw =                       ( 1.0, 1.0, 1.0 )
    Bone_Neck =                      ( 1.0, 1.0, 1.0 )  ;(head length)

    Bone_Chest =                     ( .87, .95, 1.00 )
    Bone_Stomach_Upper =             ( .98, .95, .95 )
    Bone_Stomach_Lower =             ( .98, .90, .95 )
    Bone_pelvis =                    ( 1.0, 0.95, 1.0 )
  
    Bone_Shoulder_R =                 ( 0.94, 0.95, 1.00 )
    Bone_Shoulder_L =                ( 0.94, 0.95, 1.00 )

    Bone_Collar_R =                 (.895,0.95, 1.00 )
    Bone_Collar_L =                (.895, 0.95, 1.00 )
     
    Bone_Bicep_R =                ( 1, 0.95, 1.00 )
    Bone_Bicep_L =               ( 1, 0.95, 1.00 )

    Bone_Forearm_R =              ( 0.95, 0.95, 1.00 )
    Bone_Forearm_L =             ( 0.95, 0.95, 1.00 )

    Bone_Wrist_R =                ( 0.90, 0.90, 1.00 )
    Bone_Wrist_L =               ( 0.90, 0.90, 1.00 )

    Bone_Palm_R =               ( 0.90, 0.90, 1.00 )                                             
    Bone_Palm_L =              ( 0.90, 0.90, 1.00 )

    Bone_Thumb_R =           ( 0.95, 0.95, 1.00 )
    Bone_Thumb_L =      ( 0.95, 0.95, 1.00 )

    Bone_Forefinger_Base_R =       ( 0.95, 0.95, 1.01 )
    Bone_Forefinger_Base_L =         ( 0.95, 0.95, 1.00 )
    Bone_Forefinger_Tip_R =          ( 0.95, 0.95, 1.01 )
    Bone_Forefinger_Tip_L =          ( 0.95, 0.95, 1.00 )

    Bone_Fingers_Base_R =     ( 0.95, 0.95, 1.00 )
    Bone_Fingers_Tip_R =      ( 0.95, 0.95, 1.01 )
    Bone_Fingers_Base_L =        ( 0.95, 0.95, 1.00 ) 
    Bone_Fingers_Tip_L =         ( 0.95, 0.95, 1.01 ) 
    
     
    Bone_Thigh_R =                  ( 1.00, 1.00, 1.00 )
    Bone_Thigh_L =                 ( 1.00, 1.00, 1.00 )
    
    Bone_Knee_R =                 ( 1.00, 1.00, 1.00 )
    Bone_Knee_L =                ( 1.00, 1.00, 1.00 )
    
    Bone_Ankle_R =                ( 1.00, 1.00, 1.00 )
    Bone_Ankle_L =               ( 1.00, 1.00, 1.00 ) 
    
    Bone_Toe_R=                 ( 1.0, 1.0, 1.0 ) 
    Bone_Toe_L =                ( 1.0, 1.0, 1.0 )

    Cloth_Breast =             ( .82, 1.0, 1.00 )
    Cloth_Hat =             ( 1.0, 1.0, 1.0 )
}








// THPS4 Bone scalez
// test scaling mode
test_scale_info = {

scale = 1.0  
    head =                      ( 0.98, 0.98, 0.98 )
    jaw =                       ( 0.98, 0.98, 0.98 )
    mullet_cloth_zz =           ( 0.98, 0.98, 0.98 )
    
    left_forearm =              ( 1.02, 1.02, 1.0 )
    right_forearm =             ( 1.02, 1.02, 1.0 )

    left_wrist =                ( 1.02, 1.05, 1.0 )
    right_wrist =               ( 1.02, 1.05, 1.0 )
    
    left_palm =                 ( 1.05, 1.05, 1.0 )
    right_palm =                ( 1.05, 1.05, 1.0 )

}

hawk_scale_info = {

    scale = 1.042
    
    head =                      ( 0.9, 0.9, 0.9 )     ;X Y Z(length)
    jaw =                       ( 0.9, 0.9, 1.00 )
    mullet_cloth_zz =           ( 0.9, 0.9, 1.00 )
    	    
    neck =                      ( 0.8, 0.8, 1.0 )
    chest =                     ( 0.9, 0.9, 1.0 )
    stomach =                   ( 0.85, 0.85, 1.0 )
    pelvis =                    ( 0.85, 0.85, 1.0 )    
    
    breast_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    left_collar =               ( 0.85, 0.85, 0.8 )                                             
    right_collar =              ( 0.95, 0.95, 0.8 )

    left_bicep =                ( 0.85, 0.85, 1.0 )
    right_bicep =               ( 0.85, 0.85, 1.0 )
    
    left_forearm =              ( 0.85, 0.85, 1.0 )
    right_forearm =             ( 0.85, 0.85, 1.0 )
    
    left_hip =                  ( 0.85, 0.85, 1.0 )
    right_hip =                 ( 0.85, 0.85, 1.0 )
    
    left_knee =                 ( 0.85, 0.85, 1.0 )
    right_knee =                ( 0.85, 0.85, 1.0 )
    
    left_ankle =                ( 0.85, 0.85, 1.0 )
    right_ankle =               ( 0.85, 0.85, 1.0 )

    ;Bone_Board_Root =               ( 1.0, 0.9, 1.0 )
    ;Bone_Board_Nose =         ( 0.9, 0.9, 1.0 )
    ;Bone_Board_Tail =          ( 0.9, 0.9, 1.0 ) 


}


burnquist_scale_info = {
    scale = 0.99
    
    head =                      ( 0.95, 0.95, 1.00 )     ;X Y Z(length)
    jaw =                       ( 0.95, 0.95, 1.0 )
    mullet_cloth_zz =           ( 0.95, 0.95, 1.0 )
            
    neck =                      ( 0.93, 0.93, 1.0 )
    chest =                     ( 0.95, 0.95, 1.0 )
    stomach =                   ( 0.93, 0.93, 1.0 )
    pelvis =                    ( 0.90, 0.90, 1.0 )    
    
    breast_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    left_collar =               ( 1.0, 1.0, 1.0 )                                             
    right_collar =              ( 1.0, 1.0, 1.0 )

    left_bicep =                ( 0.95, 0.95, 1.0 )
    right_bicep =               ( 0.95, 0.95, 1.0 )
    
    left_forearm =              ( 0.95, 0.95, 1.0 )
    right_forearm =             ( 0.95, 0.95, 1.0 )
    
    left_hip =                  ( 0.93, 0.93, 1.0 )
    right_hip =                 ( 0.93, 0.93, 1.0 )
    
    left_knee =                 ( 0.95, 0.95, 1.0 )
    right_knee =                ( 0.95, 0.95, 1.0 )
    
    left_ankle =                ( 0.95, 0.95, 1.0 )
    right_ankle =               ( 0.95, 0.95, 1.0 )
}

caballero_scale_info = {
    scale = 0.92
    
    head =                      ( 1.00, 1.00, 1.00 )     ;X Y Z(length)
    jaw =                       ( 1.00, 1.00, 1.00 )
    mullet_cloth_zz =           ( 1.00, 1.00, 1.00 )
	
    neck =                      ( 1.02, 1.02, 1.02 )  ;(head)
    chest =                     ( 1.01, 1.00, 1.00 )
    stomach =                   ( 1.00, 1.00, 1.00 )
    pelvis =                    ( 1.00, 1.00, 1.00 )    
    
    left_bicep =                ( 1.12, 1.12, 1.0 )
    right_bicep =               ( 1.12, 1.12, 1.0 )
    
    left_forearm =              ( 1.12, 1.12, 1.0 )
    right_forearm =             ( 1.12, 1.12, 1.0 )
    
    left_wrist =                ( 1.12, 1.12, 1.0 )
    right_wrist =               ( 1.12, 1.12, 1.0 )
    
    left_palm =                 ( 1.12, 1.12, 1.0 )
    right_palm =                ( 1.12, 1.12, 1.0 )
    
    left_thumb_base =           ( 1.05, 1.05, 1.0 )
    left_forefinger_base =      ( 1.05, 1.05, 1.0 )
    left_forefinger_tip =       ( 1.05, 1.05, 1.0 )
    left_fingers_base =         ( 1.05, 1.05, 1.0 )
    left_fingers_tip =          ( 1.05, 1.05, 1.0 )
    right_thumb_base =          ( 1.05, 1.05, 1.0 )
    right_forefinger_base =     ( 1.05, 1.05, 1.0 )
    right_forefinger_tip =      ( 1.05, 1.05, 1.0 )
    right_fingers_base =        ( 1.05, 1.05, 1.0 ) 
    right_fingers_tip =         ( 1.05, 1.05, 1.0 )   
}
campbell_scale_info = {
scale = 1.01
    
    head =                      ( 0.97, 0.97, 0.97 )
    jaw =                       ( 0.97, 0.97, 0.97 )
    mullet_cloth_zz =           ( 0.97, 0.97, 0.97 )

}

glifberg_scale_info = {
    scale = 0.98
    
    head =                      ( 0.95, 0.95, 1.00 )     ;X Y Z(length)
    jaw =                       ( 0.95, 0.95, 1.00 )
    mullet_cloth_zz =           ( 0.95, 0.95, 1.00 )
	    
    neck =                      ( 0.95, 0.95, 1.00 )  ;(head length)
    chest =                     ( 0.95, 0.95, 1.00 )
    stomach =                   ( 0.95, 0.95, 1.00 )
    pelvis =                    ( 0.95, 0.95, 1.00 )       
    
    left_collar =               ( 0.90, 0.90, 1.00 )                                             
    right_collar =              ( 0.90, 0.90, 1.00 )

    left_bicep =                ( 0.90, 0.90, 1.00 )
    right_bicep =               ( 0.90, 0.90, 1.00 )
    
    left_forearm =              ( 0.95, 0.95, 1.00 )
    right_forearm =             ( 0.95, 0.95, 1.00 )
    
    left_wrist =                ( 0.95, 0.95, 1.00 )
    right_wrist =               ( 0.95, 0.95, 1.00 )
    
    left_palm =                 ( 0.95, 0.95, 1.00 )
    right_palm =                ( 0.95, 0.95, 1.00 )
    
    left_thumb_base =           ( 0.95, 0.95, 1.00 )
    left_forefinger_base =      ( 0.95, 0.95, 1.00 )
    left_forefinger_tip =       ( 0.95, 0.95, 1.00 )
    left_fingers_base =         ( 0.95, 0.95, 1.00 )
    left_fingers_tip =          ( 0.95, 0.95, 1.00 )
    right_thumb_base =          ( 0.95, 0.95, 1.00 )
    right_forefinger_base =     ( 0.95, 0.95, 1.00 )
    right_forefinger_tip =      ( 0.95, 0.95, 1.00 )
    right_fingers_base =        ( 0.95, 0.95, 1.00 ) 
    right_fingers_tip =         ( 0.95, 0.95, 1.00 )   

    
    left_hip =                  ( 0.85, 0.90, 1.00 )
    right_hip =                 ( 0.85, 0.90, 1.00 )
    
    left_knee =                 ( 0.85, 0.85, 1.00 )
    right_knee =                ( 0.85, 0.85, 1.00 )
    
    left_ankle =                ( 1.00, 1.00, 1.00 )
    right_ankle =               ( 1.00, 1.00, 1.00 ) 
}
koston_scale_info = {
    scale = 0.98
    
    head =                      ( 0.91, 0.91, 1.00 )     ;X Y Z(length)
    jaw =                       ( 0.91, 0.91, 1.00 )
    mullet_cloth_zz =           ( 0.95, 0.95, 1.00 )
	    
    neck =                      ( 0.90, 0.90, 1.00 )  ;(head length)
    chest =                     ( 0.90, 0.90, 1.00 )
    stomach =                   ( 0.90, 0.90, 1.00 )
    pelvis =                    ( 0.85, 0.85, 1.00 )       
    
    left_collar =               ( 0.90, 0.90, 1.00 )                                             
    right_collar =              ( 0.90, 0.90, 1.00 )

    left_bicep =                ( 0.90, 0.90, 1.00 )
    right_bicep =               ( 0.90, 0.90, 1.00 )
    
    left_forearm =              ( 0.92, 0.92, 1.00 )
    right_forearm =             ( 0.92, 0.92, 1.00 )
    
    left_wrist =                ( 0.95, 0.95, 1.00 )
    right_wrist =               ( 0.95, 0.95, 1.00 )
    
    left_palm =                 ( 0.95, 0.95, 1.00 )
    right_palm =                ( 0.95, 0.95, 1.00 )
    
    left_thumb_base =           ( 0.95, 0.95, 1.00 )
    left_forefinger_base =      ( 0.95, 0.95, 1.00 )
    left_forefinger_tip =       ( 0.95, 0.95, 1.00 )
    left_fingers_base =         ( 0.95, 0.95, 1.00 )
    left_fingers_tip =          ( 0.95, 0.95, 1.00 )
    right_thumb_base =          ( 0.95, 0.95, 1.00 )
    right_forefinger_base =     ( 0.95, 0.95, 1.00 )
    right_forefinger_tip =      ( 0.95, 0.95, 1.00 )
    right_fingers_base =        ( 0.95, 0.95, 1.00 ) 
    right_fingers_tip =         ( 0.95, 0.95, 1.00 )   

    
    left_hip =                  ( 0.80, 0.90, 1.00 )
    right_hip =                 ( 0.80, 0.90, 1.00 )
    
    left_knee =                 ( 0.80, 0.85, 1.00 )
    right_knee =                ( 0.80, 0.85, 1.00 )
    
    left_ankle =                ( 0.95, 1.00, 1.00 )
    right_ankle =               ( 0.95, 1.00, 1.00 ) 
}

 Lasek_scale_info = {

    scale = 1.02
    
    head =                      ( 1.00, 1.00, 1.00 )
    jaw =                       ( 1.00, 1.00, 1.00 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    
    neck =                      ( 0.97, 0.97, 1.0 )  	;Head
    chest =                     ( 0.90, 0.90, 1.0 )
    stomach =                   ( 0.90, 0.90, 1.0 ) 
    pelvis =                    ( 0.95, 0.95, 1.0 )
    
    left_collar =               ( 0.85, 0.85, 1.0 )                                             
    right_collar =              ( 0.85, 0.85, 1.0 )

    left_bicep =                ( 0.90, 0.90, 1.0 )
    right_bicep =               ( 0.90, 0.90, 1.0 )
    
    left_forearm =              ( 0.90, 0.90, 1.0 )
    right_forearm =             ( 0.90, 0.90, 1.0 )
    
    left_wrist =                ( 1.0, 1.0, 1.0 )
    right_wrist =               ( 1.0, 1.0, 1.0 )
    
    left_palm =                 ( 1.0, 1.0, 1.0 )
    right_palm =                ( 1.0, 1.0, 1.0 )
    
    left_thumb_base =           ( 1.0, 1.0, 1.0 )
    left_forefinger_base =      ( 1.0, 1.0, 1.0 )
    left_forefinger_tip =       ( 1.0, 1.0, 1.0 )
    left_fingers_base =         ( 1.0, 1.0, 1.0 )
    left_fingers_tip =          ( 1.0, 1.0, 1.0 )
    right_thumb_base =          ( 1.0, 1.0, 1.0 )
    right_forefinger_base =     ( 1.0, 1.0, 1.0 )
    right_forefinger_tip =      ( 1.0, 1.0, 1.0 )
    right_fingers_base =        ( 1.0, 1.0, 1.0 ) 
    right_fingers_tip =         ( 1.0, 1.0, 1.0 )   

    left_low_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )    
    left_top_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )
                                                       
    right_low_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    hood_cloth_zz =             ( 1.0, 1.0, 1.0 )
    
    left_hip =                  ( 0.90, 0.90, 1.0 )
    right_hip =                 ( 0.90, 0.90, 1.0 )
    
    left_knee =                 ( 0.90, 0.90, 1.0 )
    right_knee =                ( 0.90, 0.90, 1.0 )
    
    left_ankle =                ( 0.90, 0.90, 1.0 )
    right_ankle =               ( 0.90, 0.90, 1.0 )
    
    left_toes =                 ( 1.0, 1.0, 1.0 ) 
    right_toes =                ( 1.0, 1.0, 1.0 )
    
    right_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.0, 1.0, 1.0 )
    
    left_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    left_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 1.0, 1.0, 1.0 )
    Bone_Board_Tail =          ( 1.0, 1.0, 1.0 )



}
margera_scale_info = {

    scale = 0.95
    
    /*head =                      ( 1.00, 1.03, 1.03 )
    jaw =                       ( 1.05, 1.05, 1.05 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    
    neck =                      ( 0.97, 0.97, 1.0 )  	;Head
    chest =                     ( 0.90, 0.90, 1.0 )
    stomach =                   ( 0.90, 0.90, 1.0 ) 
    pelvis =                    ( 0.95, 0.95, 1.0 )
    
    left_collar =               ( 0.85, 0.85, 1.0 )                                             
    right_collar =              ( 0.85, 0.85, 1.0 )

    left_bicep =                ( 0.90, 0.90, 1.0 )
    right_bicep =               ( 0.90, 0.90, 1.0 )
    
    left_forearm =              ( 0.90, 0.90, 1.0 )
    right_forearm =             ( 0.90, 0.90, 1.0 )
    
    left_wrist =                ( 1.0, 1.0, 1.0 )
    right_wrist =               ( 1.0, 1.0, 1.0 )
    
    left_palm =                 ( 1.0, 1.0, 1.0 )
    right_palm =                ( 1.0, 1.0, 1.0 )
    
    left_thumb_base =           ( 1.0, 1.0, 1.0 )
    left_forefinger_base =      ( 1.0, 1.0, 1.0 )
    left_forefinger_tip =       ( 1.0, 1.0, 1.0 )
    left_fingers_base =         ( 1.0, 1.0, 1.0 )
    left_fingers_tip =          ( 1.0, 1.0, 1.0 )
    right_thumb_base =          ( 1.0, 1.0, 1.0 )
    right_forefinger_base =     ( 1.0, 1.0, 1.0 )
    right_forefinger_tip =      ( 1.0, 1.0, 1.0 )
    right_fingers_base =        ( 1.0, 1.0, 1.0 ) 
    right_fingers_tip =         ( 1.0, 1.0, 1.0 )   

    left_low_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )    
    left_top_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )
                                                       
    right_low_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    hood_cloth_zz =             ( 1.0, 1.0, 1.0 )
    
    left_hip =                  ( 0.90, 0.90, 1.0 )
    right_hip =                 ( 0.90, 0.90, 1.0 )
    
    left_knee =                 ( 0.90, 0.90, 1.0 )
    right_knee =                ( 0.90, 0.90, 1.0 )
    
    left_ankle =                ( 0.90, 0.90, 1.0 )
    right_ankle =               ( 0.90, 0.90, 1.0 )
    
    left_toes =                 ( 1.0, 1.0, 1.0 ) 
    right_toes =                ( 1.0, 1.0, 1.0 )
    
    right_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.0, 1.0, 1.0 )
    
    left_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    left_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 1.0, 1.0, 1.0 )
    Bone_Board_Tail =          ( 1.0, 1.0, 1.0 )


 */

}

muska_scale_info = {

    scale = 1.00
    
    head =                      ( 0.98, 0.98, 0.98 )
    jaw =                       ( 0.98, 0.98, 0.98 )
    mullet_cloth_zz =           ( 0.98, 0.98, 0.98 )

    pelvis =                    ( 0.90, 0.90, 1.0 )
    left_hip =                  ( 0.90, 0.90, 1.0 )
   right_hip =                 ( 0.90, 0.90, 1.0 )


    
    left_forearm =              ( 1.02, 1.02, 1.0 )
    right_forearm =             ( 1.02, 1.02, 1.0 )

    left_wrist =                ( 1.02, 1.05, 1.0 )
    right_wrist =               ( 1.02, 1.05, 1.0 )
    
    left_palm =                 ( 1.05, 1.05, 1.0 )
    right_palm =                ( 1.05, 1.05, 1.0 )      
}

mullen_scale_info = {

    scale = 0.97
    
    head =                      ( 1.02, 1.02, 1.02 )
    jaw =                       ( 1.02, 1.02, 1.02 )
    mullet_cloth_zz =           ( 1.02, 1.02, 1.02 )

}


reynolds_scale_info = {

    scale = 1.05
    
    head =                      ( 0.99, 0.99, 0.99 )     ;X Y Z(length)
    jaw =                       ( 0.99, 0.99, 0.99 )
    mullet_cloth_zz =           ( 0.99, 0.99, 0.99 )
	    
    neck =                      ( 0.88, 0.88, 1.00 )  
    chest =                     ( 0.85, 0.85, 1.00 )
    stomach =                   ( 0.88, 0.88, 1.00 )
    pelvis =                    ( 0.88, 0.88, 1.00 )       
    
    left_collar =               ( 0.88, 0.88, 1.00 )                                           
    right_collar =              ( 0.88, 0.88, 1.00 )

    left_bicep =                ( 0.85, 0.85, 1.00 )
    right_bicep =               ( 0.85, 0.85, 1.00 )
    
    left_forearm =              ( 0.90, 0.90, 1.00 )
    right_forearm =             ( 0.90, 0.90, 1.00 )
    
    left_wrist =                ( 0.90, 0.90, 1.00 )
    right_wrist =               ( 0.90, 0.90, 1.00 )
    
    left_palm =                 ( 0.99, 0.99, 1.00 )
    right_palm =                ( 0.99, 0.99, 1.00 )
  
    left_hip =                  ( 0.81, 0.85, 1.00 )
    right_hip =                 ( 0.81, 0.85, 1.00 )
    
    left_knee =                 ( 0.81, 0.81, 1.00 )
    right_knee =                ( 0.81, 0.81, 1.00 )
    
    left_ankle =                ( 0.90, 0.90, 1.00 )
    right_ankle =               ( 0.90, 0.90, 1.00 ) 
}

rowley_scale_info = {

    scale = 0.94
    
    head =                      ( 1.03, 1.03, 1.03 )     ;X Y Z(length)
    jaw =                       ( 1.03, 1.03, 1.00 )
    mullet_cloth_zz =           ( 1.03, 1.03, 1.00 )
	    
    neck =                      ( 0.95, 0.95, 1.00 )  ;(head length)
    chest =                     ( 0.95, 0.95, 1.00 )
    stomach =                   ( 0.95, 0.95, 1.00 )
    pelvis =                    ( 0.95, 0.95, 1.00 )       
    
    left_collar =               ( 0.90, 0.90, 1.00 )                                             
    right_collar =              ( 0.90, 0.90, 1.00 )

    left_bicep =                ( 0.90, 0.90, 1.00 )
    right_bicep =               ( 0.90, 0.90, 1.00 )
    
    left_forearm =              ( 0.95, 0.95, 1.00 )
    right_forearm =             ( 0.95, 0.95, 1.00 )
    
    left_wrist =                ( 0.95, 0.95, 1.00 )
    right_wrist =               ( 0.95, 0.95, 1.00 )
    
    left_palm =                 ( 0.95, 0.95, 1.00 )
    right_palm =                ( 0.95, 0.95, 1.00 )
        
    left_hip =                  ( 0.85, 0.90, 1.00 )
    right_hip =                 ( 0.85, 0.90, 1.00 )
    
    left_knee =                 ( 0.85, 0.85, 1.00 )
    right_knee =                ( 0.85, 0.85, 1.00 )
}


steamer_scale_info = {

    scale = 0.93
    
    Bone_head =                      ( 1.03, 1.03, 1.07 )     ;X Y Z(length)
    Bone_jaw =                       ( 1.03, 1.03, 1.07 )
  
	    
    neck =                      ( 0.95, 0.95, 1.00 )  ;(head length)
    chest =                     ( 0.95, 0.95, 1.00 )
    breast_cloth_zz =           ( 0.95, 0.95, 0.95 )
    stomach =                   ( 0.95, 0.95, 1.00 )
    pelvis =                    ( 0.90, 0.90, 1.00 )       
    
    left_collar =               ( 0.90, 0.90, 1.00 )                                             
    right_collar =              ( 0.90, 0.90, 1.00 )

    left_bicep =                ( 0.90, 0.90, 1.00 )
    right_bicep =               ( 0.90, 0.90, 1.00 )
    
    left_forearm =              ( 0.95, 0.95, 1.00 )
    right_forearm =             ( 0.95, 0.95, 1.00 )
    
    left_wrist =                ( 0.95, 0.95, 1.00 )
    right_wrist =               ( 0.95, 0.95, 1.00 )
    
    left_palm =                 ( 0.95, 0.95, 1.00 )
    right_palm =                ( 0.95, 0.95, 1.00 )
    
    left_thumb_base =           ( 0.95, 0.95, 1.00 )
    left_forefinger_base =      ( 0.95, 0.95, 1.00 )
    left_forefinger_tip =       ( 0.95, 0.95, 1.00 )
    left_fingers_base =         ( 0.95, 0.95, 1.00 )
    left_fingers_tip =          ( 0.95, 0.95, 1.00 )
    right_thumb_base =          ( 0.95, 0.95, 1.00 )
    right_forefinger_base =     ( 0.95, 0.95, 1.00 )
    right_forefinger_tip =      ( 0.95, 0.95, 1.00 )
    right_fingers_base =        ( 0.95, 0.95, 1.00 ) 
    right_fingers_tip =         ( 0.95, 0.95, 1.00 )   

    
    left_hip =                  ( 0.90, 0.90, 1.00 )
    right_hip =                 ( 0.90, 0.90, 1.00 )
    
    left_knee =                 ( 0.90, 0.90, 1.00 )
    right_knee =                ( 0.90, 0.90, 1.00 )
    
    left_ankle =                ( 0.95, 0.95, 1.00 )
    right_ankle =               ( 0.95, 0.95, 1.00 ) 
} 
 thomas_scale_info = {

    scale = 1.0
    
    head =                      ( 1.00, 1.00, 1.00 )
    jaw =                       ( 1.00, 1.00, 1.00 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    
    neck =                      ( 0.97, 0.97, 1.0 )  	;Head
    chest =                     ( 0.90, 0.90, 1.0 )
    stomach =                   ( 0.90, 0.90, 1.0 ) 
    pelvis =                    ( 0.95, 0.95, 1.0 )
    
    left_collar =               ( 0.85, 0.85, 1.0 )                                             
    right_collar =              ( 0.85, 0.85, 1.0 )

    left_bicep =                ( 0.90, 0.90, 1.0 )
    right_bicep =               ( 0.90, 0.90, 1.0 )
    
    left_forearm =              ( 0.90, 0.90, 1.0 )
    right_forearm =             ( 0.90, 0.90, 1.0 )
    
    left_wrist =                ( 1.0, 1.0, 1.0 )
    right_wrist =               ( 1.0, 1.0, 1.0 )
    
    left_palm =                 ( 1.0, 1.0, 1.0 )
    right_palm =                ( 1.0, 1.0, 1.0 )
    
    left_thumb_base =           ( 1.0, 1.0, 1.0 )
    left_forefinger_base =      ( 1.0, 1.0, 1.0 )
    left_forefinger_tip =       ( 1.0, 1.0, 1.0 )
    left_fingers_base =         ( 1.0, 1.0, 1.0 )
    left_fingers_tip =          ( 1.0, 1.0, 1.0 )
    right_thumb_base =          ( 1.0, 1.0, 1.0 )
    right_forefinger_base =     ( 1.0, 1.0, 1.0 )
    right_forefinger_tip =      ( 1.0, 1.0, 1.0 )
    right_fingers_base =        ( 1.0, 1.0, 1.0 ) 
    right_fingers_tip =         ( 1.0, 1.0, 1.0 )   

    left_low_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )    
    left_top_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )
                                                       
    right_low_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    hood_cloth_zz =             ( 1.0, 1.0, 1.0 )
    
    left_hip =                  ( 0.80, 0.80, 1.0 )
    right_hip =                 ( 0.80, 0.80, 1.0 )
    
    left_knee =                 ( 0.90, 0.90, 1.0 )
    right_knee =                ( 0.90, 0.90, 1.0 )
    
    left_ankle =                ( 0.90, 0.90, 1.0 )
    right_ankle =               ( 0.90, 0.90, 1.0 )
    
    left_toes =                 ( 1.0, 1.0, 1.0 ) 
    right_toes =                ( 1.0, 1.0, 1.0 )
    
    right_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.0, 1.0, 1.0 )
    
    left_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    left_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 1.0, 1.0, 1.0 )
    Bone_Board_Tail =          ( 1.0, 1.0, 1.0 )



}



Jenna_scale_info = {

    scale = 0.95
    
    head =                      ( 1.05, 1.05, 1.05 )     ;X Y Z(length)
    jaw =                       ( 1.05, 1.05, 1.05 )
    mullet_cloth_zz =           ( 1.00, 1.00, 1.00 )
	    
    neck =                      ( 1.00, 1.00, 1.00 )  ;(head length)
    chest =                     ( 0.90, 0.90, 1.00 )
    breast_cloth_zz =           ( 1.00, 1.00, 1.00 )
    stomach =                   ( 0.88, 0.88, 1.00 )
    pelvis =                    ( 0.95, 0.95, 1.00 )       
    
    left_collar =               ( 0.90, 0.90, 1.00 )                                             
    right_collar =              ( 0.90, 0.90, 1.00 )

    left_bicep =                ( 0.90, 0.90, 1.00 )
    right_bicep =               ( 0.90, 0.90, 1.00 )
    
    left_forearm =              ( 0.95, 0.95, 1.00 )
    right_forearm =             ( 0.95, 0.95, 1.00 )
    
    left_wrist =                ( 0.95, 0.95, 1.00 )
    right_wrist =               ( 0.95, 0.95, 1.00 )
    
    left_palm =                 ( 0.95, 0.95, 1.00 )
    right_palm =                ( 0.95, 0.95, 1.00 )
    
    left_thumb_base =           ( 0.95, 0.95, 1.00 )
    left_forefinger_base =      ( 0.95, 0.95, 1.00 )
    left_forefinger_tip =       ( 0.95, 0.95, 1.01 )
    left_fingers_base =         ( 0.95, 0.95, 1.00 )
    left_fingers_tip =          ( 0.95, 0.95, 1.01 )
    right_thumb_base =          ( 0.95, 0.95, 1.00 )
    right_forefinger_base =     ( 0.95, 0.95, 1.00 )
    right_forefinger_tip =      ( 0.95, 0.95, 1.01 )
    right_fingers_base =        ( 0.95, 0.95, 1.00 ) 
    right_fingers_tip =         ( 0.95, 0.95, 1.01 )   

    
    left_hip =                  ( 1.00, 1.00, 1.00 )
    right_hip =                 ( 1.00, 1.00, 1.00 )
    
    left_knee =                 ( 1.00, 1.00, 1.00 )
    right_knee =                ( 1.00, 1.00, 1.00 )
    
    left_ankle =                ( 1.00, 1.00, 1.00 )
    right_ankle =               ( 1.00, 1.00, 1.00 ) 
    
    left_toes =                 ( 1.0, 0.7, 1.0 ) 
    right_toes =                ( 1.0, 0.7, 1.0 )
     
}



// ---------------------------------------------------------------------------------



// normal mode (don't change unless you're Gary)
normal_scale_info = {

    scale = 1.00
    
    head =                      ( 1.0, 1.0, 1.0 )
    jaw =                       ( 1.0, 1.0, 1.0 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    
    neck =                      ( 1.0, 1.0, 1.0 )  	;Head
    chest =                     ( 1.0, 1.0, 1.0 )
    stomach =                   ( 1.0, 1.0, 1.0 ) 
    pelvis =                    ( 1.0, 1.0, 1.0 )
    
    breast_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    left_collar =               ( 1.0, 1.0, 1.0 )                                             
    right_collar =              ( 1.0, 1.0, 1.0 )

    left_bicep =                ( 1.0, 1.0, 1.0 )
    right_bicep =               ( 1.0, 1.0, 1.0 )
    
    left_forearm =              ( 1.0, 1.0, 1.0 )
    right_forearm =             ( 1.0, 1.0, 1.0 )
    
    left_wrist =                ( 1.0, 1.0, 1.0 )
    right_wrist =               ( 1.0, 1.0, 1.0 )
    
    left_palm =                 ( 1.0, 1.0, 1.0 )
    right_palm =                ( 1.0, 1.0, 1.0 )
    
    left_thumb_base =           ( 1.0, 1.0, 1.0 )
    left_forefinger_base =      ( 1.0, 1.0, 1.0 )
    left_forefinger_tip =       ( 1.0, 1.0, 1.0 )
    left_fingers_base =         ( 1.0, 1.0, 1.0 )
    left_fingers_tip =          ( 1.0, 1.0, 1.0 )
    right_thumb_base =          ( 1.0, 1.0, 1.0 )
    right_forefinger_base =     ( 1.0, 1.0, 1.0 )
    right_forefinger_tip =      ( 1.0, 1.0, 1.0 )
    right_fingers_base =        ( 1.0, 1.0, 1.0 ) 
    right_fingers_tip =         ( 1.0, 1.0, 1.0 )   

    left_low_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )    
    left_top_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )
                                                       
    right_low_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    hood_cloth_zz =             ( 1.0, 1.0, 1.0 )
    
    left_hip =                  ( 1.0, 1.0, 1.0 )
    right_hip =                 ( 1.0, 1.0, 1.0 )
    
    left_knee =                 ( 1.0, 1.0, 1.0 )
    right_knee =                ( 1.0, 1.0, 1.0 )
    
    left_ankle =                ( 1.0, 1.0, 1.0 )
    right_ankle =               ( 1.0, 1.0, 1.0 )
    
    left_toes =                 ( 1.0, 1.0, 1.0 ) 
    right_toes =                ( 1.0, 1.0, 1.0 )
    
    right_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.0, 1.0, 1.0 )
    
    left_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    left_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 1.0, 1.0, 1.0 )
    Bone_Board_Tail =          ( 1.0, 1.0, 1.0 )

}

// gorilla mode
gorilla_scale_info = {
    scaleFromOrigin = 1
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    pelvis =                    ( 1.0, 1.0, 1.0 )
    stomach =                   ( 1.0, 1.0, 1.0 ) 
    chest =                     ( 2.5, 2.5, 2.5 )
    neck =                      ( 1.0, 1.0, 1.0 )
    head =                      ( 1.0, 1.0, 1.0 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    jaw =                       ( 1.3, 1.3, 1.3 )
}                         

// athletic mode
athletic_scale_info = {


    scale = 1.03
    
    head =                      ( 1.0, 1.0, 1.0 )
    jaw =                       ( 1.0, 1.0, 1.2 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    
    neck =                      ( 1.0, 1.0, 1.0 )  	
    chest =                     ( 1.07, 1.03, 1.0 )
    stomach =                   ( 1.0, 1.0, 1.0 ) 
    pelvis =                    ( 0.85, 1.0, 1.0 )
    
    breast_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    left_collar =               ( 1.3, 1.3, 1.05 )                                             
    right_collar =              ( 1.3, 1.3, 1.05 )

    left_bicep =                ( 1.1, 1.3, 1.0 )
    right_bicep =               ( 1.1, 1.3, 1.0 )
    
    left_forearm =              ( 1.2, 1.2, 1.0 )
    right_forearm =             ( 1.2, 1.2, 1.0 )
    
    left_wrist =                ( 1.3, 1.3, 1.0 )
    right_wrist =               ( 1.3, 1.3, 1.0 )
    
    left_palm =                 ( 1.2, 1.2, 1.0 )
    right_palm =                ( 1.2, 1.2, 1.0 )
    
    left_thumb_base =           ( 1.1, 1.1, 1.0 )
    left_forefinger_base =      ( 1.2, 1.2, 1.0 )
    left_forefinger_tip =       ( 1.2, 1.2, 1.0 )
    left_fingers_base =         ( 1.2, 1.2, 1.0 )
    left_fingers_tip =          ( 1.2, 1.2, 1.0 )
    right_thumb_base =          ( 1.2, 1.2, 1.0 )
    right_forefinger_base =     ( 1.2, 1.2, 1.0 )
    right_forefinger_tip =      ( 1.2, 1.2, 1.0 )
    right_fingers_base =        ( 1.2, 1.2, 1.0 ) 
    right_fingers_tip =         ( 1.2, 1.2, 1.0 )   

    left_low_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )    
    left_top_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )
                                                       
    right_low_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    hood_cloth_zz =             ( 1.0, 1.0, 1.0 )
    
    left_hip =                  ( 0.90, 0.95, 1.0 )
    right_hip =                 ( 0.90, 0.95, 1.0 )
    
    left_knee =                 ( 1.25, 1.1, 1.0 )
    right_knee =                ( 1.25, 1.1, 1.0 )
    
    left_ankle =                ( 1.1, 1.0, 1.0 )
    right_ankle =               ( 1.1, 1.0, 1.0 )
    
    left_toes =                 ( 1.0, 1.0, 1.0 ) 
    right_toes =                ( 1.0, 1.0, 1.0 )
    
    right_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.0, 1.0, 1.0 )
    
    left_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    left_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 1.5, 1.0, 1.0 )
    Bone_Board_Tail =          ( 1.5, 1.0, 1.0 )                                                  
}                                                                       

// fat mode
fat_scale_info = {

    scale = 1.2
    
    head =                      ( 1.0, 1.0, 1.0 )
    jaw =                       ( 1.0, 1.0, 1.0 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    
    neck =                      ( 1.0, 1.0, 1.0 )  	;Head
    chest =                     ( 1.0, 1.0, 1.0 )
    stomach =                   ( 1.0, 1.0, 1.0 ) 
    pelvis =                    ( 1.0, 1.0, 1.0 )
    
    breast_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    left_collar =               ( 1.0, 1.0, 1.0 )                                             
    right_collar =              ( 1.0, 1.0, 1.0 )

    left_bicep =                ( 1.0, 1.0, 1.0 )
    right_bicep =               ( 1.0, 1.0, 1.0 )
    
    left_forearm =              ( 1.0, 1.0, 1.0 )
    right_forearm =             ( 1.0, 1.0, 1.0 )
    
    left_wrist =                ( 1.0, 1.0, 1.0 )
    right_wrist =               ( 1.0, 1.0, 1.0 )
    
    left_palm =                 ( 1.0, 1.0, 1.0 )
    right_palm =                ( 1.0, 1.0, 1.0 )
    
    left_thumb_base =           ( 1.0, 1.0, 1.0 )
    left_forefinger_base =      ( 1.0, 1.0, 1.0 )
    left_forefinger_tip =       ( 1.0, 1.0, 1.0 )
    left_fingers_base =         ( 1.0, 1.0, 1.0 )
    left_fingers_tip =          ( 1.0, 1.0, 1.0 )
    right_thumb_base =          ( 1.0, 1.0, 1.0 )
    right_forefinger_base =     ( 1.0, 1.0, 1.0 )
    right_forefinger_tip =      ( 1.0, 1.0, 1.0 )
    right_fingers_base =        ( 1.0, 1.0, 1.0 ) 
    right_fingers_tip =         ( 1.0, 1.0, 1.0 )   

    left_low_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )    
    left_top_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )
                                                       
    right_low_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    hood_cloth_zz =             ( 1.0, 1.0, 1.0 )
    
    left_hip =                  ( 1.0, 1.0, 1.0 )
    right_hip =                 ( 1.0, 1.0, 1.0 )
    
    left_knee =                 ( 1.0, 1.0, 1.0 )
    right_knee =                ( 1.0, 1.0, 1.0 )
    
    left_ankle =                ( 1.0, 1.0, 1.0 )
    right_ankle =               ( 1.0, 1.0, 1.0 )
    
    left_toes =                 ( 1.0, 1.0, 1.0 ) 
    right_toes =                ( 1.0, 1.0, 1.0 )
    
    right_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.0, 1.0, 1.0 )
    
    left_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    left_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 1.0, 1.0, 1.0 )
    Bone_Board_Tail =          ( 1.0, 1.0, 1.0 )


}
// Ped fat mode
fatpeda_scale_info = {
    pelvis =                    ( 1.2, 1.4, 1.0 )
    stomach =                   ( 1.2, 1.4, 1.0 ) 
    chest =                     ( 1.2, 1.4, 1.0 )
    neck =                      ( 1.1, 1.1, 1.0 )
    head =                      ( 1.1, 1.1, 1.0 )
    jaw =                       ( 1.1, 1.1, 1.0 )
    breast_cloth_zz =           ( 1.5, 1.5, 1.0 )
    left_collar =               ( 1.3, 1.3, 1.0 )
	right_collar =              ( 1.3, 1.3, 1.0 )
	left_bicep =                ( 1.5, 1.5, 1.0 )
	right_bicep =               ( 1.5, 1.5, 1.0 )
    left_forearm =              ( 1.5, 1.5, 1.0 )
	right_forearm =             ( 1.5, 1.5, 1.0 ) 
    left_wrist =                ( 1.2, 1.2, 1.0 )
	right_wrist =               ( 1.2, 1.2, 1.0 )
    left_palm =                 ( 1.2, 1.2, 1.0 )
	right_palm =                ( 1.2, 1.2, 1.0 ) 
    left_thumb_base =           ( 1.0, 1.0, 1.0 )
    left_forefinger_base =      ( 1.0, 1.0, 1.0 )
    left_forefinger_tip =       ( 1.0, 1.0, 1.0 )
    left_fingers_base =         ( 1.0, 1.0, 1.0 )
    left_fingers_tip =          ( 1.0, 1.0, 1.0 )                                                       
    right_hip =                 ( 1.3, 1.3, 1.0 )
    right_knee =                ( 1.5, 1.5, 1.0 )
    right_ankle =               ( 1.2, 1.2, 1.0 )
    right_toes =                ( 1.2, 1.2, 1.0 )
    left_hip =                  ( 1.3, 1.3, 1.0 )
    left_knee =                 ( 1.5, 1.5, 1.0 )
    left_ankle =                ( 1.2, 1.2, 1.0 )
    left_toes =                 ( 1.2, 1.2, 1.0 )
 }

// kid mode
kid_scale_info = {
    scale = .6
    
    bone_head =                 ( 1.4, 1.4, 1.4 )     ;X Y Z(length)
    bone_brow =                 ( 1.4, 1.4, 1.4 )     ;X Y Z(length)
    bone_jaw =                  ( 1.4, 1.4, 1.4 )
    bone_ponytail_1 =           ( 1.4, 1.4, 1.4 )
    bone_ponytail_2 =           ( 1.4, 1.4, 1.4 )
    
	Bone_Neck  =           ( 1.16, 1.16, 1.0 )

    Bone_chest =                     ( 1.16, 1.16, 1.0 )
    Bone_Stomach_Upper =             ( 1.16, 1.16, 1.0 )
    Bone_stomach_Lower =             ( 1.16, 1.16, 1.0 )
    Bone_pelvis =                    ( 1.16, 1.16, 1.0 )

    Bone_Shoulder_R =                 ( 1.2, 1.2, 1.2 )
    Bone_Shoulder_L =                ( 1.2, 1.2, 1.2 )

//    Bone_Collar_R =                 ( 1.2, 1.2, 1.0 )
//    Bone_Collar_L =                ( 1.2, 1.2, 1.0 )

    Bone_Bicep_R =                ( 1.2, 1.2, 1.0 )
    Bone_Bicep_L =               ( 1.2, 1.2, 1.0 )

    Bone_Forearm_R =              ( 1.2, 1.2, 1.0 )
    Bone_Forearm_L =             ( 1.2, 1.2, 1.0 )

    Bone_Wrist_R =                ( 1.2, 1.2, 1.0 )
    Bone_Wrist_L =               ( 1.2, 1.2, 1.0 )

    Bone_Palm_R =                ( 1.2, 1.2, 1.0 )
    Bone_Palm_L =               ( 1.2, 1.2, 1.0 )

    Bone_Thumb_R =           ( 1.2, 1.2, 1.0 )
    Bone_Thumb_L =      ( 1.2, 1.2, 1.0 )

    Bone_Forefinger_Base_R =       ( 1.4, 1.4, 1.0 )
    Bone_Forefinger_Base_L =         ( 1.4, 1.4, 1.0 )
    Bone_Forefinger_Tip_R =          ( 1.4, 1.4, 1.0 )
    Bone_Forefinger_Tip_L =          ( 1.4, 1.4, 1.0 )

    Bone_Fingers_Base_R =     ( 1.4, 1.4, 1.0 )
    Bone_Fingers_Tip_R =      ( 1.4, 1.4, 1.0 )
    Bone_Fingers_Base_L =        ( 1.4, 1.4, 1.0 ) 
    Bone_Fingers_Tip_L =         ( 1.4, 1.4, 1.0 ) 

    Bone_Thigh_R =                  ( 1.2, 1.2, 1.0 )
    Bone_Thigh_L =                 ( 1.2, 1.2, 1.0 )
    
    Bone_Knee_R =                 ( 1.2, 1.2, 1.0 )
    Bone_Knee_L =                ( 1.2, 1.2, 1.0 )

    Bone_Ankle_R =                ( 1.2, 1.2, 1.0 )
    Bone_Ankle_L =               ( 1.2, 1.2, 1.0 ) 
    
    Bone_Toe_R=                 ( 1.3, 1.3, 1.0 ) 
    Bone_Toe_L =                ( 1.3, 1.3, 1.0 )

    Cloth_Breast =             ( 1.2, 1.2, 1.0 )
    Cloth_Hat =             ( 1.5, 1.5, 1.5 )
}

// baby mode
baby_scale_info = {
    scale = .4
    
    head =                      ( 2, 1.8, 1.8 )     ;X Y Z(length)
    jaw =                        (2, 1.8, 1.8 )
    mullet_cloth_zz =            ( 2, 1.8, 1.8 )

    /*dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    pelvis =                    ( 1.6, 1.6, 1.0 )
    stomach =                   ( 1.6, 1.6, 1.0 )
    chest =                     ( 1.6, 1.6, 1.0 )
    neck =                      ( 1.6, 1.6, 1.0 )

    breast_cloth_zz =           ( 1.0, 1.0, 1.0 )

    left_collar =               ( 2.0, 2.0, 1.0 )                                             
    left_bicep =                ( 1.6, 1.6, 1.0 )
    left_forearm =              ( 1.6, 1.6, 1.0 )
    left_wrist =                ( 1.6, 1.6, 1.0 )
    left_palm =                 ( 1.6, 1.6, 1.0 )
    left_thumb_base =           ( 1.6, 1.6, 1.0 )
    left_forefinger_base =      ( 1.6, 1.6, 1.0 )
    left_forefinger_tip =       ( 1.6, 1.6, 1.0 )
    left_fingers_base =         ( 1.6, 1.6, 1.0 )
    left_fingers_tip =          ( 1.6, 1.6, 1.0 )
    left_low_sleeve_cloth_zz =  ( 1.6, 1.6, 1.0 )
    
    left_top_sleeve_cloth_zz =  ( 1.6, 1.6, 1.0 )
    right_collar =              ( 1.6, 1.6, 1.0 )                                                   
    right_bicep =               ( 1.6, 1.6, 1.0 )                                                   
    right_forearm =             ( 1.6, 1.6, 1.0 )                                                  
    right_wrist =               ( 1.6, 1.6, 1.0 )                                                    
    right_palm =                ( 1.6, 1.6, 1.0 )                                                     
    right_thumb_base =          ( 1.6, 1.6, 1.0 )
    right_forefinger_base =     ( 1.6, 1.6, 1.0 )
    right_forefinger_tip =      ( 1.6, 1.6, 1.0 )
    right_fingers_base =        ( 1.6, 1.6, 1.0 )
    
    right_fingers_tip =          ( 1.6, 1.6, 1.0 )
    right_low_sleeve_cloth_zz =  ( 1.6, 1.6, 1.0 )
    right_top_sleeve_cloth_zz =  ( 1.6, 1.6, 1.0 )
        
   hood_cloth_zz =              ( 1.6, 1.6, 1.0 )
    */
    
    right_hip =                  ( 1.6, 1.6, 1.0 )
    right_knee =                 ( 1.6, 1.6, 1.0 )
    right_ankle =                ( 1.6, 1.6, 1.0 )
    right_toes =                 ( 1.6, 1.6, 1.0 )
    right_low_trouser_cloth_zz = ( 1.6, 1.6, 1.0 )
    right_top_trouser_cloth_zz = ( 1.6, 1.6, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.6, 1.6, 1.0 )
    left_hip =                  ( 1.6, 1.6, 1.0 )
    left_top_trouser_cloth_zz = ( 1.6, 1.6, 1.0 )
    left_knee =                 ( 1.6, 1.6, 1.0 )
    left_ankle =                ( 1.6, 1.6, 1.0 )
    left_toes =                 ( 1.6, 1.6, 1.0 )
    left_low_trouser_cloth_zz = ( 1.6, 1.6, 1.0 )
    ;Bone_Board_Root =               ( 1.38, 1.38, 1.0 )
    ;Bone_Board_Nose =         ( 1.38, 1.38, 1.0 )
    ;Bone_Board_Tail =          ( 1.38, 1.38, 1.0 )
}

// flathead mode
flathead_scale_info = {
    head =                      ( 4.0, 1.0, 4.0 )
    jaw =                       ( 4.0, 1.0, 4.0 )
}
Kidshoulder_scale_info = {
    left_collar =               ( 0.8, 0.8, 0.8 )
    right_collar =               ( 0.8, 0.8, 0.8 )
  }

// flathead2 mode
flathead2_scale_info = {
    head =                      ( 1.0, 4.0, 4.0 )
    jaw =                       ( 1.0, 4.0, 4.0 )
}

// bighead mode
bighead_scale_info = {
    head =                      ( 2.0, 2.0, 2.0 )
    jaw =                       ( 2.0, 2.0, 2.0 )
}

// GJ PATCH:  caballero's head is weighted to his neck instead of his head...
// we'll need to make a special case in bighead mode
caballero_bighead_scale_info = {
	neck = 						( 2.0, 2.0, 2.0 )
    jaw =                       ( 2.0, 2.0, 2.0 )
}

// fatass mode
fatass_scale_info = {
    head =                      ( 2.0, 2.0, 2.0 )
    jaw =                       ( 2.0, 2.0, 2.0 )
    right_hip =                 ( 2.0, 2.0, 1.0 )
    left_hip =                  ( 2.0, 2.0, 1.0 )
}

// bigfeet mode
bigfeet_scale_info = {
    left_ankle =                ( 2.0, 2.0, 1.0 )
    left_toes =                 ( 2.0, 2.0, 1.0 )
    right_ankle =               ( 2.0, 2.0, 1.0 )
    right_toes =                ( 2.0, 2.0, 1.0 )
}

// ralph mode
ralph_scale_info = {
    right_bicep =               ( 1.5, 1.5, 1.0 )
    right_forearm =             ( 2.0, 2.0, 1.0 )
    right_wrist =               ( 2.0, 2.0, 1.0 )
    right_fingers_base =        ( 2.0, 2.0, 1.0 )
}

// bigboard mode
bigboard_scale_info = {
    Bone_Board_Root =               ( 2.0, 2.0, 1.0 )
    Bone_Board_Nose =         ( 2.0, 2.0, 1.0 )
    Bone_Board_Tail =          ( 2.0, 2.0, 1.0 )
}

// hoverboard mode
hoverboard_scale_info = {
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 0.0, 0.0, 0.0 )
    Bone_Board_Tail =          ( 0.0, 0.0, 0.0 )
}

// balloon mode
balloon_scale_info = {
    Bone_Board_Root =               ( 2.0, 2.0, 2.0 )
    Bone_Board_Nose =         ( 2.0, 2.0, 2.0 )
    Bone_Board_Tail =          ( 2.0, 2.0, 2.0 )
}

// female stroller
stroller_scale_info = {
	right_collar =              ( 0.8, 1.0, 1.0 )
	left_collar =               ( 0.8, 1.0, 1.0 )
}
eddie_scale_info = {

    scale = 1.2
    head =                      ( 1.00, 1.00, 1.00 )
    jaw =                       ( 1.00, 1.00, 1.00 )
    mullet_cloth_zz =           ( 1.0, 1.0, 1.0 )
    
    dummy_scale_zz =            ( 1.0, 1.0, 1.0 )
    
    neck =                      ( 0.97, 0.97, 1.0 )  	;Head
    chest =                     ( 0.90, 0.90, 1.0 )
    stomach =                   ( 0.90, 0.90, 1.0 ) 
    pelvis =                    ( 0.95, 0.95, 1.0 )
    
    left_collar =               ( 0.85, 0.85, 1.0 )                                             
    right_collar =              ( 0.85, 0.85, 1.0 )

    left_bicep =                ( 0.90, 0.90, 1.0 )
    right_bicep =               ( 0.90, 0.90, 1.0 )
    
    left_forearm =              ( 0.90, 0.90, 1.0 )
    right_forearm =             ( 0.90, 0.90, 1.0 )
    
    left_wrist =                ( 1.0, 1.0, 1.0 )
    right_wrist =               ( 1.0, 1.0, 1.0 )
    
    left_palm =                 ( 1.0, 1.0, 1.0 )
    right_palm =                ( 1.0, 1.0, 1.0 )
    
    left_thumb_base =           ( 1.0, 1.0, 1.0 )
    left_forefinger_base =      ( 1.0, 1.0, 1.0 )
    left_forefinger_tip =       ( 1.0, 1.0, 1.0 )
    left_fingers_base =         ( 1.0, 1.0, 1.0 )
    left_fingers_tip =          ( 1.0, 1.0, 1.0 )
    right_thumb_base =          ( 1.0, 1.0, 1.0 )
    right_forefinger_base =     ( 1.0, 1.0, 1.0 )
    right_forefinger_tip =      ( 1.0, 1.0, 1.0 )
    right_fingers_base =        ( 1.0, 1.0, 1.0 ) 
    right_fingers_tip =         ( 1.0, 1.0, 1.0 )   

    left_low_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )    
    left_top_sleeve_cloth_zz =  ( 1.0, 1.0, 1.0 )
                                                       
    right_low_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_sleeve_cloth_zz = ( 1.0, 1.0, 1.0 )
    hood_cloth_zz =             ( 1.0, 1.0, 1.0 )
    
    left_hip =                  ( 0.80, 0.80, 1.0 )
    right_hip =                 ( 0.80, 0.80, 1.0 )
    
    left_knee =                 ( 0.90, 0.90, 1.0 )
    right_knee =                ( 0.90, 0.90, 1.0 )
    
    left_ankle =                ( 0.90, 0.90, 1.0 )
    right_ankle =               ( 0.90, 0.90, 1.0 )
    
    left_toes =                 ( 1.0, 1.0, 1.0 ) 
    right_toes =                ( 1.0, 1.0, 1.0 )
    
    right_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    right_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    shirt_tail_cloth_zz =       ( 1.0, 1.0, 1.0 )
    
    left_top_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    left_low_trouser_cloth_zz = ( 1.0, 1.0, 1.0 )
    
    Bone_Board_Root =               ( 1.0, 1.0, 1.0 )
    Bone_Board_Nose =         ( 1.0, 1.0, 1.0 )
    Bone_Board_Tail =          ( 1.0, 1.0, 1.0 )



}

