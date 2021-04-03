class_name Math
















static func range_with_peak(max_index: float, index: float):
	var to_sqr =  ( (2/-max_index) * index) + 1 
	return (-1 * (to_sqr * to_sqr) )   +  1



static func create_map(width, height):
	var map = []

	for _x in range(width):
		var col = []
		col.resize(height)
		map.append(col)

	return map
