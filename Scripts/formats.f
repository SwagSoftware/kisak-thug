

<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(railnode) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>
	{ComponentName=RailType DataType=Checksum Equals(Generic Metal Concrete Wood)}


<EndFormat>


<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(skater) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>
    {ComponentName=CreatedAtStart DataType=Checksum}
	{ComponentName=Height DataType=Integer Range( 600 ,760) }
	{ComponentName=Weight DataType=Integer Range(10,200) }
    {ComponentName=Color DataType=Checksum Equals(Blue Red Green Yellow) }
	{ComponentName=Speed DataType=Integer Range(10,200) }

<EndFormat>



<StartFormat>

<Conditions>
	{ComponentName=Class DataType=Checksum Equals(vehicle) }    

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>
    {ComponentName=CreatedAtStart DataType=Checksum}
	{ComponentName=Model DataType=String Equals(
         "firetruck"
         "icecreamtruck"
         "police_car"
         "buick_blue"
         "buick_brown"
         "buick_gold"
         "buick_green"
         "oldsbeige"
         "oldsblue"
         "oldsgold"
         "oldsgreen"
         "oldsred"
         "pickup_black"
         "pickup_blue"
         "pickup_purpl"
         "pickup_red"
         "pickup_white"
         "bullet_train_a"
         "bullet_train_b"
         "plane_jet"
         "van_looter"
         "b1boat"
         "tugboat"
         "submarine"
         "2cv_blue"
         "2cv_green"
         "2cv_grey"
         "2cv_red"
         "2cv_yellow"
         "microbus_blue"
         "microbus_green"
         "microbus_grey"
         "microbus_orange"
         "microbus_purpl"
         "lux_car_blue"
         "low_rider"
         "buick_test"
         "bx_black"
         "bx_blue"
         "bx_brown"
         "bx_green"
         "bx_red"
         "police_car_canada"
         "policecar_paris"
         "policecar_rio"
         "wagon01"
         "airport_kart01"
         "airport_kart02"
         "airport_tanker"
         "airport_tanker02"
		"ap_plane_jet"
         "snowmobile01"
         "snowmobile02"
         "snowmobile03"
         "snowmobile04"
         "rio_bus"
         "light_airplane01"
         "ap_lugakart01"
    )}
    {ComponentName=speedlimit		DataType=Float Range(1,66666666)}
    {ComponentName=acceleration 	DataType=Float Range(1,66666666)}
    {ComponentName=deceleration 	DataType=Float Range(1,66666666)}
    {ComponentName=emergencydecel  	DataType=Float Range(1,66666666)}
    {ComponentName=heightoffset  	DataType=Float Range(-600,600)}
    {ComponentName=turndist         DataType=Float Range(1,666)}
    {ComponentName=stophere         DataType=Float Range(0,66666)}
    {ComponentName=minstopvel       DataType=Float Range(0.1,6666666)}
    {ComponentName=stopdist         DataType=Float Range(0.1,66666666)}
<EndFormat>

<StartFormat>

