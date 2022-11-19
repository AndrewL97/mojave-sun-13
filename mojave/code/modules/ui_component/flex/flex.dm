// Library/factory/magic machine for flex box

// This is a dm conversion https://github.com/ru-ace/Flexbox
// Which in itself is based on previous implementations of facebook/yoga

/datum/flex
	var/list/datum/flex_value/valueDictionarycache
	var/static/currentGenerationCount = 0

/datum/flex/proc/CreateDefaultNode()
	return new /datum/flex_node()



/datum/flex_node/proc/CalculateLayout()


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

	// // Returns [WIDTH, FLEX_MEASUREMODE_???]
	// var/list/WidthMode = calcStartWidth(node, parentWidth)
	// // Returns [HEIGHT, FLEX_MEASUREMODE_???]
	// var/list/HeightMode = calcStartHeight(node, parentWidth, parentHeight)



	// if(layoutNodeInternal(node, WidthMode[0], HeightMode[0], parentDirection, WidthMode[1], HeightMode[1], ParentWidth, ParentHeight, parentHeight, true, "initial", node.config))
	// 	nodeSetPosition(node, node.nodeLayout.Direction, parentWidth, parentHeight, parentWidth);
	// 	roundToPixelGrid(node, node.config.PointScaleFactor, 0, 0);

	// 	if (gPrintTree)
	// 	{
	// 		// NodePrint(node, PrintOptionsLayout|PrintOptionsChildren|PrintOptionsStyle);
	// 		System.Console.WriteLine("NodePrint(node, PrintOptionsLayout|PrintOptionsChildren|PrintOptionsStyle);");
	// 	}


/datum/flex/proc/resolveDimensions(datum/flex_node/node)
	// 0 is width, 1 is height
	for(var/dim in 0 to 1)
		if(node.nodeStyle.MaxDimensions[dim].unit != FLEX_UNIT_UNDEFINED && (node.nodeStyle.MaxDimensions[dim] ~= node.nodeStyle.MinDimensions[dim]))
			node.resolvedDimensions[dim] = node.nodeStyle.MaxDimensions[dim]
		else
			node.resolvedDimensions[dim] = node.nodeStyle.Dimensions[dim]


