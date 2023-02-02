

// Lights

/datum/mojaveUI/element/light
	appearanceType = /datum/mojaveUI/appearance/light
	var/on = FALSE

/datum/mojaveUI/element/light/green
	appearanceType = /datum/mojaveUI/appearance/light/green

/datum/mojaveUI/element/light/red
	appearanceType = /datum/mojaveUI/appearance/light/red

/datum/mojaveUI/element/light/amber
	appearanceType = /datum/mojaveUI/appearance/light/amber

/datum/mojaveUI/element/light/getAppearanceObject()
	. = ..()

	if(istype(.,/datum/mojaveUI/appearance/light))
		var/datum/mojaveUI/appearance/light/L = .
		L.on = on

	return .
