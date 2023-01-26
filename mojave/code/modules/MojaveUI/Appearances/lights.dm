

// Light Appearances
/datum/mojaveUI/appearance/light
    var/lightColor = "green"

/datum/mojaveUI/appearance/light/green
	lightColor = "green"

/datum/mojaveUI/appearance/light/red
    lightColor = "red"

/datum/mojaveUI/appearance/light/amber
    lightColor = "amber"

/datum/mojaveUI/appearance/light/get(width=ICON_SIZE, height=ICON_SIZE)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()
	A.icon_state = "cell"
	// ICON_DRAW_MIDDLE(A, width, height, 32, 32)
	return A
