

// Type list for elements, for fetching by name


/proc/MojaveUI_Init_Elements()
	var/list/elements = list()
	for (var/_element_path in subtypesof(/datum/mojaveUI/element))
		var/datum/mojaveUI/element/element_path = _element_path
		elements[initial(element_path.elementTypeName)] = element_path
	return elements


/proc/MojaveUI_Init_Appearances()
	var/list/appearances = list()
	for (var/_appearance_path in subtypesof(/datum/mojaveUI/appearance))
		var/datum/mojaveUI/appearance/appearance_path = _appearance_path
		appearances[initial(appearance_path.appearanceTypeName)] = appearance_path
	return appearances


GLOBAL_LIST_INIT_TYPED(MojaveUIElements, /datum/mojaveUI/element, MojaveUI_Init_Elements())
GLOBAL_LIST_INIT_TYPED(MojaveUIAppearances, /datum/mojaveUI/appearance, MojaveUI_Init_Appearances())
