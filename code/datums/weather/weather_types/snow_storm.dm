/datum/weather/snow_storm
	name = "snow storm"
	desc = "This area enjoys the occasional gentle snowfall."
	probability = 90

	telegraph_message = "<span class='warning'>It is snowing! How delightful.</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_snow"

	weather_message = "<span class='userdanger'><i>Harsh winds pick up as dense snow begins to fall from the sky! Seek shelter!</i></span>"
	weather_overlay = "snow_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='boldannounce'>The snowfall dies down, it should be safe to go outside again.</span>"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_SNOWSTORM

	immunity_type = WEATHER_SNOW

	barometer_predictable = TRUE


/datum/weather/snow_storm/weather_act(mob/living/L)
	L.adjust_bodytemperature(-rand(5,15))

