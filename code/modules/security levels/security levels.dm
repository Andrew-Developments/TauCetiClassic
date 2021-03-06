/var/security_level = 0
//0 = code green
//1 = code blue
//2 = code red
//3 = code delta

//config.alert_desc_blue_downto

/proc/set_security_level(level)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("delta")
			level = SEC_LEVEL_DELTA

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != security_level)
		switch(level)
			if(SEC_LEVEL_GREEN)
				to_chat(world, "<font size=4 color='red'>Attention! Security level lowered to green</font>")
				to_chat(world, "<font color='red'>[config.alert_desc_green]</font>")
				security_level = SEC_LEVEL_GREEN
				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION || FA.z == ZLEVEL_ASTEROID)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_green")
			if(SEC_LEVEL_BLUE)
				if(security_level < SEC_LEVEL_BLUE)
					to_chat(world, "<font size=4 color='red'>Attention! Security level elevated to blue</font>")
					to_chat(world, "<font color='red'>[config.alert_desc_blue_upto]</font>")
				else
					to_chat(world, "<font size=4 color='red'>Attention! Security level lowered to blue</font>")
					to_chat(world, "<font color='red'>[config.alert_desc_blue_downto]</font>")
				security_level = SEC_LEVEL_BLUE
				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION || FA.z == ZLEVEL_ASTEROID)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_blue")
			if(SEC_LEVEL_RED)
				if(security_level < SEC_LEVEL_RED)
					to_chat(world, "<font size=4 color='red'>Attention! Code red!</font>")
					to_chat(world, "<font color='red'>[config.alert_desc_red_upto]</font>")
				else
					to_chat(world, "<font size=4 color='red'>Attention! Code red!</font>")
					to_chat(world, "<font color='red'>[config.alert_desc_red_downto]</font>")
				security_level = SEC_LEVEL_RED

				var/obj/machinery/computer/communications/CC = locate(/obj/machinery/computer/communications,world)
				if(CC)
					CC.post_status("alert", "redalert")

				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION || FA.z == ZLEVEL_ASTEROID)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_red")

			if(SEC_LEVEL_DELTA)
				to_chat(world, "<font size=4 color='red'>Attention! Delta security level reached!</font>")
				to_chat(world, "<font color='red'>[config.alert_desc_delta]</font>")
				security_level = SEC_LEVEL_DELTA
				for(var/obj/machinery/firealarm/FA in machines)
					if(FA.z == ZLEVEL_STATION || FA.z == ZLEVEL_ASTEROID)
						FA.overlays = list()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_delta")
		/*if(security_level == SEC_LEVEL_RED)
			red_alert_code = 1
			for(var/area/A in world)
				if(istype(A, /area/hallway))
					A.readyalert()
		else
			red_alert_code = 0
			for(var/area/A in world)
				if(istype(A, /area/hallway))
					A.readyreset()*/
	else
		return

/proc/get_security_level()
	switch(security_level)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/num2seclevel(num)
	switch(num)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/seclevel2num(seclevel)
	switch( lowertext(seclevel) )
		if("green")
			return SEC_LEVEL_GREEN
		if("blue")
			return SEC_LEVEL_BLUE
		if("red")
			return SEC_LEVEL_RED
		if("delta")
			return SEC_LEVEL_DELTA


/*DEBUG
/mob/verb/set_thing0()
	set_security_level(0)
/mob/verb/set_thing1()
	set_security_level(1)
/mob/verb/set_thing2()
	set_security_level(2)
/mob/verb/set_thing3()
	set_security_level(3)
*/
