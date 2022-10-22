// Used to anchor objects to their parent
// TOP/BOTTOM and LEFT/RIGHT can be combined for corners
// i.e ANCHOR_TOP & ANCHOR_LEFT for top left
#define ANCHOR_CENTER (1<<0)
#define ANCHOR_TOP    (1<<1)
#define ANCHOR_RIGHT  (1<<2)
#define ANCHOR_BOTTOM (1<<3)
#define ANCHOR_LEFT   (1<<4)
#define DISPLAY_FLEX  (1<<5)

#define ANCHOR_TOPLEFT     ANCHOR_TOP & ANCHOR_LEFT
#define ANCHOR_TOPRIGHT    ANCHOR_TOP & ANCHOR_RIGHT
#define ANCHOR_BOTTOMLEFT  ANCHOR_BOTTOM & ANCHOR_LEFT
#define ANCHOR_BOTTOMRIGHT ANCHOR_BOTTOM & ANCHOR_RIGHT


// Used to drag a group (set groupName on the top container for the group)
#define DRAG_GROUP	(1<<0)
// Used to drag an entire window
#define DRAG_WINDOW	 (1<<1)

// Base ui_component for movable windows
// Captures mouse hits
/obj/ui_component

	// === Control Vars ===

	//parent component, for nesting
	var/obj/ui_component/parent

	var/component_name = ""


	// assoc list
	var/list/children = list()

	// If this allows its parent to be dragged
	// When mouse click + drag, we iterate up to our parent, and move it all around
	var/dragType  = null
	var/groupName = ""


	// === Rendering ===

	// width in pixels to inner-pad when setting anchor positions
	var/border = 0

	// in Pixels - 32x32 would be one standard icon in size
	var/screen_height = 0
	var/screen_width = 0

	// Center point of window
	var/screen_x = 0
	var/screen_y = 0

	plane = ABOVE_HUD_PLANE
	appearance_flags = RESET_TRANSFORM | PIXEL_SCALE

/obj/ui_component/New(client/owner, loc_x, loc_y, height, width, window_border = 0)
	screen_x = loc_x
	screen_y = loc_y

	screen_height = height
	screen_width  = width
	border = window_border
	refreshPos()

	owner.screen += src

/obj/ui_component/proc/getWindow()
	if(parent)
		return parent.getWindow()
	return src


// repositions the window to its screen_loc
/obj/ui_component/proc/refreshPos(updateChildren = FALSE)
	// Draw from 0 with pixel shifts
	screen_loc = "1:[screen_x],1:[screen_y]"
	world << "New screen_loc -> [screen_loc]"
	if(updateChildren)
		for(var/obj/ui_component/child in children)
			child.refreshPos(updateChildren)



// Sets a child - kills any existing, if found
/obj/ui_component/proc/setChild(obj/child, name)

	if(children[name] && children[name] <> child)
		// world << "Deleting [child.component_name]"
		del(children[name])
	children[name] = child
	vis_contents += child

/obj/ui_component/proc/get_child_ui(name)
	RETURN_TYPE(/obj/ui_component)
	var/child = get_child(name)
	if(istype(child, /obj/ui_component))
		var/obj/ui_component/child_ui = child
		return child_ui
	return null

/obj/ui_component/proc/get_child(childName)
	return children[childName]


/// MOUSE SHIT
/obj/ui_component/proc/on_mouse_down(client/source, atom/_target, turf/location, control, params)
	RegisterSignal(COMSIG_CLIENT_MOUSEDRAG, .proc/on_mouse_drag)


/obj/ui_component/MouseUp(location, control, params)
	UnregisterSignal(COMSIG_CLIENT_MOUSEDRAG, .proc/on_mouse_drag)
	. = ..()

/obj/ui_component/proc/on_mouse_drag(over_object, src_location, over_location, src_control, over_control, params)

	if(dragType & DRAG_WINDOW)
		var/list/pos = mouse2Coords(params2list(params), usr.client)
		var/obj/ui_component/window = getWindow()
		window.screen_x = pos[1]
		window.screen_y = pos[2]
		window.refreshPos()



// mostly parse_caught_click_modifiers
/proc/mouse2Coords(list/mouseParams, client/viewing_client)

	world << "mouseParams: [jointext(mouseParams,",")]"
	var/screen_loc = splittext(mouseParams["screen-loc"], ",")
	world << "screen_loc [jointext(screen_loc,", ")]"
	var/list/actual_view = getviewsize(viewing_client ? viewing_client.view : world.view)
	var/click_x = splittext(screen_loc[1], ":")
	var/click_y = splittext(screen_loc[2], ":")
	world << "[click_x]:[click_y]"

	var/click_px = text2num(click_x[1]) * 32 + text2num(click_x[2])
	var/click_py = text2num(click_y[1]) * 32 + text2num(click_y[2])
	world << "[splittext(click_px,", ")]:[splittext(click_py,", ")]"
	return list(click_px, click_py)
