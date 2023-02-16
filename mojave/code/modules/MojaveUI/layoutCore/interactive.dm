

// buttons and switches

/datum/mojaveUI/element/interactive
	functional =  TRUE
	appearanceType = /datum/mojaveUI/appearance/interactive
	var/on = FALSE

/datum/mojaveUI/element/interactive/operator[]=(key, value)
	switch(key)
		if("on")
			on = value
			if(UIObject)
				UIObject.drawObject(TRUE)
		else
			. = ..()


/datum/mojaveUI/element/interactive/button/black
	appearanceType = /datum/mojaveUI/appearance/interactive/button/black

/datum/mojaveUI/element/interactive/button/red
	appearanceType = /datum/mojaveUI/appearance/interactive/button/red

/datum/mojaveUI/element/interactive/switch/horizontal
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/horizontal

/datum/mojaveUI/element/interactive/switch/vertical
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/vertical

/datum/mojaveUI/element/interactive/switch/toggle
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/toggle

/datum/mojaveUI/element/interactive/switch/dial
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/dial

/datum/mojaveUI/element/interactive/getAppearanceObject()
	. = ..()

	if(istype(.,/datum/mojaveUI/appearance/interactive))
		var/datum/mojaveUI/appearance/light/L = .
		L.on = on

	return .


// apply mousedown and mouseup events to our interactive things
/datum/mojaveUI/element/interactive/applyFunctions(obj/mojaveUI/UIObj, atom/owner)
	. = ..()
	RegisterSignal(UIObject, COMSIG_MOUSEDOWN, .proc/on_mouse_down)
	RegisterSignal(UIObject, COMSIG_MOUSEUP, .proc/on_mouse_up)

/datum/mojaveUI/element/interactive/proc/on_mouse_down(client/source, atom/_target, turf/location, control, params)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		return
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		return


	// passed the checks, so handle appearance changes and then throw the signal
	handle_mouse_down()
	if(UIOwner)
		SEND_SIGNAL(UIOwner, COMSIG_MOJAVEUI_MOUSEDOWN, name, elementPath)

/datum/mojaveUI/element/interactive/proc/on_mouse_up(client/source, atom/_target, turf/location, control, params)

	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		return
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		return
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(LAZYACCESS(modifiers, ALT_CLICK))
		return


	// passed the checks, so handle appearance changes and then throw the signal
	handle_mouse_up()
	if(UIOwner)
		SEND_SIGNAL(UIOwner, COMSIG_MOJAVEUI_MOUSEUP, name, elementPath)


// handle appearance changes
/datum/mojaveUI/element/interactive/proc/handle_mouse_down()
	src["on"] = TRUE

/datum/mojaveUI/element/interactive/proc/handle_mouse_up()
	src["on"] = FALSE

// Switches, unlike buttons, toggle on down, and then do nothing on up
/datum/mojaveUI/element/interactive/switch/handle_mouse_down()
	src["on"] = !on // mmm inconsistent yummy yummy code

/datum/mojaveUI/element/interactive/switch/handle_mouse_up()
	return
