// This is the main UI object
// It is a screen object that is shown to the client
// It contains a root element, which is the root of the UI tree
// It also contains a list of children, which are the functional UI objects


/obj/mojaveUI
	// Root element must always be a flow container
	var/datum/mojaveUI/element/flowContainer/root
	var/list/obj/mojaveUI/children = list()
	screen_loc = "CENTER,CENTER"
	appearance_flags = KEEP_TOGETHER
	// When we draw an element, we get the number of layers it uses
	// i.e box appearances are 3 (background, border, corners)
	// This is the max number of layers used by a child element
	// If we draw a functional element, we increment its layers by layersUsed + 1
	// To ensure there are layer fighting issues
	var/layersUsed = 0
	plane = ABOVE_HUD_PLANE
	layer = 0


// Call to begin drawing the UI + show to client
/obj/mojaveUI/proc/Show(client/c)
	// Clear the UI
	_clearUI()
	// Get or generate the root element
	if(!root)
		root = _template()
	// Calculate the layout of the root element
	root.layout()
	// Draw the root element
	_drawElement(0, 0, root, c)
	// Show the UI to the client
	c.screen += src

/obj/mojaveUI/Destroy(datum/D, force, ...)
	. = ..()
	_clearUI()

// Clear the UI - remove all children and overlays
/obj/mojaveUI/proc/_clearUI()
	for(var/obj/mojaveUI/child in children)
		qdel(child)
	children = list()
	overlays = list()
	vis_contents = list()

// Generate Template is where you define the UI layout
// It should return a flow container element
/obj/mojaveUI/proc/_template()
	throw EXCEPTION("Generate Template not implemented")

// This is the main proc that draws the UI
// We start by drawing the root element, and then recursively draw any children
/obj/mojaveUI/proc/_drawElement(x, y, datum/mojaveUI/element/e, client/c, forceDraw = FALSE)

	if(e.hidden)
		return

	// If the element is functional, we create a new object for it, and set this element as the root + forceDraw it
	// Otherwise we just draw the element
	if(e.functional && !forceDraw)
		var/obj/mojaveUI/functionalUIObject = new
		// Increment layer to draw on top
		functionalUIObject.layer = layer + layersUsed + 1
		functionalUIObject.root = e
		functionalUIObject.transform = functionalUIObject.transform.Translate(x,y)
		vis_contents |= functionalUIObject
		// Draw from root - pass forceDraw to draw the functional element
		functionalUIObject._drawElement(0, 0, e, c, TRUE)
		return

	// WE DRAW THE ELEMENT BEFORE ANY CHILDREN,
	// SO CHILDREN ARE DRAWN ON TOP
	_drawOverlay(x, y, e, c)

	if(istype(e, /datum/mojaveUI/element/flowContainer) )
		_drawContainer(x, y, e, c)

// Draw the children of the given element
/obj/mojaveUI/proc/_drawContainer(x, y, datum/mojaveUI/element/flowContainer/e, client/c)

	// Get total flex_x and flex_y of all children + the total width and height of all children
	// This is used to override the calculated width and height of the child elements when they are flexed
	var/total_flex_x = 0
	var/total_flex_y = 0
	var/total_width = 0
	var/total_height = 0
	for(var/datum/mojaveUI/element/child in e.elements)
		total_flex_x += child.flex_x
		total_width += child.calculated_layout["width"]
		total_flex_y += child.flex_y
		total_height += child.calculated_layout["height"]

	// Get remaining space for flexed elements, accounting for padding and spacing
	var/remaining_width = e.calculated_layout["width"] - total_width - (e.padding * 2) - e.spacing * (e.elements.len - 1)
	var/remaining_height = e.calculated_layout["height"] - total_height - (e.padding * 2) - e.spacing * (e.elements.len - 1)

	// Our passed x,y vars are the center of this element
	// So adjust x,y buffer by half the dimensions of the element and padding
	// Padding is only added to the flow direction (i.e x for row, y for col)
	switch(e.flow_direction)
		if(MOJAVEUI_FLOW_ROW)
			x += e.padding - (e.calculated_layout["width"] / 2)
		if(MOJAVEUI_FLOW_ROWREVERSED)
			x += (e.calculated_layout["width"] / 2) - e.padding
		if(MOJAVEUI_FLOW_COLUMN)
			y += (e.calculated_layout["height"] / 2) - e.padding
		if(MOJAVEUI_FLOW_COLUMNREVERSED)
			y += e.padding - (e.calculated_layout["height"] / 2)



	for(var/datum/mojaveUI/element/child in e.elements)

		// Pad by half of child dimension, depending on flow direction
		switch(e.flow_direction)
			if(MOJAVEUI_FLOW_ROW)
				x += _getFlexedWidth(child, total_flex_x, remaining_width) / 2
			if(MOJAVEUI_FLOW_ROWREVERSED)
				x -= _getFlexedWidth(child, total_flex_x, remaining_width) / 2
			if(MOJAVEUI_FLOW_COLUMN)
				y -= _getFlexedHeight(child, total_flex_y, remaining_height) / 2
			if(MOJAVEUI_FLOW_COLUMNREVERSED)
				y += _getFlexedHeight(child, total_flex_y, remaining_height) / 2

		// Draw the child element at the current position
		_drawElement(x, y, child, c)

		// Pad by half again, and spacing
		switch(e.flow_direction)
			if(MOJAVEUI_FLOW_ROW)
				x += (_getFlexedWidth(child, total_flex_x, remaining_width) / 2) + e.spacing
			if(MOJAVEUI_FLOW_ROWREVERSED)
				x -= (_getFlexedWidth(child, total_flex_x, remaining_width) / 2) + e.spacing
			if(MOJAVEUI_FLOW_COLUMN)
				y -= (_getFlexedHeight(child, total_flex_y, remaining_height) / 2) + e.spacing
			if(MOJAVEUI_FLOW_COLUMNREVERSED)
				y += (_getFlexedHeight(child, total_flex_y, remaining_height) / 2) + e.spacing


// Get height and width of element, flex or calculated, whichever is greater
/obj/mojaveUI/proc/_getFlexedWidth(datum/mojaveUI/element/e, total_flex_x, remaining_width)
	return max(e.calculated_layout["width"], e.flex_x * remaining_width / max(total_flex_x, 1)) // min to prevent divide by 0

/obj/mojaveUI/proc/_getFlexedHeight(datum/mojaveUI/element/e, total_flex_y, remaining_height)
	return max(e.calculated_layout["height"], e.flex_y * remaining_height / max(total_flex_y, 1)) // min to prevent divide by 0

// Draw the element at the given position - fetch the appearance object and add it to the overlays
/obj/mojaveUI/proc/_drawOverlay(x, y, datum/mojaveUI/element/e)
	var/mutable_appearance/overlay = e.getAppearance(layer + layersUsed)
	layersUsed += e.getAppearanceLayersUsed()
	if(!overlay)
		// If the element has no appearance, we don't draw it
		// This can be used for "structural" elements like containers
		return
	overlay.transform = overlay.transform.Translate(x,y)
	overlays += overlay
