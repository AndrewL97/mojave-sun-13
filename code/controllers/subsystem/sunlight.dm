//TODO: Change verbiage to outdoor_effects rather than sunlight
/datum/time_of_day
	var/name = ""
	var/color = ""
	var/start = 216000 // 6:00 am


// /datum/time_of_day/Midnight_am
//  name = "Midnight AM"
//  color = "#050d29"
//  start = "0" //12:00:00 AM

/datum/time_of_day/Dawn
 name = "Dawn"
 color = "#31211b"
 start = 4 HOURS //4:00:00 AM

/datum/time_of_day/Sunrise
 name = "Sunrise"
 color = "#F598AB"
 start = 5 HOURS  //5:00:00 AM

/datum/time_of_day/Daytime
 name = "Daytime"
 color = "#FFFFFF"
 start = 5.5 HOURS //5:30:00 AM

/datum/time_of_day/Sunset
 name = "Sunset"
 color = "#ff8a63"
 start = 19 HOURS //7:00:00 PM

/datum/time_of_day/Dusk
 name = "Dusk"
 color = "#221f33"
 start = 19.5 HOURS //7:30:00 PM

/datum/time_of_day/Midnight
 name = "Midnight"
 color = "#000032"
 start = 20 HOURS //8:00:00 PM


GLOBAL_VAR_INIT(GLOBAL_LIGHT_RANGE, 5)
GLOBAL_LIST_EMPTY(SUNLIGHT_QUEUE_WORK)   /* turfs to be stateChecked */
GLOBAL_LIST_EMPTY(SUNLIGHT_QUEUE_UPDATE) /* turfs to have their colours updated via corners (filter out the unroofed dudes) */
GLOBAL_LIST_EMPTY(SUNLIGHT_QUEUE_CORNER) /* turfs to have their colour/lights/etc updated */
GLOBAL_LIST_EMPTY(outdoor_effects)

SUBSYSTEM_DEF(outdoor_effects)
	name = "Sunlight"
	wait = LIGHTING_INTERVAL
	flags = SS_TICKER
	init_order = INIT_ORDER_SUNLIGHT

	/* thanks ruskis */
	var/datum/time_of_day/current_step_datum
	var/datum/time_of_day/next_step_datum

	var/obj/sunlightEffect

	var/list/mutable_appearance/sunlight_overlays
	var/list/atom/movable/screen/fullscreen/weather/weather_planes_need_vis = list()
	var/list/atom/movable/screen/fullscreen/lighting_backdrop/Sunlight/sunlight_planes_need_vis = list()

	//Ensure midnight is the liast step
	var/list/datum/time_of_day/time_cycle_steps = list(new /datum/time_of_day/Dawn(),
	                                                   new /datum/time_of_day/Sunrise(),
	                                                   new /datum/time_of_day/Daytime(),
	                                                   new /datum/time_of_day/Sunset(),
	                                                   new /datum/time_of_day/Dusk(),
	                                                   new /datum/time_of_day/Midnight())



/datum/controller/subsystem/outdoor_effects/stat_entry(msg)
	msg = "W:[GLOB.SUNLIGHT_QUEUE_WORK.len]|U:[GLOB.SUNLIGHT_QUEUE_UPDATE.len]|C:[GLOB.SUNLIGHT_QUEUE_CORNER.len]"
	return ..()

