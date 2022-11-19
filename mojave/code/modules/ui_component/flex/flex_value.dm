/datum/flex_value
	var/value
	// FLEX_UNIT_ enum
	var/unit

/datum/flex_value/New(v, u)
	ASSERT(u in list(FLEX_UNIT_AUTO, FLEX_UNIT_PERCENT, FLEX_UNIT_POINT, FLEX_UNIT_UNDEFINED))
	value = v
	unit = u


/datum/flex_value/proc/operator~=(b)
	// If passing a flex_value, compare unit AND value
	if(istype(b, /datum/flex_value))
		var/datum/flex_value/comp = b
		if(unit != comp.unit) return FALSE
		if(unit == FLEX_UNIT_UNDEFINED) return TRUE

		// ignore unnoticable decimal value differences -- good for caching, and matching
		return abs(value - comp.value) < 0.0001 // 0 or essentially 0

	// If we have just passed a value (string, int, etc.) then just compare value
	return value == b
