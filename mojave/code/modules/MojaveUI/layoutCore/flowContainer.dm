
/datum/mojaveUI/element/flowContainer

	appearanceType = /datum/mojaveUI/appearance/box

	// Containers should resize based on their children
	min_height = 0
	min_width = 0

	// Spacing between elements
	var/spacing = 0
	// internal padding for the container, currently for all sides
	var/padding = 0

	var/list/totalChildSize

	var/flow_direction = MOJAVEUI_FLOW_ROW
	var/list/elements = list() // List of Element objects

/datum/mojaveUI/element/flowContainer/layout
	// Draw nothing, purely used for layout
	appearanceType = null

/datum/mojaveUI/element/flowContainer/set_dirty()
	..()
	for(var/datum/mojaveUI/element/e in elements)
		e.set_dirty()

/datum/mojaveUI/element/flowContainer/proc/add_element(datum/mojaveUI/element/element)
		elements += element
		element.set_dirty()
		set_dirty()

/datum/mojaveUI/element/flowContainer/CalculateLayout()
	calculated_layout = defaultCalculatedLayout()
	totalChildSize = list("width" = 0, "height" = 0)
	switch(flow_direction)
		if(MOJAVEUI_FLOW_ROW, MOJAVEUI_FLOW_ROWREVERSED)
			layout_row()
		if(MOJAVEUI_FLOW_COLUMN, MOJAVEUI_FLOW_COLUMNREVERSED)
			layout_column()
		else
			throw EXCEPTION("Invalid flow direction")

	// set the width and height to the total size of the children, or min
	calculated_layout["width"] = max(totalChildSize["width"], min_width)
	calculated_layout["height"] = max(totalChildSize["height"], min_height)

	// add padding
	calculated_layout["width"] = calculated_layout["width"] + (padding * 2)
	calculated_layout["height"] = calculated_layout["height"] + (padding * 2)

	return calculated_layout

/datum/mojaveUI/element/flowContainer/proc/layout_row()
	for(var/datum/mojaveUI/element/element in elements)
		var/list/element_layout = element.layout()
		totalChildSize["width"] += element_layout["width"] + spacing
		totalChildSize["height"] = max(totalChildSize["height"], element_layout["height"])

	// trim excess spacing
	if(length(elements))
		totalChildSize["width"] -= spacing


/datum/mojaveUI/element/flowContainer/proc/layout_column()
	for(var/datum/mojaveUI/element/element in elements)
		var/list/element_layout = element.layout()
		totalChildSize["width"] = max(totalChildSize["width"], element_layout["width"])
		totalChildSize["height"] += element_layout["height"] + spacing

	// trim excess spacing
	if(length(elements))
		totalChildSize["height"] -= spacing
