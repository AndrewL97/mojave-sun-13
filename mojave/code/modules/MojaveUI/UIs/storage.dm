/obj/mojaveUI/storage
	var/rows = 0
	var/cols = 0


/obj/mojaveUI/storage/_template()
	var/datum/mojaveUI/element/flowContainer/rootContainer = new /datum/mojaveUI/element/flowContainer()
	rootContainer.flow_direction = MOJAVEUI_FLOW_COLUMN

	// rootContainer.padding = 50
	// Create child container for each row, and cells for each column

	for(var/i = 1 to rows)
		var/datum/mojaveUI/element/flowContainer/row = new /datum/mojaveUI/element/flowContainer()
		rootContainer.add_element(row)
		row.flow_direction = MOJAVEUI_FLOW_ROW

		for(var/j = 1 to cols)
			var/datum/mojaveUI/element/cell/cell = new
			row.add_element(cell)

	return rootContainer
