/obj/machinery/ms13
	name = "ms13 machine"
	desc = "You shouldn't be seeing this."

/obj/machinery/door/poddoor/shutters/indestructible/ms13
	name = "shutters"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/shutters/preopen/ms13/
	name = "shutters"

/obj/machinery/door/poddoor/shutters/preopen/ms13/indestructible
	name = "shutters"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/power/apc/unlocked/ms13
	name = "breaker"
	start_charge = 0

/obj/machinery/power/apc/unlocked/ms13/north
	dir = NORTH
	pixel_y = 23

/obj/machinery/power/apc/unlocked/ms13/south
	dir = SOUTH
	pixel_y = -23

/obj/machinery/power/apc/unlocked/ms13/east
	dir = EAST
	pixel_x = 23

/obj/machinery/power/apc/unlocked/ms13/west
	dir = WEST
	pixel_x = -23

////Fluff Machinery////

/obj/machinery/ms13/wartable
	name = "holo-table"
	desc = "A fancy high tech table, used to project plans up above its surface. Perfect for acting like you're a high ranking man who is very busy."
	icon = 'mojave/icons/structure/64x64_misc.dmi'
	icon_state = "wartable_off"
	layer = HIGH_OBJ_LAYER
	density = 1
	bound_height = 64
	bound_width = 64
	light_color = "#50afee"
	light_range = 4
	light_power = 0.3
	light_on = FALSE
	var/on = FALSE
	var/datum/looping_sound/ms13/holotable/soundloop
	var/processing = FALSE
	// Height and width of pixel drawable area - todo convert to oval and use distance from centre of map instead of scaled size
	var/width  = 26
	var/height = 21
	var/obj/tracker

/particles/wartable_ping
	// icon_state             = "drop"
	color                  = "#ffffff"
	position               = list(0,0)
	spawning 		       = 0
	count                  = 50
	lifespan 			   = 50
	fade 				   = 50
	// grow			       = list(-0.01,-0.01)
	// gravity                = list(0, -10, 0.5)
	// drift                  = generator("circle", 0, 1) // Some random movement for variation
	// friction               = 0.3  // shed 30% of velocity and drift every 0.1s
	// transform 			   = null // Rain is directional - so don't make it "3D"
	//Weather effects, max values


/obj/machinery/ms13/wartable/process()
	if(!tracker)
		tracker = new /obj()
		tracker.particles = new /particles/wartable_ping()
		tracker.filters += filter(type = "bloom", threshold = rgb(255, 128, 255), size = 2, offset = 1, alpha = 255)
		tracker.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		tracker.icon_state = icon_state //TODO MAKE THIS CHANGE WITH
		src.vis_contents = list(tracker)
	if (processing)
		return
	processing = TRUE
	var/list/mob/procList  = GLOB.suit_sensors_list
	for(var/tracked_mob in procList)
		if(!tracked_mob)
			stack_trace("Null entry in wartable list.")
			continue
		var/turf/mobTurf = get_turf(tracked_mob)
		if(!mobTurf)
			return
		tracker.particles.count = (tracker.particles.lifespan + tracker.particles.fade) * length(procList) * 2

		// 1 particle per tick, lasting lifespan + fade ticks


		// Scaling
		var/scaleH = world.maxy / height
		var/scaleW = world.maxx / width

		// Positioning - shift to centre of map
		var/x = (mobTurf.x / scaleW) - (width / 2)
		var/y = (mobTurf.y / scaleH) - (height / 2)

		tracker.particles.position = list(x,y)
		tracker.particles.spawning = 1 // A big number!
		sleep(1)
		tracker.particles.spawning = 0
	processing = FALSE



/obj/machinery/ms13/wartable/Initialize()
	. = ..()
	soundloop = new(src, on)

/obj/machinery/ms13/wartable/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/ms13/wartable/attack_hand(mob/living/user)
	. = ..()
	if(user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY)) //Can only actually activate this from the base tile in the bottom left due to the size of it. :Thinking://
		if(on)
			on = FALSE
			icon_state = "wartable_off"
			soundloop.stop()
		else
			on = TRUE
			icon_state = "wartable_on"
			soundloop.start()
		set_light_on(on)
		update_light()

// Intercoms //

/obj/item/radio/intercom/ms13 // Limited use closed in radios. Quirky.
	name = "intercom"
	desc = "A wall mounted intercom. Used to communicate seemlessly through distance in a closed system. Truly gamechanging."
	icon = 'mojave/icons/structure/machinery.dmi'
	icon_state = "intercom"
	canhear_range = 6
	// frequency = 1445.4 // Wack-ass numbers. Ensure these goofballs don't ever reach open air.
	// broadcasting = FALSE  // Whether the radio will transmit dialogue it hears nearby.
	freerange = TRUE  // If true, the radio has access to the full spectrum.
	freqlock = TRUE  // Frequency lock to stop the user from untuning specialist radios.
	radio_broadcast = RADIOSTATIC_LIGHT
	var/destroyable = FALSE

