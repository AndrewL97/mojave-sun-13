
// Appearances for mojaveUI elements
// Currently there are:
// base - the standard mojaveUI background color
// box - a box with a border
// closeButton - button bar close button - must must be 32x32 or >=64x32
// cell - 32x32 cell w/ border for grids/tables/etc.


/datum/mojaveUI/appearance
	var/baseLayer = HUD_BACKGROUND_LAYER
	var/icon/icon = 'mojave/icons/hud/mojaveUI/ms_ui_base.dmi'
	var/layersUsed = 1 // THIS MUST BE SET IF YOU USE MORE THAN ONE LAYER -- SEE BOX FOR EXAMPLE
	var/icon_state = "" // Sets the base layer icon state - use "" when mixing scaled and unscaled icons - see Box for example
	var/icon_height = 32
	var/icon_width = 32
	var/appearance_flags = RESET_TRANSFORM

/datum/mojaveUI/appearance/proc/get(width=icon_width, height=icon_height, layer=HUD_BACKGROUND_LAYER)
	RETURN_TYPE(/mutable_appearance)
	baseLayer = layer

	// We make a dummy overlay to handle the KEEP_TOGETHER appearance
	// previously this was the background icon, but the scaling was causing issues
	var/mutable_appearance/A = mutable_appearance(icon, icon_state, baseLayer, plane = ABOVE_HUD_PLANE, appearance_flags = KEEP_TOGETHER)
	A.transform.anchor_center(width, icon_width, height, icon_height)
	// A.color = "#[random_short_color()]"
	return A

/datum/mojaveUI/appearance/cell
	icon_state = "cell"

// ======================= BOX ======================= //

// Metalic version of box appearance - need way to handle theme properly
/datum/mojaveUI/appearance/box/metal/icon = 'mojave/icons/hud/mojaveUI/ms_ui_base_metal.dmi'

/datum/mojaveUI/appearance/box/layersUsed = 3 // THIS MUST BE UPDATED IF MODIFYING THE BOX APPEARANCE

/datum/mojaveUI/appearance/box/get(width=icon_width, height=icon_height, layer=HUD_BACKGROUND_LAYER)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()

	// Apply standard background color
	var/mutable_appearance/bg = mutable_appearance(icon, icon_state = "background", layer = baseLayer, plane = ABOVE_HUD_PLANE)
	bg.transform = matrix().Scale(width / icon_width, height / icon_height)
	A.overlays += bg
	A.overlays += getBorders(height, width)
	A.overlays += getCorners(height, width)
	return A


// returns a mutable appearance for a border corner - no stretching!
// corner is 0-3 for top left, top right, bottom right, bottom left
/datum/mojaveUI/appearance/box/proc/getCorners(height,width)

	var/list/mutable_appearance/corners = list(
		mutable_appearance(icon, icon_state = "border_top_left", layer = baseLayer + 2, plane = ABOVE_HUD_PLANE),
		mutable_appearance(icon, icon_state = "border_top_right", layer = baseLayer + 2, plane = ABOVE_HUD_PLANE),
		mutable_appearance(icon, icon_state = "border_bottom_right", layer = baseLayer + 2, plane = ABOVE_HUD_PLANE),
		mutable_appearance(icon, icon_state = "border_bottom_left", layer = baseLayer + 2, plane = ABOVE_HUD_PLANE)
	)

	// transforms

	// top left
	corners[1].transform = corners[1].transform.anchor_top_left(width, icon_width, height, icon_height)

	// top right
	corners[2].transform = corners[2].transform.anchor_top_right(width, icon_width, height, icon_height	)

	// bottom right
	corners[3].transform = corners[3].transform.anchor_bottom_right(width, icon_width, height, icon_height)

	// bottom left
	corners[4].transform = corners[4].transform.anchor_bottom_left(width, icon_width, height, icon_height)

	return corners

// Returns a mutable appearance for a border side - stretched to height and width
// side is 0-3 for top, right, bottom, left
/datum/mojaveUI/appearance/box/proc/getBorders(height,width)

	var/list/mutable_appearance/borders = list(
		mutable_appearance(icon, icon_state = "border_top", layer = baseLayer + 1, plane = ABOVE_HUD_PLANE),
		mutable_appearance(icon, icon_state = "border_right", layer = baseLayer + 1, plane = ABOVE_HUD_PLANE),
		mutable_appearance(icon, icon_state = "border_bottom", layer = baseLayer + 1, plane = ABOVE_HUD_PLANE),
		mutable_appearance(icon, icon_state = "border_left", layer = baseLayer + 1, plane = ABOVE_HUD_PLANE)
	)

	// transforms

	// top
	borders[1].transform = borders[1].transform.Scale(width / icon_width, 1).anchor_top(height,icon_height)
	// right
	borders[2].transform = borders[2].transform.Scale(1, height / icon_height).anchor_right(width, icon_width)
	// bottom
	borders[3].transform = borders[3].transform.Scale(width / icon_width, 1).anchor_bottom(height, icon_height)
	// left
	borders[4].transform = borders[4].transform.Scale(1, height / icon_height).anchor_left(width, icon_width)

	return borders

// ======================= CLOSE BUTTON ======================= //

/datum/mojaveUI/appearance/closeButton/layersUsed = 2
/datum/mojaveUI/appearance/closeButton/get(width=icon_width, height=icon_height, layer=HUD_BACKGROUND_LAYER)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()
	var/min_width = 20

	// If we are 32 wide or invalid, just use the standard icon
	if(width == icon_width  || width < min_width)
		A.icon_state = "close"
		return A

	// Otherwise we use the left, middle, and right icons - minimum of 20 pixels per icon
	// left and right are 10x32, middle is 32x32 and is scaled to fit - left and right are added as overlays
	var/mutable_appearance/Left = mutable_appearance(icon, icon_state = "close_left", layer = baseLayer+1, plane = ABOVE_HUD_PLANE)
	// icon is 10 px wide
	Left.transform.anchor_left(width, 10)

	var/mutable_appearance/Right = mutable_appearance(icon, icon_state = "close_right", layer = baseLayer+1, plane = ABOVE_HUD_PLANE)
	// icon is 10 px wide
	Right.transform.anchor_right(width, 10)

	// middle is 20 px wide, but scalable horizontally
	A.icon_state = "close_middle"
	A.transform = matrix().Scale((width - 20) / icon_width, 1)
	A.overlays += Left
	A.overlays += Right
	return A
