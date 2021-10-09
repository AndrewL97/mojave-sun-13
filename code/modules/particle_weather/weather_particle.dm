/particles/weather
	spawning = 0
	var/wind = 0 //Left/Right maximum movement increase per tick
	var/maxSpawning = 0 //Max spawner - Recommend you use this over Spawning, so severity can ease it in
	var/minSpawning = 0 //Weather should start with 0, but when easing, it will never go below this
	icon = 'icons/effects/particles/particle.dmi'


	spawning = 0
	width                  = 800  // I think this is supposed to be in pixels, but it doesn't match bounds, so idk - 800x800 seems to prevent particle-less edges
	height                 = 800
	count                  = 2500 // 2500 particles
	//Set bounds to rough screensize + some sideways movement for "wind"
	bound1                 = list(-1000,-256,0)
	bound2                 = list(1000,256,100)
	lifespan               = 600  // live for 60s max
	fade                   = 0    // no fade

//Animate particle effect to a severity - a value between 0 and 100
/particles/weather/proc/animateSeverity(severity = 50, minSeverity = 0, maxSeverity = 100)

	//If we have no severity, just stop spawning
	if(!severity)
		spawning = 0
		return

	//restrict to 0-100 - get as percentage
	severity = max(min(severity,maxSeverity),minSeverity) / 100

	var newWind = wind * severity * pick(-1,1) //Wind can go left OR right!
	var newSpawning = minSpawning + ((maxSeverity-minSeverity) * severity)

	//gravity might be x, xy, or xyz
	var/newGravity = gravity
	if(length(newGravity))
		newGravity[1] = newWind
	else
		newGravity = list(newWind)

	//The higher the severity, the faster the change - elastic easing for flappy wind
	gravity = newGravity
	spawning = newSpawning
	// animate(src, gravity=newGravity, spawning=newSpawning, time=1/severity * 10, easing=ELASTIC_EASING)
