/*
	atom.particles



		Particle vars that affect the entire set (generators are not allowed for these)
			Var	Type	Description
			width	num	Size of particle image in pixels
			height
			count	num	Maximum particle count
			spawning	num	Number of particles to spawn per tick (can be fractional)
			bound1	vector	Minimum particle position in x,y,z space; defaults to list(-1000,-1000,-1000)
			bound2	vector	Maximum particle position in x,y,z space; defaults to list(1000,1000,1000)
			gravity	vector	Constant acceleration applied to all particles in this set (pixels per squared tick)
			gradient	color gradient	Color gradient used, if any
			transform	matrix	Transform done to all particles, if any (can be higher than 2D)

		Vars that apply when a particle spawns
			lifespan	num	Maximum life of the particle, in ticks
			fade	num	Fade-out time at end of lifespan, in ticks
			icon	icon	Icon to use, if any; no icon means this particle will be a dot
			Can be assigned a weighted list of icon files, to choose an icon at random
			icon_state	text	Icon state to use, if any
			Can be assigned a weighted list of strings, to choose an icon at random
			color	num or color	Particle color; can be a number if a gradient is used
			color_change	num	Color change per tick; only applies if gradient is used
			position	num	x,y,z position, from center in pixels
			velocity	num	x,y,z velocity, in pixels
			scale	vector (2D)	Scale applied to icon, if used; defaults to list(1,1)
			grow	num	Change in scale per tick; defaults to list(0,0)
			rotation	num	Angle of rotation (clockwise); applies only if using an icon
			spin	num	Change in rotation per tick
			friction	num	Amount of velocity to shed (0 to 1) per tick, also applied to acceleration from drift

		Vars that are evalulated every tick
			drift	vector	Added acceleration every tick; e.g. a circle or sphere generator can be applied to produce snow or ember effects



*/




/datum/particle_editor
	var/atom/movable/target

/datum/particle_editor/New(atom/target)
	src.target = target

/datum/particle_editor/ui_state(mob/user)
	return GLOB.admin_state

/datum/particle_editor/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Particool")
		ui.open()

/datum/particle_editor/ui_static_data(mob/user)
	var/list/data = list()
	data["particle_info"] = GLOB.master_particle_info
	return data

/datum/particle_editor/ui_data()
	var/list/data = list()
	data["target_name"] = target.name
	data["target_particle"] = target.particles ? target.particles.vars : null
	return data


/datum/particle_editor/proc/digest_particle_json(list/L)
	var/particles/P = new /particles
	for(var/elem in L)
		P.vars[L[elem]["name"]] = translate_value(elem)
	return P


//expects an assoc list of name, type, value - type must be in this list
/datum/particle_editor/proc/translate_value(list/L)
	//string/float/int come in as the correct type, so just whack em in

	switch(L["type"])
		if("string") return L["value"]
		if("float") return L["value"]
		if("int") return L["value"]
		if("color") return L["value"]
		if("list") return L["value"]
		if("matrix") return ListToMatrix(L["value"])
		if("generator") return generateGenerator(L["value"]) // This value should be a new list, if it isn't then we will explode

/datum/particle_editor/proc/generateGenerator(L)
	debugOutput(L,"GenerateGenerator")

/datum/particle_editor/proc/ListToMatrix(list/L)

	//Normal Matrixes allow 6
	switch(length(L))
		if(6)
			return matrix(L[0],L[1],L[2],L[3],L[4],L[5])

/datum/particle_editor/proc/stringToList(Str)
	return splittext(Str,regex(@"(?<!\\),"))



// /datum/particle_editor/proc/generateGenerator(list/L)

/datum/particle_editor/proc/debugOutput(L, nodeName)
	if(istype(L,/list))
		for(var/elem in L)
			if(istype(L[elem],/list))
				world.log << nodeName
				debugOutput(L[elem], nodeName + ":" + elem)
			else if(istype(elem,/list))
				world.log << nodeName
				debugOutput(elem, nodeName + ":LIST")
			else
				world.log << nodeName + ":" + elem + ":" + text("[]",L[elem])
	else
		world.log << L

/datum/particle_editor/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	debugOutput(params)

	switch(action)
		if("add_particle")
			target.add_particle()
			. = TRUE
		if("remove_particle")
			target.remove_particle()
			. = TRUE
		if("modify_particle_value")
			target.modify_particle_value(params["new_data"]["name"], translate_value(params["new_data"]))
			. = TRUE
		if("modify_color_value")
			var/new_color = input(usr, "Pick new particle color", "Particool Colors!") as color|null
			if(new_color)
				target.modify_particle_value("color",new_color)
				. = TRUE
		if("modify_icon_value")
			var/icon/new_icon = input("Pick icon:", "Icon") as null|icon
			if(new_icon && target.particles)
				target.modify_particle_value("icon", new_icon)
				. = TRUE


//movable procs n stuff

/atom/movable/proc/add_particle()
	particles = new /particles

/atom/movable/proc/remove_particle()
	particles = null

/atom/movable/proc/modify_particle_value(varName, varVal)
	if(particles)
		particles.vars[varName] = varVal

/atom/movable/proc/transition_particle(time, list/new_params, easing, loop)
	if(particles)
		animate(particles, new_params, time = time, easing = easing, loop = loop)