/obj/item/radio/intercom/ms13/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount)

/obj/item/radio/intercom/ms13/attackby(obj/item/W, mob/living/user, params)
	if(!destroyable)
		return
	if(!user.combat_mode && !(W.item_flags & NOBLUDGEON))
		return attack_hand(user)
	else
		return //aint no_one yoinkin our intercom

/obj/item/radio/intercom/ms13/ui_data(mob/user) // These should be set up to be closed off from everything else, and thus will be neutered and set to a set frequency.
	var/list/data = list()
	data["broadcasting"] = broadcasting
	data["listening"] = listening
	return data

// Buttons //

/obj/machinery/button/ms13
	name = "button"
	desc = "A remote control switch."
	icon = 'mojave/icons/structure/machinery.dmi'
	icon_state = "button"
	skin = "button"
	var/normaldoorcontrol = FALSE
	var/specialfunctions = OPEN // Bitflag, see assembly file
	var/sync_doors = TRUE
	var/destroyable = FALSE

/obj/machinery/button/ms13/setup_device() //Adds this so we can have our own future functionality, instead of making 4000 button types for each individual thing
	if(!device)
		if(normaldoorcontrol)
			var/obj/item/assembly/control/airlock/A = new(src)
			A.specialfunctions = specialfunctions
			device = A
		else
			var/obj/item/assembly/control/C = new(src)
			C.sync_doors = sync_doors
			device = C
	..()

/obj/machinery/button/ms13/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount)

/obj/machinery/button/ms13/attackby(obj/item/W, mob/living/user, params)
	if(!destroyable)
		return
	if(!user.combat_mode && !(W.item_flags & NOBLUDGEON))
		return attack_hand(user)
	else
		return //aint no_one yoinkin our button

// Misc Machinery //

/obj/machinery/ms13/coffee //beanening when
	name = "coffee machine"
	desc = "An old pre-war coffee machine, still functional somehow, if only you had some goddamn beans."
	icon = 'mojave/icons/structure/machinery.dmi'
	icon_state = "coffee"
	var/has_mug = FALSE //this is deep as fuark
	var/list/mugs
	var/obj/item/reagent_containers/food/drinks/mug = null
	max_integrity = 150

/obj/machinery/ms13/coffee/screwdriver_act_secondary(mob/living/user, obj/item/weapon)
	if(flags_1&NODECONSTRUCT_1)
		return TRUE
	..()
	weapon.play_tool_sound(src)
	if(do_after(user, 12 SECONDS, target = src, interaction_key = DOAFTER_SOURCE_DECON))
		deconstruct(disassembled = TRUE)
		return TRUE

/obj/machinery/ms13/coffee/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			new /obj/item/stack/sheet/ms13/scrap_alu(loc)
			new /obj/item/stack/sheet/ms13/plastic(loc)
			new /obj/item/stack/sheet/ms13/scrap_parts/two(loc)
			new /obj/item/stack/sheet/ms13/scrap_copper/two(loc)
			new /obj/item/stack/sheet/ms13/scrap_electronics(loc)
		else
			new /obj/item/stack/sheet/ms13/scrap_alu(loc)
			new /obj/item/stack/sheet/ms13/plastic(loc)
			new /obj/item/stack/sheet/ms13/scrap_parts(loc)
	qdel(src)

/obj/machinery/ms13/coffee/examine(mob/user)
	. = ..()
	. += deconstruction_hints(user)

/obj/machinery/ms13/coffee/proc/deconstruction_hints(mob/user)
	return span_notice("You could use a <b>screwdriver</b> to take apart [src] for parts.")

/obj/machinery/ms13/coffee/update_icon()
	. = ..()
	if(has_mug)
		icon_state = "coffee_cup"
	else
		icon_state = initial(icon_state)

/obj/machinery/ms13/coffee/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/reagent_containers/food/drinks/mug/ms13))
		var/obj/item/reagent_containers/B = I
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(B, src))
			return
		replace_mug(user, B)
		has_mug = TRUE
		to_chat(user, span_notice("You add [B] to [src]."))
		update_appearance()
		return TRUE //no afterattack

/obj/machinery/ms13/coffee/attack_hand()
	if(has_mug == TRUE)
		eject()

/obj/machinery/ms13/coffee/proc/eject(mob/user)
	if(mug)
		try_put_in_hand(mug, user)
		mug = null
	has_mug = FALSE
	update_appearance()

/obj/machinery/ms13/coffee/proc/replace_mug(mob/living/user, obj/item/reagent_containers/new_mug)
	if(!user)
		return FALSE
	if(mug)
		try_put_in_hand(mug, user)
		mug = null
	if(new_mug)
		mug = new_mug
	update_appearance()
	return TRUE
