// Cached measurements for layouts - so we don't recalculate unecessarily
/datum/flex_cachedMeasurement
	var/availableWidth = 0
	var/availableHeight = 0
	var/widthMeasureMode = FLEX_MEASUREMODE_UNDEFINED
	var/heightMeasureMode = FLEX_MEASUREMODE_UNDEFINED
	var/computedWidth = -1
	var/computedHeight = -1


/datum/flex_cachedMeasurement/proc/ResetToDefault()
	availableWidth = 0
	availableHeight = 0
	widthMeasureMode = FLEX_MEASUREMODE_UNDEFINED
	heightMeasureMode = FLEX_MEASUREMODE_UNDEFINED
	computedWidth = -1
	computedHeight = -1

// Holder of the cached measurement
/datum/flex_measurementCache
	var/list/datum/flex_cachedMeasurement/cache

// Attempt to get cached value - extend list and generate if necessary
/datum/flex_measurementCache/proc/operator[](index)
	var/datum/flex_cachedMeasurement = LAZYACCESS(cache, index)
	if(flex_cachedMeasurement) return flex_cachedMeasurement
	LAZYMINLEN(cache, index)
	LAZYSET(cache, index, new)


/datum/flex_layout

	var/list/Position[4]
	var/list/Dimensions[2]
	var/list/Margin[6]
	var/list/Border[6]
	var/list/Padding[6]
	var/direction = FLEX_DIRECTION_INHERIT
	var/computedFlexBasisGeneration = 0
	var/computedFlexBasis = null
	var/HadOverflow = FALSE


	// Caching for early breaking
	var/generationCount
	var/lastParentDirection = FLEX_DIRECTION_NEVERUSED_1
	var/nextCachedMeasurementsIndex = 0
	var/datum/flex_measurementCache/measurementCache = new
	var/list/measuredDimensions[2]

	//Current cached layout
	var/datum/flex_cachedMeasurement/cachedLayout = new

/datum/flex_layout/proc/ResetToDefault()
	for(var/i = 1; i <= Position.len; i++)
		Position[i] = 0
	for(var/i = 1; i <= Dimensions.len; i++)
		Dimensions[i] = 0

	for(var/i in 0 to 5)
		Margin[i] = 0
		Border[i] = 0
		Padding[i] = 0

	direction = FLEX_DIRECTION_INHERIT
	computedFlexBasisGeneration = 0
	computedFlexBasis = null
	HadOverflow = FALSE
	generationCount = 0
	lastParentDirection = FLEX_DIRECTION_NEVERUSED_1
	nextCachedMeasurementsIndex = 0

	for(var/datum/flex_cachedMeasurement/mc in measurementCache.cache)
		mc.ResetToDefault()

	for(var/i = 1; i <= measuredDimensions.len; i++)
		measuredDimensions[i] = null

	cachedLayout = ResetToDefault()
