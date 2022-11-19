// This is to handle static procs that would otherwise be in the correct class file

///// FLEX_VALUE /////
// Undefined value type
#define FLEX_VALUE_UNDEFINED new /datum/flex_value(null, FLEX_UNIT_UNDEFINED)
// Auto type
#define FLEX_VALUE_AUTO new /datum/flex_value(null, FLEX_UNIT_AUTO)
// undefined edge array - should match FLEX_EDGECOUNT (9)
#define FLEX_VALUE_DEFAULTEDGEVALUESUNIT list( FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, \
											   FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, \
											   FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED  )
