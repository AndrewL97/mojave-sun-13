
// These are helper procs to make templating easier


// Pass assoc list of element properties
// if no type is passed, it will default to a flowContainer
// Everything else is passed to the SetProperties proc to dynamically set the properties
// a container's elements can be passed as a list of these assoc lists
/proc/MojaveUI_GenerateElement(list/elementDefinition)
	var/elementTypeName = LAZYACCESS(elementDefinition, "type")
	if(!elementTypeName)
		elementTypeName = "flowContainer"

	var/datum/mojaveUI/element/elementType = GLOB.MojaveUIElements[elementTypeName]
	// Check if the type exists
	if(!elementType)
		CRASH("Element type [elementTypeName] not found")

	var/datum/mojaveUI/element/element = new elementType()

	// Loop through the properties and set them on the element
	// if a property is invalid, it will crash
	for(var/property in elementDefinition)
		if(property == "type")
			continue
		var/value = elementDefinition[property]
		element[property] = value

	return element


// return appearance type from name, similar to GLOB.MojaveUIElements
// called from element's [] operator
/proc/MojaveUI_GetAppearanceType(name)
	var/datum/mojaveUI/appearance/appearanceType = GLOB.MojaveUIAppearances[name]
	if(!appearanceType)
		CRASH("Appearance type [name] not found")
	return appearanceType
