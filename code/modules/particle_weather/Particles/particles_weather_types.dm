//I am a developer not artiste





//Rain - goes down
/particles/weather/rain
	width                  = 800  // I think this is supposed to be in pixels, but it doesn't match bounds, so idk - 800x800 seems to prevent particle-less edges
	height                 = 800
	count                  = 2500 // 2500 particles
	//Set bounds to rough screensize + some sideways movement for "wind"
	bound1                 = list(-1000,-256,-100)
	bound2                 = list(1000,256,100)
	lifespan               = 100  // live for 50s max
	fade                   = 0    // no fade
	//General appearance
	icon                   = 'icons/effects/weather_effects.dmi'
	icon_state             = "particle_drop"
	color                  = "#ccffff"
	// There is an issue with BOX where it spawns like a vector, so update this when Lum fixes it - Otherwise spawn at the top of the screen with some overlap on each side to account for wind
	position               = generator("vector", list(-1000,256,50), list(1000,256,50))
	//Some slight randomness in size to make some drops bigger
	scale                  = generator("vector", list(1,0.5), list(1.5,3))

	// control how the rain falls
	gravity                = list(2,-10)
	drift                  = generator("vector", list(-1,-1), list(1,1)) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s

	//Weather effects, max values
	maxSpawning           = 100
	minSpawning           = 20
	wind                  = 4
