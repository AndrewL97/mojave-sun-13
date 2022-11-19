


// VALUE PARSERS


// Converts a string into a a flex_value - store in valueDictionarycache to speed up future conversions
/datum/flex/proc/ParseValueFromString(text, datum/flex_value/result)
	var/parsed = TRUE;

	// Auto is easy to convert - should we cache this??
	if(text == "auto")
		result = new(0, FLEX_UNIT_AUTO)
		return TRUE


	// Check cache
	LAZYINITLIST(valueDictionarycache)
	if(valueDictionarycache[text])
		result = valueDictionarycache[text]
		return TRUE

	var/datum/flex_value/tempValue = FLEX_VALUE_UNDEFINED
	var/valueString = text
	var/tempUnit = FLEX_UNIT_POINT

	if(ENDSWITH(text, "%"))
		valueString = copytext(text, 1, length(text)) // drop last character
		tempUnit = FLEX_UNIT_PERCENT
	else if(ENDSWITH(text, "px"))
		valueString = copytext(text, 1, length(text)-1) // drop last two characters
		tempUnit = FLEX_UNIT_PERCENT

	tempValue.value = text2num(valueString)
	if(isnull(tempValue.value))
		parsed = FALSE
		tempValue.value = FLEX_UNIT_UNDEFINED
	else
		tempValue.unit = tempUnit

	valueDictionarycache[text] = tempValue
	result = tempValue
	return parsed


// Accepts a space delimited list of up to four values
// Converts it into an edge list - i.e "10 0 10 0" for 10pts top and bottom
/datum/flex/proc/ParseFourValueFromString(text, list/datum/flex_value/result)
	result = list()

	var/list/strList = splittext(text, regex("\\s+"))
	if( strList.len > 4) return FALSE

	// Attempt to generate a value list from our string input
	var/list/datum/flex_value/tempList[strList.len]
	for(var/i=1, i<=tempList.len, i++)
		if(!ParseValueFromString(strList[i], tempList[i]))
			return FALSE

	/* from mozilla docs:
	When one value is specified, it applies the same margin to all four sides.
	When two values are specified, the first margin applies to the top and bottom, the second to the left and right.
	When three values are specified, the first margin applies to the top, the second to the right and left, the third to the bottom.
	When four values are specified, the margins apply to the top, right, bottom, and left in that order (clockwise).
	 */

	// 8 length value list, for each FLEX_EDGE enum
	switch(tempList.len)
		if(1) result = list(tempList[0],tempList[0],tempList[0],tempList[0], FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)
		if(2) result = list(tempList[1],tempList[0],tempList[1],tempList[0], FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)
		if(3) result = list(tempList[1],tempList[0],tempList[1],tempList[2], FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)
		if(4) result = list(tempList[3],tempList[0],tempList[1],tempList[2], FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED)
		else
			// length of 0 or more than 4
			result = null

	return result != null


/datum/flex/proc/StringToDirection(attrValue, list/result)
	switch(attrValue)
		if("auto")			result = list(FLEX_ALIGN_AUTO)
		if("flex-start")			result = list(FLEX_ALIGN_FLEXSTART)
		if("center")			result = list(FLEX_ALIGN_CENTER)
		if("flex-end")			result = list(FLEX_ALIGN_FLEXEND)
		if("stretch")			result = list(FLEX_ALIGN_STRETCH)
		if("baseline")			result = list(FLEX_ALIGN_BASELINE)
		if("space-between")			result = list(FLEX_ALIGN_SPACEBETWEEN)
		if("space-around")			result = list(FLEX_ALIGN_SPACEAROUND)
	return TRUE

/datum/flex/proc/StringToAlign(attrValue, list/result)
	switch (attrValue)
		if("auto") result = list(FLEX_ALIGN_AUTO)
		if("flex-start") result = list(FLEX_ALIGN_FLEXSTART)
		if("center") result = list(FLEX_ALIGN_CENTER)
		if("flex-end") result = list(FLEX_ALIGN_FLEXEND)
		if("stretch") result = list(FLEX_ALIGN_STRETCH)
		if("baseline") result = list(FLEX_ALIGN_BASELINE)
		if("space-between") result = list(FLEX_ALIGN_SPACEBETWEEN)
		if("space-around") result = list(FLEX_ALIGN_SPACEAROUND)
		else return FALSE
	return TRUE

