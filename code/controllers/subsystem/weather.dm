#define STARTUP_STAGE 1
#define MAIN_STAGE 2
#define WIND_DOWN_STAGE 3
#define END_STAGE 4

//Used for all kinds of weather, ex. lavaland ash storms.
SUBSYSTEM_DEF(weather)
	name = "Weather"
	flags = SS_BACKGROUND
	wait = 10
	runlevels = RUNLEVEL_GAME
	var/list/processing = list()
	var/list/elligble_weather = list()
	var/list/next_hit = list() //Used by barometers to know when the next storm is coming

	var/particles/weatherParticleEffect
	var/obj/weatherEffect

/datum/controller/subsystem/weather/fire()
	// process active weather
	for(var/V in processing)
		var/datum/weather/our_event = V
		for(var/mob/act_on as anything in GLOB.mob_living_list)
			if(our_event.can_weather_act(act_on))
				our_event.weather_act(act_on)

	// start random weather on relevant levels
	var/possible_weather = elligble_weather
	var/datum/weather/our_event = pickweight(possible_weather)
	run_weather(our_event)
	elligble_weather -= our_event
	var/randTime = rand(3000, 6000)
	next_hit = addtimer(CALLBACK(src, .proc/make_eligible, possible_weather), randTime + initial(our_event.weather_duration_upper), TIMER_UNIQUE|TIMER_STOPPABLE) //Around 5-10 minutes between weathers


//This has been mangled - currently only supports 1 weather effect serverwide so I can finish this
/datum/controller/subsystem/weather/Initialize(start_timeofday)
	for(var/V in subtypesof(/datum/weather))
		var/datum/weather/W = V
		var/probability = initial(W.probability)

		// any weather with a probability set may occur at random
		if (probability && SSmapping.map_config.particle_weather[W.target_trait])
			LAZYINITLIST(elligble_weather)
			elligble_weather[W] = probability
	return ..()

/datum/controller/subsystem/weather/proc/run_weather(datum/weather/weather_datum_type)
	if (istext(weather_datum_type))
		for (var/V in subtypesof(/datum/weather))
			var/datum/weather/W = V
			if (initial(W.name) == weather_datum_type)
				weather_datum_type = V
				break
	if (!ispath(weather_datum_type, /datum/weather))
		CRASH("run_weather called with invalid weather_datum_type: [weather_datum_type || "null"]")

	var/datum/weather/W = new weather_datum_type()
	W.start()
	if(W.particleEffectType)
		SetWeatherParticleEffect(new W.particleEffectType);

/datum/controller/subsystem/weather/proc/make_eligible(possible_weather)
	elligble_weather = possible_weather
	next_hit = null

/datum/controller/subsystem/weather/proc/getweatherEffect()
	if(!weatherEffect)
		weatherEffect = new /obj()
		weatherEffect.particles = weatherParticleEffect
		weatherEffect.filters += filter(type="alpha", render_source=WEATHER_RENDER_TARGET)
	return weatherEffect

/datum/controller/subsystem/weather/proc/SetWeatherParticleEffect(particles/P)
	weatherParticleEffect = P
	weatherEffect.particles = weatherParticleEffect