/datum/controller/subsystem/outdoor_effects/proc/fullPlonk()
	for (var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
		for (var/turf/T in block(locate(1,1,z), locate(world.maxx,world.maxy,z)))
			var/area/TArea = T.loc
			if (TArea.static_lighting)
				GLOB.SUNLIGHT_QUEUE_WORK += T

/datum/controller/subsystem/outdoor_effects/Initialize(timeofday)
	if(!initialized)
		get_time_of_day()
		InitializeTurfs()
		initialized = TRUE
	fire(FALSE, TRUE)
	..()

// It's safe to pass a list of non-turfs to this list - it'll only check turfs.
/* This is the proc that starts the crash loop. Maybe log what passes through it?
	-Thooloo
	*/
/datum/controller/subsystem/outdoor_effects/proc/InitializeTurfs(list/targets)
	for (var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
		for (var/turf/T in block(locate(1,1,z), locate(world.maxx,world.maxy,z)))
			var/area/TArea = T.loc
			if (TArea.static_lighting)
				GLOB.SUNLIGHT_QUEUE_WORK += T


/datum/controller/subsystem/outdoor_effects/proc/check_cycle()
	if(station_time() > next_step_datum.start)
		get_time_of_day()
		return TRUE
	return FALSE

/datum/controller/subsystem/outdoor_effects/proc/get_time_of_day()

	//Get the next time step (first time where NOW > START_TIME)
	//If we don't find one - grab the LAST time step (which should be midnight)
	var/time = station_time()
	var/datum/time_of_day/new_step = null

	for(var/i in 1 to length(time_cycle_steps))
		if(time >= time_cycle_steps[i].start)
			new_step = time_cycle_steps[i]
			next_step_datum = i == length(time_cycle_steps) ? time_cycle_steps[1] : time_cycle_steps[i + 1]

	//New time is the last time step in list (midnight) - next time will be the first step
	if(!new_step)
		new_step = time_cycle_steps[length(time_cycle_steps)]
		next_step_datum = time_cycle_steps[1]

	current_step_datum = new_step

/* set sunlight colour + add weather effect to clients */
/datum/controller/subsystem/outdoor_effects/fire(resumed, init_tick_checks)
	MC_SPLIT_TICK_INIT(3)
	if(!init_tick_checks)
		MC_SPLIT_TICK
	var/i = 0

	//Add our weather particle obj to any new weather screens
	if(SSParticleWeather.initialized)
		for (i in 1 to weather_planes_need_vis.len)
			var/atom/movable/screen/fullscreen/weather/W = weather_planes_need_vis[i]
			if(W)
				W.vis_contents = list(SSParticleWeather.getweatherEffect())
			if(init_tick_checks)
				CHECK_TICK
			else if (MC_TICK_CHECK)
				break
		if (i)
			weather_planes_need_vis.Cut(1, i+1)
			i = 0

	//Add our sunlight obj to any new sunlight screens
	for (i in 1 to sunlight_planes_need_vis.len)
		var/atom/movable/screen/fullscreen/lighting_backdrop/Sunlight/S = sunlight_planes_need_vis[i]
		if(S)
			S.vis_contents = list(getSunlightEffect())
		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if (i)
		sunlight_planes_need_vis.Cut(1, i+1)
		i = 0

	for (i in 1 to GLOB.SUNLIGHT_QUEUE_WORK.len)
		var/turf/T = GLOB.SUNLIGHT_QUEUE_WORK[i]
		if(T)
			T.GetSkyAndWeatherStates() //TODO: Rename to "GetOutdoorState"
			if(T.outdoor_effect)
				GLOB.SUNLIGHT_QUEUE_UPDATE += T.outdoor_effect

		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if (i)
		GLOB.SUNLIGHT_QUEUE_WORK.Cut(1, i+1)
		i = 0


	if(!init_tick_checks)
		MC_SPLIT_TICK

	for (i in 1 to GLOB.SUNLIGHT_QUEUE_UPDATE.len)
		var/atom/movable/outdoor_effect/U = GLOB.SUNLIGHT_QUEUE_UPDATE[i]
		if(U)
			U.ProcessState()
			if(U.state != SKY_BLOCKED)
				UpdateAppearance(U)

		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break
	if (i)
		GLOB.SUNLIGHT_QUEUE_UPDATE.Cut(1, i+1)
		i = 0


	if(!init_tick_checks)
		MC_SPLIT_TICK

	for (i in 1 to GLOB.SUNLIGHT_QUEUE_CORNER.len)
		var/turf/T = GLOB.SUNLIGHT_QUEUE_CORNER[i]
		var/atom/movable/outdoor_effect/U = T.outdoor_effect

		/* if we haven't initialized but we are affected, create new and check state */
		if(!U)
			T.outdoor_effect = new /atom/movable/outdoor_effect(T)
			T.GetSkyAndWeatherStates()
			U = T.outdoor_effect

			/* in case we aren't indoor somehow, wack us into the proc queue, we will be skipped on next indoor check */
			if(U.state != SKY_BLOCKED)
				GLOB.SUNLIGHT_QUEUE_UPDATE += T.outdoor_effect

		if(U.state != SKY_BLOCKED)
			continue

		//This might need to be run more liberally
		UpdateAppearance(U)


		if(init_tick_checks)
			CHECK_TICK
		else if (MC_TICK_CHECK)
			break

	if (i)
		GLOB.SUNLIGHT_QUEUE_CORNER.Cut(1, i+1)
		i = 0

	if(check_cycle())
		nextBracket()

/datum/controller/subsystem/outdoor_effects/proc/getSunlightEffect()
	if(!sunlightEffect)
		sunlightEffect = new /obj()
		sunlightEffect.icon = 'icons/hud/screen_gen.dmi'
		sunlightEffect.screen_loc = "WEST,SOUTH to EAST,NORTH"
		sunlightEffect.icon_state = "flash"
	return sunlightEffect

/datum/controller/subsystem/outdoor_effects/proc/nextBracket()
	/* transistion in an hour or time diff, whichever is smaller */
	var timeDiff = min((1 HOURS / SSticker.station_time_rate_multiplier ),daytimeDiff(current_step_datum.start, next_step_datum.start))
	animate(getSunlightEffect(),color=current_step_datum.color, time = timeDiff)

// Updates overlays and vis_contents for outdoor effects
/datum/controller/subsystem/outdoor_effects/proc/UpdateAppearance(atom/movable/outdoor_effect/OE)

	var/mutable_appearance/MA
	if (OE.state != SKY_BLOCKED)
		MA = GetOverlay(1,1,1,1) /* fully lit */
	else //Indoor - do proper corner checks
		/* check if we are globally affected or not */
		var/static/datum/lighting_corner/dummy/dummy_lighting_corner = new

		var/datum/lighting_corner/cr = OE.source_turf.lighting_corner_SW || dummy_lighting_corner
		var/datum/lighting_corner/cg = OE.source_turf.lighting_corner_SE || dummy_lighting_corner
		var/datum/lighting_corner/cb = OE.source_turf.lighting_corner_NW || dummy_lighting_corner
		var/datum/lighting_corner/ca = OE.source_turf.lighting_corner_NE || dummy_lighting_corner

		var/fr = cr.sunFalloff
		var/fg = cg.sunFalloff
		var/fb = cb.sunFalloff
		var/fa = ca.sunFalloff

		MA = GetOverlay(fr, fg, fb, fa)

	OE.sunlight_overlay = MA
	//Get weather overlay if not weatherproof
	OE.overlays = OE.weatherproof ? list(OE.sunlight_overlay, getWeatherOverlay()) : list(OE.sunlight_overlay)
	OE.luminosity = MA.luminosity

//Retrieve an overlay from the list - create if necessary
/datum/controller/subsystem/outdoor_effects/proc/GetOverlay(fr, fg, fb, fa)

	var/index = "[fr]|[fg]|[fb]|[fa]"
	LAZYINITLIST(sunlight_overlays)
	if(!sunlight_overlays[index])
		sunlight_overlays[index] = CreateOverlay(fr, fg, fb, fa)
	return sunlight_overlays[index]

//TODO Rather than having sunlight and weather - just have two planes, one for indoor and one for outdoor
/datum/controller/subsystem/outdoor_effects/proc/getWeatherOverlay()
	var/mutable_appearance/MA = new /mutable_appearance()
	MA.blend_mode   	  = BLEND_OVERLAY
	MA.icon 			  = 'icons/effects/weather_overlay.dmi'
	MA.icon_state 		  = "weather_overlay"
	MA.pixel_x            = -16 //Weather_overlay is 64x64 to overlap walls, etc. so center it
	MA.pixel_y            = -16
	MA.plane			  = WEATHER_PLANE /* we put this on a lower level than lighting so we dont multiply anything */
	MA.invisibility 	  = INVISIBILITY_LIGHTING
	return MA

//Create an overlay appearance from corner values
/datum/controller/subsystem/outdoor_effects/proc/CreateOverlay(fr, fg, fb, fa)

	var/mutable_appearance/MA = new /mutable_appearance()

	MA.blend_mode   = BLEND_OVERLAY
	MA.icon		 = LIGHTING_ICON
	MA.icon_state   = null
	MA.plane		= SUNLIGHTING_PLANE /* we put this on a lower level than lighting so we dont multiply anything */
	MA.invisibility = INVISIBILITY_LIGHTING


	//MA gets applied as an overlay, but we pull luminosity out to set our outdoor_effect object's lum
	#if LIGHTING_SOFT_THRESHOLD != 0
	MA.luminosity = max(fr, fg, fb, fa) > LIGHTING_SOFT_THRESHOLD
	#else
	MA.luminosity = max(fr, fg, fb, fa) > 1e-6
	#endif

	if((fr & fg & fb & fa) && (fr + fg + fb + fa == 4)) /* this will likely never happen */
		MA.color = LIGHTING_BASE_MATRIX
	else if(!MA.luminosity)
		MA.color = SUNLIGHT_DARK_MATRIX
	else
		MA.color = list(
					fr, fr, fr,  00 ,
					fg, fg, fg,  00 ,
					fb, fb, fb,  00 ,
					fa, fa, fa,  00 ,
					00, 00, 00,  01 )
	return MA

#undef STEP_MORNING
#undef STEP_DAY
#undef STEP_EVENING
#undef STEP_NIGHT

