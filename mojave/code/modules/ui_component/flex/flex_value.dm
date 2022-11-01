/datum/flex_value
	var/value
	// FLEX_UNIT_ enum
	var/unit

/datum/flex_value/New(v, u)
	ASSERT(u in list(FLEX_UNIT_AUTO, FLEX_UNIT_PERCENT, FLEX_UNIT_POINT, FLEX_UNIT_UNDEFINED))
	value = v
	unit = u

