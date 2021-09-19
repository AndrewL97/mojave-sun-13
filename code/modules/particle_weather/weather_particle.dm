/particles/weather
	spawning = 0
	var wind = 0 //Left/Right maximum movement increase per tick
	var maxSpawning = 0 //Max spawner - Recommend you use this over Spawning, so severity can ease it in
	var minSpawning = 0 //Weather should start with 0, but when easing, it will never go below this



	spawning = 0

//Animate particle effect to a severity - a value between 0 and 100
/particles/weather/proc/animateSeverity(severity = 50, maxSeverity = 0, minSeverity = 100)
	//restrict to 0-100 - get as percentage
	severity = max(min(severity,maxSeverity),minSeverity) / 100

	var newWind = wind * severity * pick(-1,1) //Wind can go left OR right!
	var newSpawning = max(maxSpawning * severity, minSpawning)

	//gravity might be x, xy, or xyz
	var/newGravity = gravity
	if(length(newGravity))
		newGravity[1] = newWind
	else
		newGravity = list(newWind)

	//The higher the severity, the faster the change - elastic easing for flappy wind
	animate(src, gravity=newGravity, spawning=newSpawning, time=1/severity * 10, easing=ELASTIC_EASING)
