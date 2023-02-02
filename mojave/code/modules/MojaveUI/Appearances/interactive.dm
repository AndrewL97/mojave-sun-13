

// Light Appearances
/datum/mojaveUI/appearance/interactive
	icon = 'mojave/icons/hud/mojaveUI/ms_ui_input.dmi'
	icon_state = "button_black"
	var/on = FALSE

/datum/mojaveUI/appearance/interactive/button/black
	icon_state = "button_black"

/datum/mojaveUI/appearance/interactive/button/red
	icon_state = "button_red"


/datum/mojaveUI/appearance/interactive/switch/horizontal
	icon_state = "switch_h"

/datum/mojaveUI/appearance/interactive/switch/vertical
	icon_state = "switch_v"

/datum/mojaveUI/appearance/interactive/switch/toggle
	icon_state = "toggle"

/datum/mojaveUI/appearance/interactive/switch/dial
	icon_state = "dial"


/datum/mojaveUI/appearance/interactive/get(width=icon_width, height=icon_height)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()
	A.icon_state = "[icon_state]_[on ? "on" : "off"]"
	// ICON_DRAW_MIDDLE(A, width, height, 32, 32)
	return A


