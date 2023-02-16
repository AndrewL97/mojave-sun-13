

// Light Appearances
/datum/mojaveUI/appearance/light
	appearanceTypeName = "light"
	icon = 'mojave/icons/hud/mojaveUI/ms_ui_display.dmi'
	icon_state = "light_green_off"
	var/lightColor = "green"
	var/big = FALSE // If the light is big or not
	var/on = FALSE // If the light is on or not

/datum/mojaveUI/appearance/light/get(width=icon_width, height=icon_height)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()
	A.icon_state = "light_[lightColor]_[on ? "on" : "off"][big ? "_big" : ""]]"
	// ICON_DRAW_MIDDLE(A, width, height, 32, 32)
	return A
