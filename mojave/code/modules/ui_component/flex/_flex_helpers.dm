// This is to handle static procs that would otherwise be in the correct class file

///// FLEX_VALUE /////
// Undefined value type
#define FLEX_VALUE_UNDEFINED new /datum/flex_value(null, FLEX_UNIT_UNDEFINED)
// Auto type
#define FLEX_VALUE_AUTO new /datum/flex_value(null, FLEX_UNIT_AUTO)
// Zero value
#define FLEX_VALUE_ZERO new /datum/flex_value(0, FLEX_UNIT_POINT)

// undefined edge array - should match FLEX_EDGECOUNT (9)
#define FLEX_VALUE_DEFAULTEDGEVALUESUNIT list( FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, \
											   FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, \
											   FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED, FLEX_VALUE_UNDEFINED  )

#define FLEX_FLEXDIRECTION_IS_ROW(direction) (direction == FLEX_FLEXDIRECTION_ROW || direction == FLEX_FLEXDIRECTION_ROWREVERSE)
#define FLEX_FLEXDIRECTION_IS_COLUMN(direction) (direction == FLEX_FLEXDIRECTION_COLUMN || direction == FLEX_FLEXDIRECTION_COLUMNREVERSE)


#define FLEX_EDGE_ISVERT(edge) (edge == FLEX_EDGE_TOP || edge == FLEX_EDGE_BOTTOM)
#define FLEX_EDGE_ISHORZ(edge) (edge == FLEX_EDGE_LEFT || edge == FLEX_EDGE_RIGHT || edge == FLEX_EDGE_START || edge == FLEX_EDGE_END)

// datum/flex_value, number -- returns number based on value
#define FLEX_RESOLVE_VALUE(val, parentSize) \
		val.unit == FLEX_UNIT_AUTO ? null : \
		val.unit == FLEX_UNIT_UNDEFINED ? null : \
		val.unit == FLEX_UNIT_POINT ? val.value : \
		val.unit == FLEX_UNIT_PERCENT ? (val.value * parentSize / 100) : \
		null // should never happen

// datum/flex_value, number -- returns margin value, defaults AUTO to 0
#define FLEX_RESOLVE_VALUE_MARGIN(val, parentSize) val.unit == FLEX_UNIT_AUTO ? 0 : FLEX_RESOLVE_VALUE(val, parentSize)

// Get the leading and trailing edge for a given flex direction's margin
// i.e Leading margin for a column is TOP, and trailing margin for a column is BOTTOM
// leading is boolean, flex direction is FLEX_DIRECTION_...
#define FLEX_GET_MARGIN_EDGE(leading, flex_direction) \
	(leading  ? list(FLEX_EDGE_TOP, FLEX_EDGE_BOTTOM, FLEX_EDGE_LEFT, FLEX_EDGE_RIGHT)\
	: list(FLEX_EDGE_BOTTOM, FLEX_EDGE_TOP, FLEX_EDGE_RIGHT, FLEX_EDGE_LEFT))[flex_direction]

// edges = list/flex_value, edge = FLEX_EDGE, deafultValue = flex_value
#define FLEX_COMPUTE_EDGE_VALUE(edges, edge, defaultValue) \
	edges[edge].unit != FLEX_UNIT_UNDEFINED ? edges[edge] : \
	FLEX_EDGE_ISVERT(edge) && edges[FLEX_EDGE_VERTICAL].unit != FLEX_UNIT_UNDEFINED ? edges[FLEX_EDGE_VERTICAL] : \
	FLEX_EDGE_ISHORZ(edge) && edges[FLEX_EDGE_HORIZONTAL].unit != FLEX_UNIT_UNDEFINED ? edges[FLEX_EDGE_HORIZONTAL] : \
	edges[FLEX_EDGE_ALL].unit != FLEX_UNIT_UNDEFINED ? edges[FLEX_EDGE_ALL] : \
	edge == FLEX_EDGE_START || edge == FLEX_EDGE_END ? FLEX_VALUE_UNDEFINED : \
	defaultValue
