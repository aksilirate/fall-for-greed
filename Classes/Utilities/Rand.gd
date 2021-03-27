class_name Rand





static func weighted_random_object(objects: Array):
	randomize()
	var total_weight = 0.0
	objects.shuffle()
	
	for object in objects:
		if object.get("RAND_WEIGHT"):
			total_weight += total_weight
		else:
			total_weight += 0.5


	for object in objects:
		if object.get("RAND_WEIGHT"):
			if rand_range(0, total_weight) < object.RAND_WEIGHT:
				return object
			
		else:
			if rand_range(0, total_weight) < 0.5:
				return object
				
				
				
static func weighted_random_dictionary(dictionary: Dictionary):
	randomize()
	var total_weight = 0.0
	
	for key in dictionary:
		total_weight += dictionary[key]


	for key in dictionary:
		if rand_range(0, total_weight) < dictionary[key]:
			return key
		else:
			total_weight -= dictionary[key]



