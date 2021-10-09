//Gomble is a developer - not an artist

//current particles
// + shape




//Rain - goes down
/particles/weather/rain
	icon_state             = list("drop"=10,"dot"=1)
	color                  = "#ccffff"
	// There is an issue with BOX where it spawns like a vector, so update this when Lum fixes it - Otherwise spawn at the top of the screen with some overlap on each side to account for wind
	position               = generator("box", list(-1000,-256,100), list(1000,256,100))
	//Some slight randomness in size to make some drops bigger
	scale                  = generator("vector", list(1,0.5), list(1.5,3))
	grow			       = list(-0.01,-0.01)

	gravity                = list(2,-10,-2)
	drift                  = generator("vector", list(-1,-1), list(1,1)) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s

	//Weather effects, max values
	maxSpawning           = 30
	minSpawning           = 20
	wind                  = 4


//Snow - goes down and swirls
/particles/weather/snow
	icon_state             = list("cross"=2, "snow_1"=5, "snow_2"=2, "snow_3"=2,)
	color                  = "#ffffff"
	// There is an issue with BOX where it spawns like a vector, so update this when Lum fixes it - Otherwise spawn at the top of the screen with some overlap on each side to account for wind
	position               = generator("vector", list(-1000,256,50), list(1000,256,50))
	grow			       = list(-0.5,-0.5)
	spin                   = generator("num",-5,5)
	gravity                = list(0,-1,-1)
	drift                  = generator("circle", 0, 3) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s
	//Weather effects, max values
	maxSpawning           = 20
	minSpawning           = 10
	wind                  = 1


//Dust - goes sideways and swirls
/particles/weather/dust
	icon_state             = list("dot"=5, "cross"=1)
	gradient               = list(0,"#f0a982e3",10,"#d16c35e3","loop")
	color                  = 0
	color_change		   = generator("num",0,5)
	// There is an issue with BOX where it spawns like a vector, so update this when Lum fixes it - Otherwise spawn at the top of the screen with some overlap on each side to account for wind
	spin                   = generator("num",-5,5)
	position               = generator("square", 350, 400) + generator("vector", list(0,0,100), list(0,0,100)) //Square generator at z 100
	gravity                = list(2,-2,-1)
	drift                  = generator("circle", 0, 3) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s

	//Weather effects, max values
	maxSpawning           = 20
	minSpawning           = 20
	wind                  = 20


//Rads - goes fucking everywhere
/particles/weather/rads
	icon_state              = list("dot"=5, "cross"=1)

	gradient               = list(0,"#54d832",1,"#1f2720",2,"#aad607",3,"#5f760d",4,"#484b3f","loop")
	color                  = 0
	color_change		   = generator("num",-5,5)
	// There is an issue with BOX where it spawns like a vector, so update this when Lum fixes it - Otherwise spawn at the top of the screen with some overlap on each side to account for wind
	position               = generator("square", 350, 400) + generator("vector", list(0,0,100), list(0,0,100)) //Square generator at z 100


	gravity                = list(2,-2)
	drift                  = generator("circle", 0, 5) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s

	//Weather effects, max values
	count 				  = 4000
	maxSpawning           = 200
	minSpawning           = 20
	wind                  = 2

