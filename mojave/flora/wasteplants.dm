//Mojave Sun general flora directory

//Ash Flora Type Plants but MS13 FORAGE EDITION

/obj/structure/flora/ms13/forage
	gender = PLURAL
	icon = 'mojave/icons/flora/wastelandflora.dmi'
	name = "Base type MS13 foragable plant"
	desc = "I sure hope these don't spawn in."
	harvested_name = "placeholderberry"
	harvested_desc = "A dark and sticky berry. Describe ONLY appearance!"
	delete_on_harvest = TRUE // If the plant comes back later on
	harvest_amount_low = 1
	harvest_amount_high = 4
	var/base_icon
	var/variants = 3 // How many variants of the plant sprite there are

/obj/structure/flora/ms13/forage/Initialize()
	. = ..()
	base_icon = "[icon_state][rand(1, (variants))]"
	icon_state = base_icon
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3)


/obj/structure/flora/ms13/forage/can_harvest(mob/user, obj/item/harvesting_item)

	// check standard can_harvest checks
	if(flags_1 & HOLOGRAM_1)
		return FALSE
	if(harvested || !harvestable)
		return null

	// MS13 has an axe to grind
	if(flora_flags & FLORA_WOODEN && harvesting_item.tool_behaviour in list(TOOL_SAW, TOOL_AXE))
		return TRUE

	return ..()


/obj/structure/flora/ms13/forage/regrow()
	..()
	icon_state = base_icon

/obj/structure/flora/ms13/forage/brocflower
	icon_state = "brocflower"
	name = "brocflower"
	desc = "A lanky plant bearing broc flowers"
	harvested_name = "broc flower"
	harvested_desc = "A broc flower."
	product_types = list(/obj/item/food/grown/ms13/brocflower = 1)
	harvest_amount_high = 3
	variants = 2

/obj/structure/flora/ms13/forage/brocflower/drought
	icon_state = "d_brocflower"
	variants = 1

/obj/structure/flora/ms13/forage/xander
	icon_state = "xander"
	name = "xander"
	desc = "A bunch of xander root plants"
	harvested_name = "xander"
	harvested_desc = "A xander root."
	product_types = list(/obj/item/food/grown/ms13/xander = 1)
	harvest_amount_high = 3
	variants = 2

/obj/structure/flora/ms13/forage/xander/drought
	icon_state = "d_xander"
	variants = 1

/obj/structure/flora/ms13/forage/yucca
	icon_state = "yucca"
	name = "yucca"
	desc = "A yucca plant, bearing starchy yucca fruits."
	harvested_name = "yucca"
	harvested_desc = "A yucca fruit."
	product_types = list(/obj/item/food/grown/ms13/yucca = 1)
	harvest_amount_high = 3
	variants = 1

/obj/structure/flora/ms13/forage/barrel_cactus
	icon_state = "barrelc"
	name = "barrel cactus"
	desc = "A barrel cactus, be careful of the spines."
	harvested_name = "barrel cactus fruit"
	harvested_desc = "Some barrel cactus fruit."
	product_types = list(/obj/item/food/grown/ms13/barrelcactus = 1)
	harvest_amount_high = 3
	variants = 3

/obj/structure/flora/ms13/forage/tarberry
	icon_state = "tarberry"
	name = "tarberry shrub"
	desc = "A plant bearing tarberries."
	harvested_name = "tarberry"
	harvested_desc = "A tarberry."
	product_types = list(/obj/item/food/grown/ms13/tarberry = 1)

/obj/structure/flora/ms13/forage/blackberry
	icon_state = "blackberry"
	name = "blackberry shrub"
	desc = "A plant bearing blackberries."
	harvested_name = "blackberry"
	harvested_desc = "A blackberry."
	product_types = list(/obj/item/food/grown/ms13/blackberry = 1)

/obj/structure/flora/ms13/forage/mutfruit
	icon_state = "mutfruit"
	name = "mutfruit plant"
	desc = "A plant bearing Mutfruits."
	harvested_name = "mutfruit"
	harvested_desc = "A Mutfruit."
	product_types = list(/obj/item/food/grown/ms13/mutfruit = 1)
	harvest_message_low = "You harvest the fruits, but fail to attain many of them."
	harvest_message_med = "You harvest the fruits, collecting a decent amount from the forage."
	harvest_message_high = "You harvest and collect many fruits from the wild plant."
	harvest_amount_high = 2

/obj/structure/flora/ms13/forage/ashrose
	icon_state = "ashrose"
	name = "ashrose flowers"
	desc = "A patch of ash rose."
	harvested_name = "ash rose"
	harvested_desc = "A potent radiation and toxin healing flower."
	product_types = list(/obj/item/food/grown/ms13/ashrose = 1)
	harvest_message_low = "You harvest the flowers, but fail to salvage many of them."
	harvest_message_med = "You harvest the flowers, collecting a small bunch of them."
	harvest_message_high = "You harvest and collect many flowers from the patch."
	harvest_amount_high = 4
	regrowth_time_high = 30 MINUTES

