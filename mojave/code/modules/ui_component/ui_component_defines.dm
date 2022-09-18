

/client/verb/TestUI()
	set name = "TestUI"
	set category = "OOC"
	var/datum/ui_factory/tempFactory = new
	tempFactory.Template_Window_Standard(src, 3,3,320,320)


// Used to anchor objects to their parent
// TOP/BOTTOM and LEFT/RIGHT can be combined for corners
// i.e ANCHOR_TOP & ANCHOR_LEFT for top left
#define ANCHOR_CENTER   0
#define ANCHOR_TOP      (1 << 0)
#define ANCHOR_RIGHT    (1 << 1)
#define ANCHOR_BOTTOM   (1 << 2)
#define ANCHOR_LEFT     (1 << 3)

#define ANCHOR_TOPLEFT     ANCHOR_TOP & ANCHOR_LEFT
#define ANCHOR_TOPRIGHT    ANCHOR_TOP & ANCHOR_RIGHT
#define ANCHOR_BOTTOMLEFT  ANCHOR_BOTTOM & ANCHOR_LEFT
#define ANCHOR_BOTTOMRIGHT ANCHOR_BOTTOM & ANCHOR_RIGHT


// Used to drag a group (set groupName on the top container for the group)
#define DRAG_GROUP      (1 << 0)
// Used to drag an entire window
#define DRAG_WINDOW     (1 << 1)

// Base ui_component for movable windows
// Captures mouse hits
/obj/ui_component

    // === Control Vars ===

    //parent component, for nesting
    var/obj/ui_component/parent



    // assoc list
    var/list/obj/ui_component/children = list()

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

    plane = 10
    screen_loc = "1, 1"
    appearance_flags = KEEP_TOGETHER

/obj/ui_component/New(client/owner, loc_x, loc_y, height, width, window_border = 0)
    screen_x = loc_x
    screen_y = loc_y

    screen_height = height
    screen_width  = width
    border = window_border
    refreshPos()

    owner.screen += src
    world << "Screens: [owner.screen.len]"




// repositions the window to its screen_loc
/obj/ui_component/proc/refreshPos()
    screen_loc = "[1],[1]"

    for(var/obj/ui_component/child in children)

        child.refreshPos(TRUE)



// Sets a child - kills any existing, if found
/obj/ui_component/proc/setChild(name, obj/ui_component/child)

    if(children[name] && children[name] <> child)
        del(children[name])
    children[name] = child
    vis_contents += child


// inner elements - nested inside ui_components
// TODO: anchor OR xy coords
/obj/ui_component/element
    var/anchor = ANCHOR_CENTER

/obj/ui_component/element/New(name, obj/ui_component/parent_container, parent_anchor, icon, icon_state, height, width)

    screen_height = height
    screen_width = width
    icon = icon
    icon_state = icon_state
    anchor = parent_anchor
    parent = parent_container
    parent.setChild(name, src)
    refreshPos()

// repositions the element to its anchor points
/obj/ui_component/element/refreshPos(updateChildren = FALSE)

    // get center
    var/newX = (parent.screen_width / 2) - screen_width
    var/newY = (parent.screen_height / 2) - screen_height

    // handle verticle
    if(anchor & ANCHOR_TOP)
        newX = parent.screen_height - screen_height
    else if(anchor & ANCHOR_BOTTOM)
        newX = 0
    // handle horizontal
    if(anchor & ANCHOR_LEFT)
        newY = 0
    else if(anchor & ANCHOR_RIGHT)
        newY = parent.screen_width - screen_width

    screen_x = newX
    screen_y = newY

    pixel_x = newX
    pixel_y = newY

    if(updateChildren)
        for(var/obj/ui_component/child in children)
            child.refreshPos(updateChildren)
