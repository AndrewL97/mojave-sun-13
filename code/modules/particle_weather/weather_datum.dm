/**
 * Causes weather to occur on a z level in certain area types
 *
 * The effects of weather occur across an entire z-level. For instance, lavaland has periodic ash storms that scorch most unprotected creatures.
 * Weather always occurs on different z levels at different times, regardless of weather type.
 * Can have custom durations, targets, and can automatically protect indoor areas.
 *
 */


/datum/weather

	// ==== Modify these ====

	/// name of weather
	var/name = "space wind"
	/// description of weather
	var/desc = "Heavy gusts of wind blanket the area, periodically knocking down anyone caught in the open."

	// Sounds to play at different severities - order from lowest to highest
	var/list/weather_sounds = list()

	//Our particle effect to display - min/max severity effects its wind and count
	var/particles/weather/particleEffectType = /particles/weather/rain

	/// In deciseconds, how long the weather lasts once it begins
	var/weather_duration = 1200
	/// See above - this is the lowest possible duration
	var/weather_duration_lower = 1200
	/// See above - this is the highest possible duration
	var/weather_duration_upper = 1500
	// Keep this between 1 and 100
	// Gentle rain shouldn't use the max rain wind speed, nor should a storm be a gentle breeze
	var/minSeverity = 1
	var/maxSeverity = 100
	//We will increase or decrease our severity by a random amount up to this value
	//If 0, we will pick a random value between min and max
	var/maxSeverityChange = 20
	//The number of times we will change our severity over the duration
	var/severitySteps = 5
	/// Used by mobs to prevent them from being affected by the weather
	var/immunity_type = WEATHER_STORM
	/// Weight amongst other eligible weather. If zero, will never happen randomly.
	var/probability = 0

	/// The map weather type to target
	var/target_trait = PARTICLEWEATHER_RAIN

	// ==== Dont modify these ====

	//Times we have stepped severity
	var/severityStepsTaken = 0


	//Current severity - used for scaling effects, particle appearance, etc.
	var/severity

	/// Whether a barometer can predict when the weather will happen
	var/barometer_predictable = FALSE
	/// For barometers to know when the next storm will hit
	var/next_hit_time = 0

/**
 * Starts the actual weather and effects from it
 *
 * Updates area overlays and sends sounds and messages to mobs to notify them
 * Begins dealing effects from weather to mobs in the area
 *
 */
/datum/weather/proc/start()
	SEND_GLOBAL_SIGNAL(COMSIG_WEATHER_START(type))
	addtimer(CALLBACK(src, .proc/wind_down), weather_duration)

	//Always step severity to start
	addtimer(CALLBACK(src, .proc/ChangeSeverity), weather_duration / severitySteps)


/datum/weather/proc/ChangeSeverity()
	severityStepsTaken++

	if(maxSeverityChange == 0)
		severity = rand(minSeverity, maxSeverity)
	else
		var/newSeverity = severity + rand(-maxSeverityChange,maxSeverityChange)
		newSeverity = min(max(newSeverity,minSeverity), maxSeverity)
		severity = newSeverity

	for (var/z_level in SSmapping.levels_by_trait(ZTRAIT_STATION))
		for(var/mob/player as anything in SSmobs.clients_by_zlevel[z_level])
			var/turf/mob_turf = get_turf(player)
			if(!mob_turf)
				continue
			var/tempSound = scale_range_pick(100,severity,weather_sounds)
			if(tempSound)
				SEND_SOUND(player, sound(tempSound))

	if(SSParticleWeather.particleEffect)
		SSParticleWeather.particleEffect.animateSeverity(severity)

	//Tick on
	if(severityStepsTaken < severitySteps)
		addtimer(CALLBACK(src, .proc/ChangeSeverity), weather_duration / severitySteps)


/**
 * Weather enters the winding down phase, stops effects
 *
 * Updates areas to be in the winding down phase
 * Sends sounds and messages to mobs to notify them
 *
 */
/datum/weather/proc/wind_down()

	severity = 0
	if(SSParticleWeather.particleEffect)
		SSParticleWeather.particleEffect.animateSeverity(severity)
	SEND_GLOBAL_SIGNAL(COMSIG_WEATHER_END(type))
	STOP_PROCESSING(SSParticleWeather, src)


/**
 * Fully ends the weather
 *
 * Effects no longer occur and particles are wound down
 * Removes weather from processing completely
 *
 */
/datum/weather/proc/end()

/**
 * Returns TRUE if the living mob can be affected by the weather
 *
 */
/datum/weather/proc/can_weather_act(mob/living/mob_to_check)
	var/turf/mob_turf = get_turf(mob_to_check)

	if(!mob_turf)
		return

	if(!(mob_turf.z in SSmapping.levels_by_trait(ZTRAIT_STATION)))
		return

	if(istype(mob_to_check.loc, /obj/structure/closet))
		var/obj/structure/closet/current_locker = mob_to_check.loc
		if(current_locker.weather_protection)
			if((immunity_type in current_locker.weather_protection) || (WEATHER_ALL in current_locker.weather_protection))
				return

	if((immunity_type in mob_to_check.weather_immunities) || (WEATHER_ALL in mob_to_check.weather_immunities))
		return

	if(mob_turf.outdoor_effect || mob_turf.outdoor_effect.state == SUNLIGHT_INDOOR)
		return

	return TRUE

/**
 * Affects the mob with whatever the weather does
 *
 */
/datum/weather/proc/weather_act(mob/living/L)
	return
