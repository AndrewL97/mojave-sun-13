
// inner elements - nested inside ui_components
/obj/ui_component/element
	var/display_type = ANCHOR_NONE
	var/flex = 0 // for flexbox
	var/flex_direction = 0 // for flexbox
	// #define FLEX_HORIZONTAL FALSE
	// #define FLEX_VERTICAL TRUE

/obj/ui_component/element/New(name, obj/ui_component/parent_container, iconFile, iconState, width, height)
	// world << "Creating [name]"
	component_name = name
	screen_height = height
	screen_width = width
	icon = iconFile
	icon_state = iconState
	parent = parent_container
	parent.setChild(src, component_name)
	if(dragType & DRAG_WINDOW)
		RegisterSignal(COMSIG_CLIENT_MOUSEDOWN, .proc/on_mouse_down)

/obj/ui_component/element/proc/set_display_type(new_display_type)
	display_type = new_display_type
	refreshPos()

/obj/ui_component/proc/add_arbitary_obj(name, obj/object)
	parent.setChild(object, name)


// repositions the element to its display_type
/obj/ui_component/element/refreshPos(updateChildren = FALSE)
	// TODO - Handle non stretched components

	transform = matrix().Scale(screen_width/32, screen_height/32)

	var/newX = 0
	var/newY = 0

	// ANCHORS
	// handle verticle
	if(display_type & ANCHOR_TOP)
		newY = parent.screen_height/2 - screen_height/2
	else if(display_type & ANCHOR_BOTTOM)
		newY = -(parent.screen_height/2 - screen_height/2)
	// handle horizontal
	if(display_type & ANCHOR_LEFT)
		newX = -(parent.screen_width/2 - screen_width/2)
	else if(display_type & ANCHOR_RIGHT)
		newX = parent.screen_width/2 - screen_width/2

	screen_x = newX
	screen_y = newY

	pixel_x = newX
	pixel_y = newY
	// world << "Moving: [component_name]: [newX]x[newY] - [parent.screen_width]x[parent.screen_height] -- [screen_width],[screen_height]"
	if(updateChildren)
		if(display_type & DISPLAY_FLEX)
			flex_children()
		else
			// world << "updating [children.len] children of: [component_name]"
			for(var/obj/ui_component/child in children)
				children[child].refreshPos(updateChildren)

