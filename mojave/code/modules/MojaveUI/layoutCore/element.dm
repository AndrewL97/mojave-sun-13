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

/datum/mojaveUI/element

	// Configurable properties
	var/min_width = 32
	var/min_height = 32

	// Whether the element can be interacted with - If FALSE we will be an overlay for our parent, to save on maptick
	var/functional = TRUE

	// Whether the element is hidden - hides children too
	var/hidden = FALSE

	var/datum/mojaveUI/appearance/appearanceType = /datum/mojaveUI/appearance

	// Flex properties - how much the element should stretch to fill the available space
	// 0 = don't stretch
	// Otherwise flex is flex/total flex * remaining space
	var/flex_x = 0
	var/flex_y = 0

	// Calculated properties

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

/datum/mojaveUI/element/proc/getAppearance(layer = 0)
	var/datum/mojaveUI/appearance/A = getAppearanceObject()
	if(A)
		return A.get(calculated_layout["width"], calculated_layout["height"], layer)


/datum/mojaveUI/element/proc/getAppearanceLayersUsed()
	if(appearanceType)
		return initial(appearanceType.layersUsed)
	return 0

/datum/mojaveUI/element/proc/set_dirty()
		dirty = 1

/datum/mojaveUI/element/proc/layout()
	if(!dirty && calculated_layout)
		return calculated_layout
	return CalculateLayout()

/datum/mojaveUI/element/proc/CalculateLayout()
	calculated_layout = defaultCalculatedLayout()
	dirty = 0
	return calculated_layout

/datum/mojaveUI/element/proc/defaultCalculatedLayout()
	// x, y is relative to our parent element, not absolute
	return list("element"=src, "width"=min_width, "height"=min_height)


// spacer used to add space between elements, without displaying anything
/datum/mojaveUI/element/spacer
	appearanceType = null


/datum/mojaveUI/element/spacer/New(minHeight = 0, minWidth = 0)
	. = ..()
	min_height = minHeight
	min_width = minWidth
