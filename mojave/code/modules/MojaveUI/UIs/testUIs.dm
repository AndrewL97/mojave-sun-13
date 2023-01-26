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

/obj/mojaveUI/storage/_template()
	var/datum/mojaveUI/element/flowContainer/rootContainer = new /datum/mojaveUI/element/flowContainer()
	rootContainer.flow_direction = MOJAVEUI_FLOW_COLUMN
	rootContainer.appearanceType = /datum/mojaveUI/appearance/box/metal

	rootContainer.padding = 5
	rootContainer.spacing = 10

	//////// Column 1

	var/datum/mojaveUI/element/flowContainer/col1 = new /datum/mojaveUI/element/flowContainer()
	rootContainer.add_element(col1)
	col1.appearanceType = /datum/mojaveUI/appearance/box/metal

	// aux meter
	var/datum/mojaveUI/element/auxMeter/auxMeter = new
	col1.add_element(auxMeter)

	// aux primer
	var/datum/mojaveUI/element/auxPrimer/auxPrimer = new
	col1.add_element(auxPrimer)


	//////// Column 2
	var/datum/mojaveUI/element/flowContainer/col2 = new /datum/mojaveUI/element/flowContainer()
	rootContainer.add_element(col2)
	col2.appearanceType = /datum/mojaveUI/appearance/box/metal

	// Green Amber and Red lights
	var/datum/mojaveUI/element/light/green/greenLight = new
	col2.add_element(greenLight)
	var/datum/mojaveUI/element/light/amber/amberLight = new
	col2.add_element(amberLight)
	var/datum/mojaveUI/element/light/red/redLight = new
	col2.add_element(redLight)

	var/datum/mojaveUI/element/spacer = new(10)
	col2.add_element(spacer)

	// Heat Switch
	var/datum/mojaveUI/element/switch/heatSwitch = new
	col2.add_element(heatSwitch)

	// Ignition Button
	var/datum/mojaveUI/element/button/ignitionButton = new
	col2.add_element(ignitionButton)

	/////// Column 3
	var/datum/mojaveUI/element/flowContainer/col3 = new /datum/mojaveUI/element/flowContainer()
	rootContainer.add_element(col3)
	col3.appearanceType = /datum/mojaveUI/appearance/box/metal

	// Green Amber and Red lights
	var/datum/mojaveUI/element/light/green/greenLight2 = new
	col3.add_element(greenLight2)
	var/datum/mojaveUI/element/light/amber/amberLight2 = new
	col3.add_element(amberLight2)
	var/datum/mojaveUI/element/light/red/redLight2 = new
	col3.add_element(redLight2)

	var/datum/mojaveUI/element/spacer2 = new(10)
	col3.add_element(spacer2)

	// Power Source Switch
	var/datum/mojaveUI/element/switch/powerSourceSwitch = new
	col3.add_element(powerSourceSwitch)

	// Power Output Toggle
	var/datum/mojaveUI/element/toggle/powerOutputToggle = new
	col3.add_element(powerOutputToggle)



