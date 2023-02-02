

// buttons and switches

/datum/mojaveUI/element/interactive
	appearanceType = /datum/mojaveUI/appearance/interactive
	var/on = FALSE

/datum/mojaveUI/element/interactive/button/black
	appearanceType = /datum/mojaveUI/appearance/interactive/button/black

/datum/mojaveUI/element/interactive/button/red
	appearanceType = /datum/mojaveUI/appearance/interactive/button/red

/datum/mojaveUI/element/interactive/switch/horizontal
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/horizontal

/datum/mojaveUI/element/interactive/switch/vertical
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/vertical

/datum/mojaveUI/element/interactive/switch/toggle
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/toggle

/datum/mojaveUI/element/interactive/switch/dial
	appearanceType = /datum/mojaveUI/appearance/interactive/switch/dial

/datum/mojaveUI/element/interactive/getAppearanceObject()
	. = ..()

	if(istype(.,/datum/mojaveUI/appearance/light))
		var/datum/mojaveUI/appearance/light/L = .
		L.on = on

	return .





