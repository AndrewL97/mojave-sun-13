

// Light Appearances
/datum/mojaveUI/appearance/light
	icon = 'mojave/icons/hud/mojaveUI/ms_ui_display.dmi'
	icon_state = "light_green_off"
	var/lightColor = "green"
	var/on = FALSE

/datum/mojaveUI/appearance/light/green
	lightColor = "green"

/datum/mojaveUI/appearance/light/red
    lightColor = "red"

/datum/mojaveUI/appearance/light/amber
    lightColor = "amber"

/datum/mojaveUI/appearance/light/get(width=icon_width, height=icon_height)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()
	A.icon_state = "light_[lightColor]_[on ? "on" : "off"]"
	// ICON_DRAW_MIDDLE(A, width, height, 32, 32)
	return A
