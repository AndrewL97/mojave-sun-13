// _ denotes internal vars - use Apply() and pass a html style string to set - this is to capture any invalid values, etc.
/datum/flex_style
	var/Direction = FLEX_DIRECTION_INHERIT
	var/FlexDirection = FLEX_FLEXDIRECTION_ROW
	var/JustifyContent = FLEX_JUSTIFY_FLEXSTART
	var/AlignContent = FLEX_ALIGN_STRETCH
	var/AlignItems = FLEX_ALIGN_STRETCH
	var/AlignSelf = FLEX_ALIGN_AUTO
	var/PositionType = FLEX_POSITIONTYPE_RELATIVE
	var/FlexWrap = FLEX_WRAP_NOWRAP
	var/Overflow = FLEX_OVERFLOW_VISIBLE
	var/Display = FLEX_DISPLAY_FLEX
	var/FlexGrow = 0
	var/FlexShrink = 1
	var/datum/flex_value/FlexBasis = FLEX_VALUE_AUTO
	var/list/datum/flex_value/Margin = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/Position = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/Padding = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/Border = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/Dimensions = list(FLEX_VALUE_AUTO, FLEX_VALUE_AUTO)
	var/list/datum/flex_value/MinDimensions = list(FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)
	var/list/datum/flex_value/MaxDimensions = list(FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)

	var/datum/flex_style_attributes/attributes = new

	// Change tracking for dirty checks and comparisons
	var/list/layoutAttributesChanged
	// var/list/attributesWere


	// Filthy inherit hacks, because ace-ru couldn't fix it, and I haven't tried
	var/list/inheritHacks = list("direction" = "ltr")

	//Not implemented - see original ace-ru .net lib if you ever want to do this to yourself
	//var/datum/flex_style_attributes/attribeAnimated



// Expanded attributes - these are the possible <style> attributes of facebook/yogalayout
// Pass this into flex_style/new() to generate. These get mashed into flex_style's attributes
// Depending on use, we can likely optimize this, or flex_style's attributes out entirely
// TODO: Pass <style></style> string to generate + optimize
/datum/flex_style_attributes

	// mm delicious hardcoded confusion
	// margin, padding, and border have a value of "skip" - instead we get/set the edge values
	// top, left, bottom, right

	var/display =   "flex"
	var/overflow =   "visible"
	var/position =   "relative"
	var/align_content =   "stretch"
	var/align_items =   "stretch"
	var/align_self =   "auto"
	var/flex_direction =   "row"
	var/flex_wrap =   "no-wrap"
	var/flex_basis =   "auto"
	var/flex_shrink =   1
	var/flex_grow =   0
	var/justify_content =   "flex-start"
	var/direction =  "direction"
	var/left =   "auto"
	var/top =   "auto"
	var/right =   "auto"
	var/bottom =   "auto"
	var/width =   "auto"
	var/height =   "auto"
	var/min_width =   "auto"
	var/min_height =   "auto"
	var/max_width =   "auto"
	var/max_height =   "auto"
	var/margin =   "skip"
	var/margin_left =   0
	var/margin_right =   0
	var/margin_top =   0
	var/margin_bottom =   0
	var/padding =   "skip"
	var/padding_left =   0
	var/padding_right =   0
	var/padding_top =   0
	var/padding_bottom =   0
	var/border_width =   "skip"
	var/border_left_width =   0
	var/border_right_width =   0
	var/border_top_width =   0
	var/border_bottom_width =   0


// // Getter - mostly handles an inherit hack - we probably don't even need this
// // TODO: check if I can remove this
// /datum/flex_style/proc/operator[](attribute)
// 	if(!(attribute in attributes.vars))
// 		throw EXCEPTION("Attempted to retrieve invalid attribute \"[attribute]\" from flex_style.")
// 	var/value = attributes[attribute]
// 	if(value = "inherit") // If we are inheriting, check if we have a filthy hack for it
// 		value = inheritHacks[attribute] || value


// Setters - special handling, etc.
#define setInList(strName, varName, allowedList) if(strName) if(newValue in allowedList) attribute = newValue; else throw EXCEPTION("[newValue] not in list [##allowedList.Join(", ")]")

#define FLEX_EDGENAME_TO_ID list("left" = FLEX_EDGE_LEFT,   \
								 "top" = FLEX_EDGE_TOP,     \
								 "right" = FLEX_EDGE_RIGHT, \
								 "bottom" = FLEX_EDGE_BOTTOM)

/datum/flex_style/proc/operator[](attribute, newValue)
	try
		newValue = trim(newValue)

		// if we are setting margin, padding, or border-width, we only want to set edges
		// We also don't use change tracking, as the nested set will catch it
		// i.e convert Margin to Magin-Left, Margin-Top, Margin-Right, Margin-Bottom
		if(attribute == "margin" || attribute == "padding" || attribute == "border-width")

			// border-width gets edges inserted in the middle (i.e border-left-width), so handle
			var/name = attribute == "border-width" ? "border" : attribute
			var/tail = attribute == "border-width" ? "-width" : ""
			var/list/datum/flex_value/val
			if(GLOB.flex.ParseFourValueFromString(newValue, val))
				for(var/side in FLEX_EDGENAME_TO_ID)
					// src[border-left-width] = xyz -> rounded to two decimal places
					src[name + "-" + side + tail] = round(text2num(val[FLEX_EDGENAME_TO_ID[FLEX_EDGE_LEFT]].value), 0.01)
			else
				throw EXCEPTION("Failed to parse attribute \"[attribute]:[newValue]\"")
			return

		// Catch dumb dumbs
		if(!(attribute in attributes.vars))
			throw EXCEPTION("Attempted to set invalid style attribute \"[attribute]:[newValue]\"")

		// Normal values
		// TODO: setMode for change tracking
		LAZYINITLIST(layoutAttributesChanged)
		layoutAttributesChanged[attribute] = attributes[attribute]
		attributes[attribute] = newValue
		if (!GLOB.flex.ParseStyleAttr(src, attribute, newValue))
			throw EXCEPTION("Failed to parse attribute \"[attribute]:[newValue]\"")

	catch(var/exception/e)
		throw EXCEPTION ("Attempt to set \"[attribute]\" to \"[newValue]\" for flex_style failed. [e] on [e.file]:[e.line]")
#undef FLEX_EDGENAME_TO_ID


// Apply styles to current state
/datum/flex_style/proc/Apply(style)

	if (trim(style)) Parse(style)
	// CleanupLayoutAttributeChanged()

// simple parser for css style text. comments must be removed.
/datum/flex_style/proc/Parse(style)
	var/list/items = splittext(style, ";");
	for (var/item in items)
		if (trim(item) == "") continue
		var/list/part = splittext(trim(item), ":")
		if (part.len == 2)
			src[trim(part[0])] = trim(part[1])
		else
			throw EXCEPTION("Failed to parse style [item] in [style]")