<Conditions>
	{ComponentName=Class DataType=Checksum Equals(pedestrian) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>
    {ComponentName=CreatedAtStart DataType=Checksum}
	{ComponentName=Model DataType=String Equals(
         "pedestrian_a"
         "pedestrian_b"
         "pedestrian_c"
         "pedestrian_d"
         "ped_bbq_guy"
         "ped_surf_a"
         "ped_terrorist_a"
         "ped_canada_a"
         "ped_canada_b"
         "ped_canada_c"
         "ped_canada_d"
         "ped_bully_a"
         "ped_bum_a"
         "pedpro_cab"
         "pedpro_campbell"
         "pedpro_glifberg"
         "pedpro_hawk"
         "pedpro_koston"
         "pedpro_lasek"
         "pedpro_margera"
         "pedpro_mullen"
         "pedpro_muska"
         "pedpro_reynolds"
         "pedpro_rowley"
         "pedpro_steamer"
         "pedpro_thomas"
         "ped_constr_a"
         "ped_constr_b"
		"pedfem_a"
		"pedfem_b"
		"pedfem_c"
		"pedfem_d"
		"pedfem_e"
		"pedfem_f"
		"ped_photoguy_a"
		"ped_welder_a"
		"ped_welder_b"
         "ped_thinman_a"
         "ped_thinman_axe"
         "ped_security_a"
         "ped_security_b"
         "ped_richkid_a"
         "ped_judge_a"
         "ped_judge_b"
         "ped_judge_c"
         "ped_judge_d"
         "ped_judge_e"
         "ped_skateshop"
         "ped_pirate_a"
    )}
    {ComponentName=speedlimit		DataType=Float Range(0.1,50)}
    {ComponentName=acceleration 	DataType=Float Range(0.1,30)}
    {ComponentName=deceleration 	DataType=Float Range(0.11,30)}
    {ComponentName=heightoffset  	DataType=Float Range(-50,50)}
    {ComponentName=turndist         DataType=Float Range(1,666)}
    {ComponentName=stophere         DataType=Float Range(0,66666)}
    {ComponentName=stopdist         DataType=Float Range(0.1,40)}
<EndFormat>


<StartFormat>

   <Conditions>
   	{ComponentName=Class DataType=Checksum Equals(AnimatingObject) }
      
   <Compulsory>
       {ComponentName=Position DataType=Vector}
       {ComponentName=Angles DataType=Vector}
       
   <Optional>
       {ComponentName=CreatedAtStart DataType=Checksum}
   	{ComponentName=Model DataType=String Equals(
            "bird_a"
            "bird_a_resting"
            "bird_b"
            "bird_b_resting"
            "shark_a"
            "crowd_a"
            "crowd_b"
            "crowd_c"
            "crowd_d"
            "crowd_judge_a"
            "crowd_judge_b"
       )}
       
<EndFormat>


<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(waypoint) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>
    {ComponentName=speedlimit		DataType=Float Range(1,200)}
    {ComponentName=acceleration 	DataType=Float Range(1,30)}
    {ComponentName=deceleration 	DataType=Float Range(1,30)}
    {ComponentName=emergencydecel  	DataType=Float Range(1,100)}
    {ComponentName=heightoffset  	DataType=Float Range(-50,50)}
    {ComponentName=turndist         DataType=Float Range(1,666)}
    {ComponentName=stophere         DataType=Float Range(0,66666)}
    {ComponentName=minstopvel       DataType=Float Range(0.1,40)}
    {ComponentName=stopdist         DataType=Float Range(0.1,40)}
<EndFormat>


<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(VUTestObject) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>

<EndFormat>


<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(cas_submesh) }
    
<Compulsory>

<Optional>
    {ComponentName=ExportName DataType=String}    
    {ComponentName=RemovalFlags DataType=Array}
      
<EndFormat>

<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(Trigger) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>

<EndFormat>

<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(GameObject) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>

<EndFormat>



<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(EnvironmentObject) }

<Compulsory>
    {ComponentName=Name DataType=Checksum}

<Optional>

<EndFormat>



<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(ProximNode) }

<Compulsory>
    {ComponentName=Name DataType=Checksum}

<Optional>

<EndFormat>



<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(restart) }

<Compulsory>
    {ComponentName=Position DataType=Vector}
    {ComponentName=Angles DataType=Vector}

<Optional>
	{ComponentName=Type DataType=Checksum Equals(Generic Player1 Player2 Horse Multiplayer UserDefined)}


<EndFormat>


<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(ScriptedCamera) }

<Compulsory>

<Optional>

<EndFormat>



<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(TrickObject) }

<Compulsory>

<Optional>

<EndFormat>


<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(BouncyObject) }

<Compulsory>

<Optional>

<EndFormat>

      
<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(GenericNode) }

<Compulsory>

<Optional>

<EndFormat>


<StartFormat>

<Conditions>
    {ComponentName=Class DataType=Checksum Equals(Crown) }

<Compulsory>

<Optional>

<EndFormat>
      
      