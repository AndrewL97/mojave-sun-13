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

    var/headerHeight = 10
    world << "Window made"
    // Header
    Template_Element_Box("HEADER", window, ANCHOR_TOP, width, headerHeight, 'mojave/icons/hud/storage.dmi', 3)
    world << "header made"
    // Body
    Template_Element_Box("BODY", window, ANCHOR_BOTTOM, width, height - headerHeight, 'mojave/icons/hud/storage.dmi', 3)
    world << "body  made"
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
    var/obj/ui_component/element/tempContainer = new /obj/ui_component/element("CONTAINER_BODY", parent, ANCHOR_CENTER, icon, CONTAINER_BODY, width, height, border)
    if(border)
        // Top & Bottom
        new /obj/ui_component/element("BORDER_TOP", tempContainer, ANCHOR_TOP, icon, BORDER_TOP, width - bm, 32, 0)
        new /obj/ui_component/element("BORDER_BOTTOM", tempContainer, ANCHOR_BOTTOM, icon, BORDER_BOTTOM, width - bm, 32, 0)
        // Sides
        new /obj/ui_component/element("BORDER_LEFT", tempContainer, ANCHOR_LEFT, icon,  BORDER_LEFT, 32, height - bm, 0)
        new /obj/ui_component/element("BORDER_RIGHT", tempContainer, ANCHOR_RIGHT, icon, BORDER_RIGHT, 32, height - bm, 0)
        // Corners
        new /obj/ui_component/element("CORNER_TOPLEFT", tempContainer, ANCHOR_TOPLEFT, icon, CORNER_TOPLEFT, 32, 32, 0)
        new /obj/ui_component/element("CORNER_TOPRIGHT", tempContainer, ANCHOR_TOPRIGHT, icon, CORNER_TOPRIGHT, 32, 32, 0)
        new /obj/ui_component/element("CORNER_BOTTOMLEFT", tempContainer, ANCHOR_BOTTOMLEFT, icon, CORNER_BOTTOMLEFT, 32, 32, 0)
        new /obj/ui_component/element("CORNER_BOTTOMRIGHT", tempContainer, ANCHOR_BOTTOMRIGHT, icon, CORNER_BOTTOMRIGHT, 32, 32, 0)

    return tempContainer
