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
	var/datum/mojaveUI/element/flowContainer/rootContainer = new /datum/mojaveUI/element/flowContainer()
	rootContainer.flow_direction = MOJAVEUI_FLOW_ROW
	rootContainer.appearanceType = /datum/mojaveUI/appearance/box/metal

	// rootContainer.padding = 5
	// rootContainer.spacing = 10

	// //////// Column 1

	// var/datum/mojaveUI/element/flowContainer/col1 = new /datum/mojaveUI/element/flowContainer()
	// rootContainer.add_element(col1)
	// col1.appearanceType = /datum/mojaveUI/appearance/box/metal
	// col1.flow_direction = MOJAVEUI_FLOW_COLUMN
	// col1.padding = 5
	// col1.spacing = 10
	// // aux meter
	// var/datum/mojaveUI/element/auxMeter/auxMeter = new
	// col1.add_element(auxMeter)

	// // aux primer
	// var/datum/mojaveUI/element/auxPrimer/auxPrimer = new
	// col1.add_element(auxPrimer)


	// //////// Column 2
	// var/datum/mojaveUI/element/flowContainer/col2 = new /datum/mojaveUI/element/flowContainer()
	// rootContainer.add_element(col2)
	// col2.appearanceType = /datum/mojaveUI/appearance/box/metal
	// col2.flow_direction = MOJAVEUI_FLOW_COLUMN

	// // // Green Amber and Red lights
	// // col2.add_element(makeLightBox())

	// // // var/datum/mojaveUI/element/spacer = new(10)
	// // // col2.add_element(spacer)

	// // // Heat Switch
	// // var/datum/mojaveUI/element/interactive/switch/horizontal/heatSwitch = new
	// // col2.add_element(heatSwitch)

	// // Ignition Button
	// var/datum/mojaveUI/element/interactive/button/black/ignitionButton = new
	// col2.add_element(ignitionButton)

	// /////// Column 3
	// var/datum/mojaveUI/element/flowContainer/col3 = new /datum/mojaveUI/element/flowContainer()
	// rootContainer.add_element(col3)
	// col3.appearanceType = /datum/mojaveUI/appearance/box/metal
	// col3.flow_direction = MOJAVEUI_FLOW_ROW


	// Power Output Toggle
	var/datum/mojaveUI/element/interactive/switch/toggle/powerOutputToggleBig = new
	rootContainer.add_element(powerOutputToggleBig)
	powerOutputToggleBig.min_width = 64

		// Power Output Toggle
	var/datum/mojaveUI/element/interactive/switch/toggle/powerOutputToggle = new
	rootContainer.add_element(powerOutputToggle)


	// Green Amber and Red lights
	// col3.add_element(makeLightBox())
	// col3.add_element(makeLightBox())

	// // var/datum/mojaveUI/element/spacer2 = new(10)
	// // col3.add_element(spacer2)

	// // Power Source Switch
	// var/datum/mojaveUI/element/interactive/switch/horizontal/powerSourceSwitch = new
	// col3.add_element(powerSourceSwitch)


	return rootContainer


/proc/makeLightBox()
	RETURN_TYPE(/datum/mojaveUI/element/flowContainer)

	var/datum/mojaveUI/element/flowContainer/cont = new
	cont.flow_direction = MOJAVEUI_FLOW_COLUMN
	cont.appearanceType = /datum/mojaveUI/appearance/box/metal

	// Green Amber and Red lights
	var/datum/mojaveUI/element/light/green/greenLight2 = new
	cont.add_element(greenLight2)
	var/datum/mojaveUI/element/light/amber/amberLight2 = new
	cont.add_element(amberLight2)
	// var/datum/mojaveUI/element/light/red/redLight2 = new
	// cont.add_element(redLight2)

	return cont
