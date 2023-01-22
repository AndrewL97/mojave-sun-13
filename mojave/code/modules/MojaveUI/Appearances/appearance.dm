#define ICON_SIZE 32

// Appearances for mojaveUI elements
// Currently there are:
// base - the standard mojaveUI background color
// box - a box with a border
// closeButton - button bar close button - must must be 32x32 or >=64x32
// cell - 32x32 cell w/ border for grids/tables/etc.


/datum/mojaveUI/appearance
	var/baseLayer = HUD_BACKGROUND_LAYER
	var/icon/icon = 'mojave/icons/hud/mojaveUI/ms_ui_base.dmi'

/datum/mojaveUI/appearance/proc/get(width=ICON_SIZE, height=ICON_SIZE, layer=HUD_BACKGROUND_LAYER)
	RETURN_TYPE(/mutable_appearance)
	baseLayer = layer
	var/mutable_appearance/A = mutable_appearance(icon, icon_state = "background", layer = baseLayer, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
	A.transform = matrix().Scale(width / ICON_SIZE, height / ICON_SIZE)
	A.color = "#[random_short_color()]"
	return A

/datum/mojaveUI/appearance/cell/get(width=ICON_SIZE, height=ICON_SIZE)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()
	A.icon_state = "cell"
	// ICON_DRAW_MIDDLE(A, width, height, 32, 32)
	return A


// ======================= BOX ======================= //

/datum/mojaveUI/appearance/box/get(width=ICON_SIZE, height=ICON_SIZE, layer=HUD_BACKGROUND_LAYER)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..() // Apply standard background color
	for(var/i in 0 to 3)
		var/mutable_appearance/bord = borderSide(height,width,i)
		A.overlays += bord
		var/mutable_appearance/corn = borderCorner(height,width,i)
		A.overlays += corn
	return A


// returns a mutable appearance for a border corner - no stretching!
// corner is 0-3 for top left, top right, bottom right, bottom left
/datum/mojaveUI/appearance/box/proc/borderCorner(height,width,corner = 0)

	switch(corner)
		if(0)
			var/mutable_appearance/c = mutable_appearance(icon, icon_state = "border_top_left", layer = baseLayer+2, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			c.pixel_x = ICON_ANCHOR_LEFT(width, ICON_SIZE)
			c.pixel_y = ICON_ANCHOR_TOP(height, ICON_SIZE)
			return c
		if(1)
			var/mutable_appearance/c = mutable_appearance(icon, icon_state = "border_top_right", layer = baseLayer+2, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			c.pixel_x = ICON_ANCHOR_RIGHT(width, ICON_SIZE)
			c.pixel_y = ICON_ANCHOR_TOP(height, ICON_SIZE)
			return c
		if(2)
			var/mutable_appearance/c = mutable_appearance(icon, icon_state = "border_bottom_right", layer = baseLayer+2, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			c.pixel_x = ICON_ANCHOR_RIGHT(width, ICON_SIZE)
			c.pixel_y = ICON_ANCHOR_BOTTOM(height, ICON_SIZE)
			return c
		if(3)
			var/mutable_appearance/c = mutable_appearance(icon, icon_state = "border_bottom_left", layer = baseLayer+2, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			c.pixel_x = ICON_ANCHOR_LEFT(width, ICON_SIZE)
			c.pixel_y = ICON_ANCHOR_BOTTOM(height, ICON_SIZE)
			return c
	throw EXCEPTION("Invalid corner index [corner]")


// Returns a mutable appearance for a border side - stretched to height and width
// side is 0-3 for top, right, bottom, left
/datum/mojaveUI/appearance/box/proc/borderSide(height,width,side = 0)

	switch(side)
		if(0)
			var/mutable_appearance/border = mutable_appearance(icon, icon_state = "border_top", layer = baseLayer+1, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			border.transform = matrix().Scale(width / ICON_SIZE, 1)
			border.pixel_y = ICON_ANCHOR_TOP(height, ICON_SIZE)
			return border
		if(1)
			var/mutable_appearance/border = mutable_appearance(icon, icon_state = "border_right", layer = baseLayer+1, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			border.transform = matrix().Scale(1, height / ICON_SIZE)
			border.pixel_x = ICON_ANCHOR_RIGHT(width, ICON_SIZE)
			return border
		if(2)
			var/mutable_appearance/border = mutable_appearance(icon, icon_state = "border_bottom", layer = baseLayer+1, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			border.transform = matrix().Scale(width / ICON_SIZE, 1)
			border.pixel_y = ICON_ANCHOR_BOTTOM(height, ICON_SIZE)
			return border
		if(3)
			var/mutable_appearance/border = mutable_appearance(icon, icon_state = "border_left", layer = baseLayer+1, plane = ABOVE_HUD_PLANE, appearance_flags = RESET_TRANSFORM)
			border.transform = matrix().Scale(1, height / ICON_SIZE)
			border.pixel_x = ICON_ANCHOR_LEFT(width, ICON_SIZE)
			return border
	throw EXCEPTION("Invalid side index [side]")

// ======================= CLOSE BUTTON ======================= //

/datum/mojaveUI/appearance/closeButton/get(width=ICON_SIZE, height=ICON_SIZE, layer=HUD_BACKGROUND_LAYER)
	RETURN_TYPE(/mutable_appearance)
	var/mutable_appearance/A = ..()
	var/min_width = 20

	// If we are 32 wide or invalid, just use the standard icon
	if(width == ICON_SIZE  || width < min_width)
		A.icon_state = "close"
		return A

	// Otherwise we use the left, middle, and right icons - minimum of 20 pixels per icon
	// left and right are 10x32, middle is 32x32 and is scaled to fit - left and right are added as overlays
	var/mutable_appearance/Left = new()
	Left.icon = 'mojave/icons/hud/mojaveUI/ms_ui_base.dmi'
	Left.icon_state = "close_left"
	Left.pixel_x = ICON_ANCHOR_LEFT(width, 10)
	// Left.appearance_flags = RESET_TRANSFORM
	Left.plane = ABOVE_HUD_PLANE

	var/mutable_appearance/Right = new()
	Right.icon = 'mojave/icons/hud/mojaveUI/ms_ui_base.dmi'
	Right.icon_state = "close_right"
	Right.pixel_x = ICON_ANCHOR_RIGHT(width, 10)
	// Right.appearance_flags = RESET_TRANSFORM
	Right.plane = ABOVE_HUD_PLANE

	A.icon_state = "close_middle"
	A.transform = matrix().Scale((width - 20) / ICON_SIZE, 1)
	A.overlays += Left
	A.overlays += Right
	return A

#undef ICON_SIZE
