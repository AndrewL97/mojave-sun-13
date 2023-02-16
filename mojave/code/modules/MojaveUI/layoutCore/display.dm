

// Lights

/datum/mojaveUI/element/light
	elementTypeName = "display.light"
	appearanceType = /datum/mojaveUI/appearance/light
	// If these icons are moved from a 32x32 dmi, this will need to be moved to the appearance
	// min_height = 11
	// min_width = 10
	var/on = FALSE
	var/big = FALSE
	var/lightColor = "green"

/datum/mojaveUI/element/light/operator[]=(key, value)
	switch(key)
		if("on")
			on = value
			if(UIObject)
				UIObject.drawObject(TRUE)
		if("big")
			big = value
		if("lightColor")
			lightColor = value
		else
			..()


/datum/mojaveUI/element/light/big
	elementTypeName = "display.light.big"
	big = TRUE
	min_width = 15
	min_height = 8

/datum/mojaveUI/element/light/green
	elementTypeName = "display.light.green"
	lightColor = "green"

/datum/mojaveUI/element/light/big/green
	elementTypeName = "display.light.big.green"
	lightColor = "green"

/datum/mojaveUI/element/light/red
	elementTypeName = "display.light.red"
	lightColor = "red"

/datum/mojaveUI/element/light/big/red
	elementTypeName = "display.light.big.red"
	lightColor = "red"

/datum/mojaveUI/element/light/amber
	elementTypeName = "display.light.amber"
	lightColor = "amber"

/datum/mojaveUI/element/light/big/amber
	elementTypeName = "display.light.big.amber"
	lightColor = "amber"

/datum/mojaveUI/element/light/getAppearanceObject()
	. = ..()

	if(istype(.,/datum/mojaveUI/appearance/light))
		var/datum/mojaveUI/appearance/light/L = .
		L.on = on
		L.big = big
		L.lightColor = lightColor

	return .
