// Library/factory for flex box
// This is a dm conversion https://github.com/ru-ace/Flexbox

// Returns a flex_factory datum, so I don't have to keep writing the entire path
// This is so I can pretend Byond has statics

var/datum/flex/flex_singleton = null
/proc/Flex()
	if(!flex_singleton)
		flex_singleton = new
	return flex_singleton

/datum/flex/proc/CreateDefaultNode()
	return new /datum/flex_node()

// /datum/flex_factory/proc/CreateDefaultNode_Style()

// /datum/flex_factory/proc/CreateDefaultNode_Config()

/datum/flex/proc/GetChild(/datum/flex_node/parent, index)
	//TODO

/datum/flex/proc/InsertChild(/datum/flex_node/parent, /datum/flex_node/child, index)
	//TODO

/datum/flex/proc/RemoveChild(/datum/flex_node/parent, index)
	//TODO
