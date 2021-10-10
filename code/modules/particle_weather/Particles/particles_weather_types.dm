//Gomble is a developer - not an artist

//current particles
// + shape




//Rain - goes down
/particles/weather/rain
	icon_state             = list("drop"=10,"dot"=1)
	color                  = "#ccffff"
	position               = generator("box", list(-1000,-256,100), list(1000,256,100))
	//Some slight randomness in size to make some drops bigger
	scale                  = generator("vector", list(1,0.5), list(1.5,3))
	grow			       = list(-0.01,-0.01)

	gravity                = list(2,-10,-2)
	drift                  = generator("vector", list(-1,-1), list(1,1)) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s

	//Weather effects, max values
	maxSpawning           = 100
	minSpawning           = 20
	wind                  = 4


//Snow - goes down and swirls
/particles/weather/snow
	icon_state             = list("cross"=2, "snow_1"=5, "snow_2"=2, "snow_3"=2,)
	color                  = "#ffffff"
	position               = generator("box", list(-1000,-256,100), list(1000,256,100))
	scale                  = generator("vector", list(-1,-0.5), list(-1.5,-3))
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
	spin                   = generator("num",-5,5)
	position               = generator("box", list(-1000,-256,100), list(1000,256,100))
	gravity                = list(2,-1,-1)
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
	position               = generator("box", list(-1000,-256,100), list(1000,256,100))


	gravity                = list(2,-1)
	drift                  = generator("circle", 0, 5) + generator("vector", list(0,5,0), list(0,-5,0)) // oval shape for vertical movement
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s

	//Weather effects, max values
	count 				  = 4000
	maxSpawning           = 200
	minSpawning           = 20
	wind                  = 2

