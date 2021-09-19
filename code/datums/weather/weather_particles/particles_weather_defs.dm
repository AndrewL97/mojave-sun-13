/particles/weather
	var wind = 0 //Left/Right maximum movement increase per tick
	var maxCount = 0 //Max count - Recommend you use this over Count, so severity can ease it in
	var minCount = 0 //Weather should start with 0, but when easing, it will never go below this



	count = 0

//Animate particle effect to a severity - a value between 0 and 100
/particles/weather/proc/animateSeverity(severity = 50)
	//restrict to 0-100 - get as percentage
	severity = max(min(severity,maxSeverity),minSeverity) / 100

	var newWind = wind * severity * pick(-1,1) //Wind can go left OR right!
	var newCount = max(maxCount * severity, minCount)

	//gravity might be x, xy, or xyz
	var/newGravity = gravity
	if(length(newGravity))
		newGravity[1] = newWind
	else
		newGravity = list(newWind)

	//The higher the severity, the faster the change - elastic easing for flappy wind
	animate(src, gravity=newGravity, count=newCount, time=1/severity * 10, easing=ELASTIC_EASING)
