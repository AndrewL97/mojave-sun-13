// Library/factory/magic machine for flex box

// This is a dm conversion https://github.com/ru-ace/Flexbox
// Which in itself is based on previous implementations of facebook/yoga

/datum/flex
	var/list/datum/flex_value/valueDictionarycache
	var/static/currentGenerationCount = 0
	var/list/flexDim = list(FLEX_DIMENSION_HEIGHT, FLEX_DIMENSION_HEIGHT, FLEX_DIMENSION_WIDTH, FLEX_DIMENSION_WIDTH)

/datum/flex/proc/CreateDefaultNode()
	return new /datum/flex_node()



// /datum/flex_factory/proc/CreateDefaultNode_Style()

// /datum/flex_factory/proc/CreateDefaultNode_Config()

/datum/flex/proc/GetChild(datum/flex_node/parent_node, index)
	//TODO

/datum/flex/proc/InsertChild(datum/flex_node/parent_node, datum/flex_node/child, index)
	//TODO

/datum/flex/proc/RemoveChild(datum/flex_node/parent_node, index)
	//TODO


// The main dude - pass in your root node, and this calculates layout, positions, etc.
/datum/flex/proc/CalculateLayout(datum/flex_node/node, parentWidth, parentHeight, parentDirection)
	// Increment the generation count. This will force the recursive routine to
	// visit
	// all dirty nodes at least once. Subsequent visits will be skipped if the
	// input
	// parameters don't change.
	currentGenerationCount++

	resolveDimensions(node)

	// Returns [WIDTH, FLEX_MEASUREMODE_???, HEIGHT, FLEX_MEASUREMODE_???]
	var/list/startDimensions = CalcStartDimensions(node, parentWidth, parentHeight)

	if(layoutNodeInternal(node, width, height, parentDirection, widthMeasureMode, heightMeasureMode, parentWidth, parentHeight, TRUE, "initial", node.config))
		nodeSetPosition(node, node.nodeLayout.Direction, parentWidth, parentHeight, parentWidth)
		roundToPixelGrid(node, node.config.PointScaleFactor, 0, 0)

	// if(layoutNodeInternal(node, WidthMode[0], HeightMode[0], parentDirection, WidthMode[1], HeightMode[1], ParentWidth, ParentHeight, parentHeight, true, "initial", node.config))
	// 	nodeSetPosition(node, node.nodeLayout.Direction, parentWidth, parentHeight, parentWidth);
	// 	roundToPixelGrid(node, node.config.PointScaleFactor, 0, 0);

	// 	if (gPrintTree)
	// 	{
	// 		// NodePrint(node, PrintOptionsLayout|PrintOptionsChildren|PrintOptionsStyle);
	// 		System.Console.WriteLine("NodePrint(node, PrintOptionsLayout|PrintOptionsChildren|PrintOptionsStyle);");
	// 	}

// resolve dimensions, between min/max
/datum/flex/proc/resolveDimensions(datum/flex_node/node)
	// 0 is width, 1 is height
	for(var/dim in 0 to 1)
		if(node.nodeStyle.MaxDimensions[dim].unit != FLEX_UNIT_UNDEFINED && (node.nodeStyle.MaxDimensions[dim] ~= node.nodeStyle.MinDimensions[dim]))
			node.resolvedDimensions[dim] = node.nodeStyle.MaxDimensions[dim]
		else
			node.resolvedDimensions[dim] = node.nodeStyle.Dimensions[dim]


/datum/flex/proc/nodeMargin(datum/flex_node/node, flex_direction_axis, widthSize, leading = TRUE)
	var/marginEdge = FLEX_GET_MARGIN_EDGE(leading, flex_direction_axis)
	var/datum/flex_value/margin = node.nodeStyle.Margin[leading ? FLEX_EDGE_START : FLEX_EDGE_END]
	if(FLEX_FLEXDIRECTION_IS_ROW(flex_direction_axis) && margin.unit != FLEX_UNIT_UNDEFINED)
		return FLEX_RESOLVE_VALUE_MARGIN(margin, widthSize)

	var/datum/flex_value/v = FLEX_COMPUTE_EDGE_VALUE(node.nodeStyle.Margin, marginEdge, FLEX_VALUE_ZERO)
	return FLEX_RESOLVE_VALUE_MARGIN(v, widthSize)






/datum/flex/proc/nodeMarginForAxis(datum/flex_node/node, flex_direction_axis, widthSize)
	var/leadingMargin = FLEX_RESOLVE_VALUE(node.nodeStyle.Margin[flex_direction_axis], widthSize)
	var/trailingMargin = FLEX_RESOLVE_VALUE(node.nodeStyle.Margin[flex_direction_axis + 2], widthSize)
	return leadingMargin + trailingMargin

