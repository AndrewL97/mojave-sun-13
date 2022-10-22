// // // tables and such

// /obj/ui_component/element/table
// 	var/list/obj/ui_component/element/cell/cells = list()

// /proc/New(Tag, Menu/P, X, Y, Row, Col, list/Widths, list/Heights)

// // cell size will be height / rows by width / cols
// /obj/ui_component/element/table/New(name, obj/ui_component/parent_container, iconFile, iconState, rows, cols, height, width)

// 	for(var/row = 1 to rows)
// 		for(var/col = 1 to cols)
// 			var/obj/ui_component/element/cell/tempCell = new/ui_component/element/cell("[row],[col]", src, iconFile, iconState, height/rows, width/cols, row, col)
// 			cells[tempCell.component_name] = tempCell


// /obj/ui_component/element/table/refreshPos(updateChildren)
// 	. = ..()
// 	for(var/cell in cells)
// 		var/obj/ui_component/element/cell/tempCell = cells[cell]
// 		tempCell.screen_x =

// /obj/ui_component/element/cell
// 	cellX
// 	cellY

// /obj/ui_component/element/cell/New(name, obj/ui_component/parent_container, iconFile, iconState, width, height, cellX, cellY)
// 	. = ..()


// /obj/ui_component/element/cell/refreshPos(updateChildren)
// 	// TODO - Handle non stretched components
// 	transform = matrix().Scale(screen_width/32, screen_height/32)

// 	var/newX = 0
// 	var/newY = 0

// 	screen_x = newX
// 	screen_y = newY

// 	pixel_x = newX
// 	pixel_y = newY

// 	// world << "Moving: [component_name]: [newX]x[newY] - [parent.screen_width]x[parent.screen_height] -- [screen_width],[screen_height]"
// 	if(updateChildren)
// 		// world << "updating [children.len] children of: [component_name]"
// 		for(var/obj/ui_component/child in children)
// 			children[child].refreshPos(updateChildren)
