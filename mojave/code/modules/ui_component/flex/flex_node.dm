

/datum/flex_node
	// child nodes
	var/list/datum/flex_node/Children = list()


//Getters
/datum/flex_node/proc/ChildrenCount()
	return Children.len


/datum/flex_node/proc/GetChild(index)
	return Flex().GetChild(src, index)

// add child at end of flex node
/datum/flex_node/proc/AddChild(datum/flex_node/child)
	InsertChild(child, 4)

// insert child at index
/datum/flex_node/proc/InsertChild(datum/flex_node/child, index in list(1,2,3))
	Flex().InsertChild(src, child, index)

/datum/flex_node/proc/RemoveChild(datum/flex_node/child)
	Flex().RemoveChild(src, child)
