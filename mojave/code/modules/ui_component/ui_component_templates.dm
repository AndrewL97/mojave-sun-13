//  Icon defines - because we used words like up
#define CONTAINER_BODY "body"

#define BORDER_TOP "up"
#define BORDER_RIGHT "right"
#define BORDER_BOTTOM "down"
#define BORDER_LEFT "left"

#define CORNER_TOPLEFT "corner_left_up"
#define CORNER_TOPRIGHT "corner_right_up"
#define CORNER_BOTTOMLEFT "corner_left_down"
#define CORNER_BOTTOMRIGHT "corner_right_down"

//  pre-built templates to base your windows off
/datum/ui_factory


// A window, made of a box and a header bar
/datum/ui_factory/proc/Template_Window_Standard(client/owner, loc_x, loc_y, height, width)

	// TODO: Icons for header bar

	// Window
	var/obj/ui_component/window = new /obj/ui_component(owner, loc_x, loc_y, height, width)

	// Body
	var/headerHeight = 32
	Template_Element_Box("BODY", window, height-headerHeight, width, 'mojave/icons/hud/storage.dmi', 3).set_display_type(ANCHOR_BOTTOM)
	// world << "body  made"

	// Header
	var/obj/ui_component/header = Template_Element_Box("HEADER", window, headerHeight, width, 'mojave/icons/hud/storage.dmi', 3).set_display_type(ANCHOR_TOP)
	header.dragType = DRAG_WINDOW

	// world << "header made"
	return window



// box with borders
// Pass in icon file with border components
// Pass border width for the thickness (from inside of the window to the outside edge)
/datum/ui_factory/proc/Template_Element_Box(name, obj/ui_component/parent, parent_anchor, height, width, icon,  border)

	// we remove the thickness from both sides of the borders, to allow for corners to be drawn
	// bm = border mod
	var/bm = border * 2

	// name, obj/ui_component/parent, anchor, icon, icon_state, height, width
	// Body
	// var/obj/ui_component/element/tempContainer = new /obj/ui_component/element("CONTAINER", parent, ANCHOR_CENTER, icon, "background", width, height)
	var/obj/ui_component/element/tempContainer = new /obj/ui_component/element(name, parent, parent_anchor, icon, CONTAINER_BODY, width-bm, height-bm)
	if(border)
		new /obj/ui_component/element("BORDER_TOP", tempContainer, icon, BORDER_TOP, width-bm, 32).set_display_type(ANCHOR_TOP)
		// Top & Bottom
		new /obj/ui_component/element("BORDER_BOTTOM", tempContainer, icon, BORDER_BOTTOM, width-bm, 32, 0).set_display_type(ANCHOR_BOTTOM)
		new /obj/ui_component/element("BORDER_LEFT", tempContainer, icon,  BORDER_LEFT, 32, height-bm, 0).set_display_type(ANCHOR_LEFT)
		// Sides
		new /obj/ui_component/element("BORDER_RIGHT", tempContainer, icon, BORDER_RIGHT, 32, height-bm, 0).set_display_type(ANCHOR_RIGHT)
		new /obj/ui_component/element("CORNER_TOPLEFT", tempContainer, icon, CORNER_TOPLEFT, border, border, 0).set_display_type(ANCHOR_TOPLEFT)
		// Corners
		new /obj/ui_component/element("CORNER_TOPRIGHT", tempContainer, icon, CORNER_TOPRIGHT, border, border, 0).set_display_type(ANCHOR_TOPRIGHT)
		new /obj/ui_component/element("CORNER_BOTTOMLEFT", tempContainer, icon, CORNER_BOTTOMLEFT, border, border, 0).set_display_type(ANCHOR_BOTTOMLEFT)
		new /obj/ui_component/element("CORNER_BOTTOMRIGHT", tempContainer, icon, CORNER_BOTTOMRIGHT, border, border, 0).set_display_type(ANCHOR_BOTTOMRIGHT)

	tempContainer.refreshPos(TRUE)
	return tempContainer