/obj/structure/flora/ms13/forage/ashrose/drought
	icon_state = "d_ashrose"
	variants = 1

/obj/structure/flora/ms13/forage/wildcarrot
	icon_state = "root"
	name = "wild carrot patch"
	desc = "A patch of wild carrots."
	harvested_name = "wild carrot"
	harvested_desc = "A wild root vegetable."
	product_types = list(/obj/item/food/grown/ms13/carrot = 1)
	harvest_message_low = "You dig up the roots, but fail to salvage many produce."
	harvest_message_med = "You dig up the roots, collecting a small bunch of carrots."
	harvest_message_high = "You dig up many roots from the patch, collecting a good harvest."
	harvest_amount_high = 3

/obj/structure/flora/ms13/forage/aster
	icon_state = "aster"
	name = "aster flowers"
	desc = "A patch of wild aster flowers."
	harvested_name = "aster flower"
	harvested_desc = "Some aster flowers."
	product_types = list(/obj/item/food/grown/ms13/aster = 1)
	harvest_message_low = "You accidentally destroy the delicate flowers, salvaging nothing."
	harvest_message_med = "You collect a handful of delicate flowers."
	harvest_message_high = "You delicately pick many flowers, collecting a good harvest."
	harvest_amount_low = 0
	harvest_amount_high = 4
	regrowth_time_high = 20 MINUTES

/obj/structure/flora/ms13/forage/aster/drought
	icon_state = "d_aster"
	variants = 1

/obj/structure/flora/ms13/forage/mushroom
	icon_state = "shroom"
	name = "cave fungus"
	desc = "A patch of cave mushrooms"
	harvested_name = "cave fungus"
	harvested_desc = "A common mushroom"
	product_types = list(/obj/item/food/grown/ms13/cavefungus = 1)
	harvest_message_low = "Gather a small amount of mushrooms from the cluster."
	harvest_message_med = "You collect a decent amount of mushrooms from the cluster."
	harvest_message_high = "You collect a hearty harvest from the mushroom cluster."
	harvest_amount_high = 4

/obj/structure/flora/ms13/forage/mushroom/glowing
	icon_state = "glowshroom"
	name = "glowing cave fungus"
	desc = "A patch of glowing mushrooms"
	harvested_name = "glowing fungus"
	harvested_desc = "A glowing mushroom"
	product_types = list(/obj/item/food/grown/ms13/glowfungus = 1)
	light_range = 2
	light_power = 0.25
	light_color = "#3eff3e"

/obj/structure/flora/ms13/forage/blight
	icon_state = "blightshroom"
	name = "blight mushroom"
	desc = "A patch of blight mushrooms"
	harvested_name = "blight fungus"
	harvested_desc = "A blight mushroom"
	product_types = list(/obj/item/food/grown/ms13/blight = 1)
	harvest_message_low = "Gather a small amount of mushrooms from the cluster."
	harvest_message_med = "You collect a decent amount of mushrooms from the cluster."
	harvest_message_high = "You collect a hearty harvest from the mushroom cluster."
	harvest_amount_high = 3

/obj/structure/flora/ms13/forage/brainshroom
	icon_state = "brainshroom"
	name = "brain fungus"
	desc = "A patch of brain fungus"
	harvested_name = "brain fungus"
	harvested_desc = "A brain fungus"
	product_types = list(/obj/item/food/grown/ms13/brainfung = 1)
	harvest_message_low = "Gather a small amount of fungus from the cluster."
	harvest_message_med = "You collect a decent amount of fungus from the cluster."
	harvest_message_high = "You collect a hearty harvest from the fungus cluster."
	harvest_amount_high = 2

/obj/structure/flora/ms13/forage/fireshroom
	icon_state = "fireshroom"
	name = "firecap mushroom"
	desc = "A patch of firecap mushrooms"
	harvested_name = "firecap mushroom"
	harvested_desc = "A firecap mushroom"
	product_types = list(/obj/item/food/grown/ms13/firecap = 1)
	harvest_message_low = "Gather a small amount of mushrooms from the patch."
	harvest_message_med = "You collect a decent amount of mushrooms from the patch."
	harvest_message_high = "You collect a hearty harvest from the mushroom patch."
	harvest_amount_high = 4

/obj/structure/flora/ms13/forage/gutshroom
	icon_state = "gutshroom"
	name = "gutshroom fungus"
	desc = "A patch of gutshroom fungus"
	harvested_name = "gutshroom fungus"
	harvested_desc = "A gutshroom fungus"
	product_types = list(/obj/item/food/grown/ms13/gutshroom = 1)
	harvest_message_low = "Gather a small amount of mushrooms from the cluster."
	harvest_message_med = "You collect a decent amount of mushrooms from the cluster."
	harvest_message_high = "You collect a hearty harvest from the mushroom cluster."
	harvest_amount_high = 3

