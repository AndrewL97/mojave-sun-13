/*
mojaveUI is a library for creating user interfaces. It includes the FlowLayout layout manager, which arranges widgets in a row or column, with optional spacing between widgets.

To use mojaveUI, create an instance of the FlowLayout class and add widgets to it using the add_element method. Then, call the layout method to calculate the position and size of each element in the layout.

Example:

var/datum/mojaveUI/element/flowContainer/layout = new
layout.add_element(Button("Button 1"))
layout.add_element(Button("Button 2"))
layout.add_element(Button("Button 3"))

var/obj/mojaveUI/ui_window = new
ui_window.root = layout
ui_window.Render(0, 0, layout, client)

This will create a FlowLayout with three buttons arranged in a row, with 10 pixels of spacing between each button. The layout method will calculate the position and size of each button within the layout.
*/

#define MOJAVEUI_FLOW_ROW			1
#define MOJAVEUI_FLOW_ROWREVERSED	2
#define MOJAVEUI_FLOW_COLUMN		 3
#define MOJAVEUI_FLOW_COLUMNREVERSED 4
#define MOJAVEUI_PATH_SEPARATOR "."

/datum/mojaveUI/element

	// Configurable properties //

	// The name of the element - used for identifying button's pressed, etc.
	// This is used to produce elementPath, which is a list of names from the root element to this element
	// Preferably this is at least unique within the parent element
	var/name = "element"

	// Use to fetch the element type from the global element type list
	// Set this in the object definition and leave it alone
	// This should be unique across all element types
	// i.e a big red button would be "button.red.big"
	var/elementTypeName = "element"

	// minimum dimensions
	// for the sake of centering, treat these as the icon's dimensions
	// if you are centering a scalable (but 32 based) icon, set it to 0 or 32
	// idk what to do if you want to set this to a size that doesn't match your icon
	var/min_width = 32
	var/min_height = 32

	// Whether the element can be interacted with - If FALSE we will be an overlay for our parent, to save on maptick
	var/functional = FALSE

	// Whether the element is hidden - hides children too
	var/hidden = FALSE

	var/datum/mojaveUI/appearance/appearanceType = /datum/mojaveUI/appearance

	// Flex properties - how much the element should stretch to fill the available space
	// 0 = don't stretch
	// Otherwise flex is flex/total flex * remaining space
	var/flex_x = 0
	var/flex_y = 0


	// Calculated properties //

	// MOJAVEUI_PATH_SEPARATOR delimited list of elements from root to this element
	var/elementPath = ""
	var/obj/mojaveUI/UIObject = null // for functional elements, the UI object (i.e button) that this element represents
	var/atom/UIOwner = null // for functional elements, the atom that owns the entire UI (i.e a computer, etc.)

	// list(element, width,height)
	var/list/calculated_layout = list()
	// Whether the layout needs to be recalculated
	var/dirty = 1

/datum/mojaveUI/element/New()
	. = ..()

/datum/mojaveUI/element/proc/getAppearanceObject()
	RETURN_TYPE(/datum/mojaveUI/appearance)
	if(appearanceType)
		return new appearanceType(src)

// operator overload to dynamically set properties (without using vars everywhere)
// only allow configurable properties to be set here
// This crashes at the end for failures - so for overrides, call ..() at the end
/datum/mojaveUI/element/proc/operator[]=(key, value)
	switch(key)
		if("name")
			name = value
		if("elementTypeName")
			elementTypeName = value
		if("min_width")
			min_width = value
		if("min_height")
			min_height = value
		if("functional")
			functional = value
		if("hidden")
			hidden = value
		if("appearanceType")
			appearanceType = MojaveUI_GetAppearanceType(value)
		if("flex_x")
			flex_x = value
		if("flex_y")
			flex_y = value
		else
			CRASH("Invalid property [key] for [type]")
			/*
				Debugging tips:
					If this is being hit when adding child elements, and Key is a list instead of a string - check you haven't got too many lists in your UI definition
						i.e elements = list(list(list(type = "button", name = "button1")))
			 */


/datum/mojaveUI/element/proc/getAppearance(layer = 0)
	var/datum/mojaveUI/appearance/A = getAppearanceObject()
	if(A)
		return A.get(calculated_layout["width"], calculated_layout["height"], layer)

/datum/mojaveUI/element/proc/GetAppearanceHeight()
	if(appearanceType) return initial(appearanceType.icon_height)
	return world.icon_size

/datum/mojaveUI/element/proc/GetAppearanceWidth()
	if(appearanceType) return initial(appearanceType.icon_width)
	return world.icon_size


/datum/mojaveUI/element/proc/getAppearanceLayersUsed()
	if(appearanceType)
		return initial(appearanceType.layersUsed)
	return 0

/datum/mojaveUI/element/proc/set_dirty()
		dirty = 1

/datum/mojaveUI/element/proc/layout(parentPath = "")
	if(!dirty && calculated_layout)
		return calculated_layout
	return CalculateLayout(parentPath)

/datum/mojaveUI/element/proc/CalculateLayout(parentPath)
	calculated_layout = defaultCalculatedLayout()
	dirty = 0
	elementPath = parentPath + MOJAVEUI_PATH_SEPARATOR + name
	return calculated_layout

/datum/mojaveUI/element/proc/defaultCalculatedLayout()
	// x, y is relative to our parent element, not absolute
	return list("element"=src, "width"=min_width, "height"=min_height)


/datum/mojaveUI/element/proc/applyFunctions(obj/mojaveUI/UIObj, atom/owner)
	src.UIObject = UIObj
	src.UIOwner = owner
	return


// spacer used to add space between elements, without displaying anything
/datum/mojaveUI/element/spacer
	appearanceType = null


/datum/mojaveUI/element/spacer/New(minHeight = 0, minWidth = 0)
	. = ..()
	min_height = minHeight
	min_width = minWidth