/datum/flex/proc/StringToFlexDirection(attrValue, list/result)
	switch(attrValue)
		if("column")			result = list(FLEX_FLEXDIRECTION_COLUMN)
		if("column-reverse")			result = list(FLEX_FLEXDIRECTION_COLUMNREVERSE)
		if("row")			result = list(FLEX_FLEXDIRECTION_ROW)
		if("row-reverse")			result = list(FLEX_FLEXDIRECTION_ROWREVERSE)
		else return FALSE
	return TRUE

/datum/flex/proc/StringToJustify(attrValue, list/result)
	switch (attrValue)
		if("flex-start")			result = list(FLEX_JUSTIFY_FLEXSTART)
		if("center")			result = list(FLEX_JUSTIFY_CENTER)
		if("flex-end")			result = list(FLEX_JUSTIFY_FLEXEND)
		if("space-between")			result = list(FLEX_JUSTIFY_SPACEBETWEEN)
		if("space-around")			result = list(FLEX_JUSTIFY_SPACEAROUND)
		else return FALSE
	return TRUE

/datum/flex/proc/StringToWrap(attrValue, list/result)
	switch (attrValue)
		if("nowrap")			result = list(FLEX_JUSTIFY_FLEXSTART)
		if("wrap")			result = list(FLEX_JUSTIFY_CENTER)
		if("wrap-reverse")			result = list(FLEX_JUSTIFY_FLEXEND)
		else return FALSE
	return TRUE

/datum/flex/proc/StringToOverflow(attrValue, list/result)
	switch (attrValue)
		if("visible")			result = list(FLEX_OVERFLOW_VISIBLE)
		if("hidden")			result = list(FLEX_OVERFLOW_HIDDEN)
		if("scroll")			result = list(FLEX_OVERFLOW_SCROLL)
		else return FALSE
	return TRUE


/datum/flex/proc/StringToDisplay(attrValue, list/result)
	switch (attrValue)
		if("flex")			result = list(FLEX_DISPLAY_FLEX)
		if("none")			result = list(FLEX_DISPLAY_NONE)
		else return FALSE
	return TRUE


/datum/flex/proc/StringToPositionType(attrValue, list/result)
	switch (attrValue)
		if("relative")			result = list(FLEX_POSITIONTYPE_RELATIVE)
		if("absolute")			result = list(FLEX_POSITIONTYPE_ABSOLUTE)
		else return FALSE
	return TRUE

        // EdgeToString returns string version of Edge enum
/datum/flex/proc/StringToEdge(attrValue, list/result)
	switch (attrValue)
		if("left")			result = list(FLEX_EDGE_LEFT)
		if("top")			result = list(FLEX_EDGE_TOP)
		if("right")			result = list(FLEX_EDGE_RIGHT)
		if("bottom")			result = list(FLEX_EDGE_BOTTOM)
		if("start")			result = list(FLEX_EDGE_START)
		if("end")			result = list(FLEX_EDGE_END)
		if("horizontal")			result = list(FLEX_EDGE_HORIZONTAL)
		if("vertical")			result = list(FLEX_EDGE_VERTICAL)
		if("all")			result = list(FLEX_EDGE_ALL)
		else return FALSE
	return TRUE

/datum/flex/proc/ParseEdges(attrValue, list/result)
	result =list("","") // head and tail
	// margin --> ("margin", "")
	// margin-left --> ("margin", "left")
	// border-width --> ("border", "")
	// border-left-width -> ("border", "left")
	var/list/t = splittext(attrValue, "-")
	switch (t.len)
		if(1)
			result[0] = t[0]
		if(2,3) // 3 will be border-edge-width
			result[0] = t[0]
			result[1] = t[1]
			if (result[0] == "border" && result[1] == "width") result[1] = "";
		else return FALSE
	return TRUE

