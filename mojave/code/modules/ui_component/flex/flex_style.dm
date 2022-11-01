
// _ denotes internal vars - use Apply() and pass a html style string to set - this is to capture any invalid values, etc.
/datum/flex_style
	var/_Direction = FLEX_DIRECTION_INHERIT
	var/_FlexDirection = FLEX_FLEXDIRECTION_ROW
	var/_JustifyContent = FLEX_JUSTIFY_FLEXSTART
	var/_AlignContent = FLEX_ALIGN_STRETCH
	var/_AlignItems = FLEX_ALIGN_STRETCH
	var/_AlignSelf = FLEX_ALIGN_AUTO
	var/_PositionType = FLEX_POSITIONTYPE_RELATIVE
	var/_FlexWrap = FLEX_WRAP_NOWRAP
	var/_Overflow = FLEX_OVERFLOW_VISIBLE
	var/_Display = FLEX_DISPLAY_FLEX
	var/_FlexGrow = 0
	var/_FlexShrink = 1
	var/datum/flex_value/_FlexBasis = FLEX_VALUE_AUTO
	var/list/datum/flex_value/_Margin = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/_Position = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/_Padding = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/_Border = FLEX_VALUE_DEFAULTEDGEVALUESUNIT
	var/list/datum/flex_value/_Dimensions = list(FLEX_VALUE_AUTO, FLEX_VALUE_AUTO)
	var/list/datum/flex_value/_MinDimensions = list(FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)
	var/list/datum/flex_value/_MaxDimensions = list(FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)


// Expanded attributes - these are the possible <style> attributes of facebook/yogalayout
// Pass this into flex_style/new() to generate. These get mashed into flex_style's attributes
// Depending on use, we can likely optimize this, or flex_style's attributes out entirely
// TODO: Pass <style></style> string to generate + optimize
/datum/flex_style_attributes

	// DEFAULT
	var/display =  "flex"
	var/overflow =  "visible"
	var/position =  "relative"
	var/align_content =  "stretch"
	var/align_items =  "stretch"
	var/align_self =  "auto"
	var/flex_direction =  "row"
	var/flex_wrap =  "no-wrap"
	var/flex_basis =  "auto"
	var/flex_shrink =  1
	var/flex_grow =  0
	var/justify_content =  "flex-start"
	var/direction = "direction"
	var/left =  "auto"
	var/top =  "auto"
	var/right =  "auto"
	var/bottom =  "auto"
	var/width =  "auto"
	var/height =  "auto"
	var/min_width =  "auto"
	var/min_height =  "auto"
	var/max_width =  "auto"
	var/max_height =  "auto"
	var/margin =  "skip"
	var/margin_left =  0
	var/margin_right =  0
	var/margin_top =  0
	var/margin_bottom =  0
	var/padding =  "skip"
	var/padding_left =  0
	var/padding_right =  0
	var/padding_top =  0
	var/padding_bottom =  0
	var/border_width =  "skip"
	var/border_left_width =  0
	var/border_right_width =  0
	var/border_top_width =  0
	var/border_bottom_width =  0


#define setInList(strName, varName, allowedList) if(strName) if(newValue in allowedList) attribute = newValue; else throw EXCEPTION("[newValue] not in list [##allowedList.Join(", ")]")
/datum/flex_style_attributes/proc/operator[](attribute, newValue)

	try
		switch(attribute)
			setInList("direction", direction, FLEX_DIRECTION_LIST)
		else vars[newValue] = newValue
	catch(var/exception/e)
		stack_trace("Attempt to set \"[attribute]\" to \"[newValue]\" for flex_style_attribute failed.[e] on [e.file]:[e.line]")

#undef setInList