/datum/flex/proc/nodeStyleDimensionsDefined(datum/flex_node/node, flex_direction_axis, parentSize)

	// get node's dimension from FLEX_FLEXDIRECTION (up, down, left, right)
	var/datum/flex_value/tempDim = node.resolvedDimensions[flexDim[flex_direction_axis]]
	// if the value's unit is auto, undefined, or invalid, we are undefined
	var/notDefined = (
		(tempDim.unit == FLEX_UNIT_AUTO) || \
		(tempDim.unit == FLEX_UNIT_UNDEFINED) || \
		(tempDim.unit == FLEX_UNIT_POINT && tempDim.value < 0) || \
		(tempDim.unit == FLEX_UNIT_PERCENT && (tempDim.value < 0 || !isnum(parentSize))))
	return !notDefined



// Combines calcStartWidth and calcStartHeight from the original library
// Returns [WIDTH, FLEX_MEASUREMODE_???, HEIGHT, FLEX_MEASUREMODE_???]
/datum/flex/proc/CalcStartDimensions(datum/flex_node/node, parentWidth, parentHeight)

	// output vars
	var/out_width = 0
	var/out_height = 0
	var/out_measuremode_width = FLEX_MEASUREMODE_UNDEFINED
	var/out_measuremode_height = FLEX_MEASUREMODE_UNDEFINED

	// check if width is defined in nodes style for row direction
	if(nodeStyleDimensionsDefined(node, FLEX_FLEXDIRECTION_ROW, parentWidth))
		// resolve the width value using the parent width
		var/width = FLEX_RESOLVE_VALUE(node.resolvedDimensions[FLEX_FLEXDIRECTION_ROW], parentWidth)
		// add the margin for the row direction
		var/margin = nodeMarginForAxis(node, FLEX_FLEXDIRECTION_ROW, parentWidth)
		out_width = width + margin
		out_measuremode_width = FLEX_MEASUREMODE_EXACTLY
	// check if the maximum width is defined in the node's style
	else if(FLEX_RESOLVE_VALUE(node.nodeStyle.MaxDimensions[FLEX_DIMENSION_WIDTH], parentWidth) > 0)
		// Set the output width and measurement mode using the maximum width
		out_width = FLEX_RESOLVE_VALUE(node.nodeStyle.MaxDimensions[FLEX_DIMENSION_WIDTH], parentWidth)
		out_measuremode_width = FLEX_MEASUREMODE_ATMOST
	else
		// set the output width and measurement mode using the parent width
		out_width = parentWidth
		out_measuremode_width = out_width ? FLEX_MEASUREMODE_EXACTLY : FLEX_MEASUREMODE_UNDEFINED

	// check if the height is defined in the node's style for column direction
	if(nodeStyleDimensionsDefined(node, FLEX_FLEXDIRECTION_COLUMN, parentHeight))
		// resolve the height value using the parent height
		var/height = FLEX_RESOLVE_VALUE(node.resolvedDimensions[FLEX_FLEXDIRECTION_COLUMN], parentHeight)
		// add the margin for the column direction
		var/margin = nodeMarginForAxis(node, FLEX_FLEXDIRECTION_COLUMN, parentWidth)
		out_height = height + margin
		out_measuremode_height = FLEX_MEASUREMODE_EXACTLY
	// check if the maximum height is defined in the node's style
	else if(FLEX_RESOLVE_VALUE(node.nodeStyle.MaxDimensions[FLEX_DIMENSION_HEIGHT], parentHeight) > 0)
		// Set the output height and measurement mode using the maximum height
		out_height = FLEX_RESOLVE_VALUE(node.nodeStyle.MaxDimensions[FLEX_DIMENSION_HEIGHT], parentHeight)
		out_measuremode_height = FLEX_MEASUREMODE_ATMOST
	else
		// set the output height and measurement mode using the parent height
		out_height = parentHeight
		out_measuremode_height = out_height ? FLEX_MEASUREMODE_EXACTLY : FLEX_MEASUREMODE_UNDEFINED

	return list(out_width, out_measuremode_width, out_height, out_measuremode_height)

// layoutNodeInternal is a wrapper around the YGNodelayoutImpl function. It determines
// whether the layout request is redundant and can be skipped.
//
// Parameters:
//  Input parameters are the same as YGNodelayoutImpl (see above)
//  Return parameter is true if layout was performed, false if skipped
/datum/flex/proc/layoutNodeInternal
