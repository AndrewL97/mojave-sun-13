

/datum/flex_node
	// child nodes
	var/list/datum/flex_node/children = list()
	var/datum/flex_style/nodeStyle = new
	var/datum/flex_style/nodeLayout = new
	var/list/datum/flex_value/resolvedDimensions = list(FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)



//Getters
/datum/flex_node/proc/ChildrenCount()
	return children.len



/datum/flex_node/proc/GetChild(index)
	return GLOB.flex.GetChild(src, index)

// add child at end of flex node
/datum/flex_node/proc/AddChild(datum/flex_node/child)
	InsertChild(child, 4)

// insert child at index
/datum/flex_node/proc/InsertChild(datum/flex_node/child, index in list(1,2,3))
	GLOB.flex.InsertChild(src, child, index)

/datum/flex_node/proc/RemoveChild(datum/flex_node/child)
	GLOB.flex.RemoveChild(src, child)