/obj/structure/flora/ms13/forage/lure
	icon_state = "lure weed"
	name = "lure weed"
	desc = "A patch of lure weed"
	harvested_name = "lure weed"
	harvested_desc = "A nlure weed"
	product_types = list(/obj/item/food/grown/ms13/lureweed = 1)
	harvest_message_low = "Gather a small amount of lureweed from the patch."
	harvest_message_med = "You collect a decent amount of lureweed from the patch."
	harvest_message_high = "You collect a hearty harvest from the lureweed patch."
	harvest_amount_high = 2

/obj/structure/flora/ms13/forage/nara
	icon_state = "nara root"
	name = "nara root"
	desc = "A patch of nara root"
	harvested_name = "nara root"
	harvested_desc = "A nara root"
	product_types = list(/obj/item/food/grown/ms13/nara = 1)
	harvest_message_low = "Gather a small amount of root from the patch."
	harvest_message_med = "You collect a decent amount of root from the patch."
	harvest_message_high = "You collect a hearty harvest from the root patch."
	harvest_amount_high = 2

//Grasses

/obj/structure/flora/grass/wasteland
	icon = 'mojave/icons/flora/flora.dmi'
	desc = "Some dry, virtually dead grass."
	icon_state = "drygrass_1"

/obj/structure/flora/grass/wasteland/Initialize()
	. = ..()
	icon_state = "drygrass_[rand(1,15)]"
	var/matrix/M = new
	M.Translate(rand(-5,5),rand(-5,5))
	transform = M

/obj/structure/flora/grass/wasteland/snow
	icon = 'mojave/icons/flora/flora.dmi'
	desc = "Some frozen, virtually dead grass."
	icon_state = "snowgrass_1"

/obj/structure/flora/grass/wasteland/snow/New()
	..()
	icon_state = "snowgrass_[rand(1,8)]"

//Mojave Sun Trees/Large Foliage

//trees

/obj/structure/flora/ms13/tree
	name = "tree"
	desc = "A large tree."
	icon = 'mojave/icons/flora/trees.dmi'
	density = TRUE
	layer = 4.9
	plane = ABOVE_GAME_PLANE
	pixel_x = -16
	pixel_y = 5
	var/log_amount = 1
	projectile_passchance = 60 // mf tree

/obj/structure/flora/ms13/tree/Initialize()
	. = ..()
	pixel_x = rand(-20,-16)
	//AddComponent(/datum/component/largetransparency, 1, 1, -1, 1) // Busted right now. After the first time it turns the icon transparent, the entire icon's dimensions block mouse clicks.
	AddElement(/datum/element/climbable) // People should be able to pass trees hypothetically. Just not quickly... One day, unscuff the text for this.

/obj/structure/flora/ms13/tree/tallpine
	name = "pine tree"
	desc = "An tall evergreen, Evergreen even when the bombs dropped."
	icon_state = "pine_1"
	log_amount = 4
	max_integrity = 400

/obj/structure/flora/ms13/tree/tallpine/snow
	icon_state = "pine_1_snow"

/obj/structure/flora/ms13/tree/tallpine/alt
	icon_state = "pine_1_alt"

/obj/structure/flora/ms13/tree/tallpine/dead //uh oh placeholder alert
	icon_state = "bald"
	log_amount = 1

/obj/structure/flora/ms13/tree/drought/dead
	name = "dead tree"
	desc = "This tree lived a long life to get this big. Now it's dead."
	icon_state = "dead_tree1"
	max_integrity = 400

/obj/structure/flora/ms13/tree/drought/dead/Initialize()
	. = ..()
	icon_state = "dead_tree[rand(1,3)]"


// Cacti

/obj/structure/flora/ms13/cactus
	name = "cactus"
	desc = "A short cactus, spiny and spiky."
	icon = 'mojave/icons/flora/flora.dmi'
	icon_state = "short_cactus1"
	max_integrity = 200

/obj/structure/flora/ms13/cactus/Initialize()
	icon_state = "short_cactus[rand(1,3)]"
	..()

/obj/structure/flora/ms13/cactus/tall
	desc = "A tall cactus, spiky and spiny."
	icon_state = "tall_cactus1"
	max_integrity = 250

/obj/structure/flora/ms13/cactus/tall/Initialize()
	icon_state = "tall_cactus[rand(1,3)]"
	..()

// Generic leaf-plant

/obj/structure/flora/ms13/leafy
	name = "leafy plant"
	desc = "A tuft of leaf-blades, it's some hardy desert plant."
	icon = 'mojave/icons/flora/flora.dmi'
	icon_state = "leafy_plant1"

/obj/structure/flora/ms13/leafy/Initialize()
	icon_state = "leafy_plant[rand(1,3)]"
	..()

//for more ms13 snow plants (grass etc. search /obj/structure/flora/grass)
