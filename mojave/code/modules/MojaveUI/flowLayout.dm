/*
MojaveUI is a library for creating user interfaces. It includes the FlowLayout layout manager, which arranges widgets in a row or column, with optional spacing between widgets.

To use MojaveUI, create an instance of the FlowLayout class and add widgets to it using the add_element method. Then, call the layout method to calculate the position and size of each element in the layout.

Example:

layout = FlowLayout(spacing=10)
layout.add_element(Button("Button 1"))
layout.add_element(Button("Button 2"))
layout.add_element(Button("Button 3"))
layout.layout(x=0, y=0, width=100, height=100)

This will create a FlowLayout with three buttons arranged in a row, with 10 pixels of spacing between each button. The layout method will calculate the position and size of each button within the layout.
*/

#define MOJAVEUI_FLOW_ROW            1
#define MOJAVEUI_FLOW_ROWREVERSED    2
#define MOJAVEUI_FLOW_COLUMN         3
#define MOJAVEUI_FLOW_COLUMNREVERSED 4

/datum/mojaveui/element

	// Configurable properties
	var/minWidth = 32
    var/minHeight = 32

	// Calculated properties

	// list(element,x,y,width,height)
	var/list/calculated_layout = list()
	// Whether the layout needs to be recalculated
    var/dirty = 1

/datum/mojaveui/element/proc/set_dirty()
        dirty = 1

/datum/mojaveui/element/proc/layout()
        if(!dirty && calculated_layout)
            return calculated_layout
        return CalculateLayout()

/datum/mojaveui/element/proc/CalculateLayout()
        calculated_layout = defaultCalculatedLayout()
        dirty = 0
        return calculated_layout

/datum/mojaveui/element/proc/defaultCalculatedLayout()
	// x, y is relative to our parent element, not absolute
	return list("element"=src, "x"=0, "y"=0, "width"=minWidth, "height"=minHeight)

/datum/mojaveui/element/flowContainer

	var/spacing = 10
	var/padding = 10

    var/flow_direction = MOJAVE_UI_ROW
    var/list/elements = list() // List of Element objects

/datum/mojaveui/element/flowContainer/set_dirty()
	..()
	for(var/datum/mojaveui/element/e in elements)
		e.set_dirty()

/datum/mojaveui/element/flowContainer/proc/add_element(element)
	elements += element
	element.set_dirty()
	set_dirty()

/datum/mojaveui/element/proc/CalculateLayout/CalculateLayout()
	calculated_layout = defaultCalculatedLayout()
	switch(flow_direction)
		if(MOJAVE_UI_ROW, MOJAVEUI_FLOW_ROWREVERSED)
			return layout_row()
		if(MOJAVE_UI_COLUMN, MOJAVEUI_FLOW_COLUMNREVERSED)
			return layout_column()
		else
			throw EXCEPTION("Invalid flow direction")


/datum/mojaveui/element/flowContainer/proc/layout_row()
	for(var/datum/mojaveui/element/element in elements)
		var/list/element_layout = element.layout()
		var/element_width = element_layout["width"]
		var/element_height = element_layout["height"]
		calculated_layout["width"] += element_width + spacing
		calculated_layout["height"] = max(calculated_layout["height"], element_height)

/darum/mojaveui/element/flowContainer/proc/layout_column()
	for(var/datum/mojaveui/element/element in elements)
		var/list/element_layout = element.layout()
		var/element_width = element_layout["width"]
		var/element_height = element_layout["height"]
		calculated_layout["width"] = max(calculated_layout["width"], element_width)
		calculated_layout["height"] += element_height + spacing
