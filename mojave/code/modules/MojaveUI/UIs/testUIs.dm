/obj/mojaveUI/storage
	var/rows = 0
	var/cols = 0


/obj/mojaveUI/storage/_template()
	var/datum/mojaveUI/element/flowContainer/rootContainer = new /datum/mojaveUI/element/flowContainer()
	rootContainer.flow_direction = MOJAVEUI_FLOW_COLUMN

	rootContainer.padding = 0 // body padding
	rootContainer.spacing = 0 // row spacing
	// Create child container for each row, and cells for each column

	for(var/i = 1 to rows)
		var/datum/mojaveUI/element/flowContainer/row = new /datum/mojaveUI/element/flowContainer()
		rootContainer.add_element(row)
		row.flow_direction = MOJAVEUI_FLOW_ROW

		row.padding = 15 // column padding

		for(var/j = 1 to cols)
			var/datum/mojaveUI/element/cell/cell = new
			row.add_element(cell)

	return rootContainer



/obj/mojaveUI/generator

/obj/mojaveUI/generator/_template()
	return MojaveUI_GenerateElement(list(
		"flow_direction" = MOJAVEUI_FLOW_ROW,
		"spacing" = 3,
		"padding" = 3,
		"elements" = list(
			list(
				"spacing" = 3,
				"padding" = 3,
				"flow_direction" = MOJAVEUI_FLOW_COLUMN,
				"elements" = list(
					list(
						"type" = "auxMeter",
						"name" = "auxMeter",
					),
					list(
						"type" = "auxPrimer",
						"name" = "auxPrimer",
					),
				)
			),
			list(
				"spacing" = 3,
				"padding" = 3,
				"flow_direction" = MOJAVEUI_FLOW_COLUMN,
				"elements" = list(
					lightBox("Temperature"),
					list(
						"type" = "button.toggle.switch",
						"name" = "heaterSwitch"
					),
					list(
						"type" = "button.red",
						"name" = "ignition"
					),
				)
			),
			list(
				"spacing" = 3,
				"padding" = 3,
				"flow_direction" = MOJAVEUI_FLOW_COLUMN,
				"elements" = list(
					lightBox("Power"),
					list(
						"type" = "button.toggle.switch",
						"name" = "powerInputSwitch"
					),
					list(
						"type" = "button.toggle.switch",
						"name" = "powerOutputSwitch"
					)
				)
			)
		)
	))

/obj/mojaveUI/generator/proc/lightBox(lightboxName)
	return list(
		"spacing" = 3,
		"padding" = 3,
		"flow_direction" = MOJAVEUI_FLOW_COLUMN,
		"elements" = list(
			list(
				"type" = "display.light.green",
				"name" = "[lightboxName]Green"
			),
			list(
				"type" = "display.light.amber",
				"name" = "[lightboxName]Amber"
			),
			list(
				"type" = "display.light.red",
				"name" = "[lightboxName]Red"
			)
		)
	)