/datum/flex/proc/ParseStyleAttr(datum/flex_style/style, attribute, attrValue)

	var parsed = FALSE
	// FIX IN 515 - use pointers instead
	// Abuse a list so we can get a return value
	var/list/outVar
	switch(attribute)
		if("direction")
			parsed = StringToDirection(attrValue, outVar);
			if(parsed) style.Direction = outVar[0]
		if("flex-direction")
			parsed = StringToFlexDirection(attrValue, outVar);
			if(parsed) style.FlexDirection = outVar[0]
		if("justify-content")
			parsed = StringToJustify(attrValue, outVar);
			if(parsed) style.JustifyContent = outVar[0]
		if("align-content")
			parsed = StringToAlign(attrValue, outVar);
			if(parsed) style.AlignContent = outVar[0]
		if("align-items")
			parsed = StringToAlign(attrValue, outVar);
			if(parsed) style.AlignItems = outVar[0]
		if("align-self")
			parsed = StringToAlign(attrValue, outVar);
			if(parsed) style.AlignSelf = outVar[0]
		if("flex-wrap")
			parsed = StringToWrap(attrValue, outVar);
			if(parsed) style.FlexWrap = outVar[0]
		if("overflow")
			parsed = StringToOverflow(attrValue, outVar);
			if(parsed) style.Overflow = outVar[0]
		if("display")
			parsed = StringToDisplay(attrValue, outVar);
			if(parsed) style.Display = outVar[0]
		if("flex-grow")
			parsed = isnum(attrValue)
			if(parsed) style.FlexGrow = text2num(attrValue)
		if("flex-shrink")
			parsed = parsed = isnum(attrValue)
			if(parsed) style.FlexShrink = text2num(attrValue)
		if("flex-basis")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.FlexBasis = outVar[0]
		if("position")
			parsed = StringToPositionType(attrValue, outVar);
			if(parsed) style.PositionType = outVar[0]
		if("left")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.Position[FLEX_EDGE_LEFT] = outVar[0]
		if("top")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.Position[FLEX_EDGE_TOP] = outVar[0]
		if("right")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.Position[FLEX_EDGE_RIGHT] = outVar[0]
		if("bottom")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.Position[FLEX_EDGE_BOTTOM] = outVar[0]
		if("width")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.Dimensions[FLEX_DIMENSION_WIDTH] = outVar[0]
		if("height")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.Dimensions[FLEX_DIMENSION_HEIGHT] = outVar[0]
		if("min-width")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.MinDimensions[FLEX_DIMENSION_WIDTH] = outVar[0]
		if("min-height")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.MinDimensions[FLEX_DIMENSION_HEIGHT] = outVar[0]
		if("max-width")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.MaxDimensions[FLEX_DIMENSION_WIDTH] = outVar[0]
		if("max-height")
			parsed = ParseValueFromString(attrValue, outVar);
			if(parsed) style.MaxDimensions[FLEX_DIMENSION_HEIGHT] = outVar[0]
		if(
		  "margin" ,"margin-left" ,"margin-right" ,"margin-top" ,"margin-bottom",
		  "padding" ,"padding-left" ,"padding-right" ,"padding-top" ,"padding-bottom",
		  "border-width" ,"border-left-width" ,"border-right-width" ,"border-top-width" ,"border-bottom-width"
		 )
			// parse [margin|padding|border]-[Edgexxxx]
			var/list/HeadTail
			var/list/parsedEdge
			if (ParseEdges(attribute, HeadTail))

				if (HeadTail[1] == "") // no tail -- border-edge-width
					switch (HeadTail[0])
						if("margin")
							parsed = ParseFourValueFromString(attrValue, outVar)
							if(parsed) style.Margin = outVar[0]
						if("padding")
							parsed = ParseFourValueFromString(attrValue, outVar)
							if(parsed) style.Padding = outVar[0]
						if("border")
							parsed = ParseFourValueFromString(attrValue, outVar)
							if(parsed) style.Border = outVar[0]
						else parsed = FALSE
				else if (GLOB.flex.StringToEdge(HeadTail[1], parsedEdge))
					switch (HeadTail[0])
						if("margin")
							parsed = ParseValueFromString(attrValue, outVar)
							if(parsed) style.Margin[parsedEdge[0]] = outVar[0]
						if("padding")
							parsed = ParseValueFromString(attrValue, outVar)
							if(parsed) style.Padding[parsedEdge[0]] = outVar[0]
						if("border")
							parsed = ParseValueFromString(attrValue, outVar)
							if(parsed) style.Border[parsedEdge[0]] = outVar[0]

	return parsed
