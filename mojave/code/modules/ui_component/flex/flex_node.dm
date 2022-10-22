

/datum/flex_node

	// child nodes
	var/datum/flex_node/list/Children = list()


//Getters
/datum/flex_node/proc/ChildrenCount()
	return Children.len


/datum/flex_node/proc/GetChild(index)
	Flex().GetChild(src, index)

// add child at end of flex node
/datum/flex_node/proc/AddChild(/datum/flex_node/child)
	Flex().InsertChild(src, child, ChildrenCount())

// insert child at index
/datum/flex_node/proc/InsertChild(/datum/flex_node/child, index)
	Flex().InsertChild(src, child, index)

/datum/flex_node/proc/RemoveChild(/datum/flex_node/child)
	Flex().RemoveChild(src, child)
