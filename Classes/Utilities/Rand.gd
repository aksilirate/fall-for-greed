class_name Rand





static func weighted_random_object(objects: Array):
	randomize()
	var total_weight = 0.0
	
	for object in objects:
		var object_instance = object.new()
		if "RAND_WEIGHT" in object_instance:
			total_weight += object_instance.RAND_WEIGHT
		else:
			total_weight += 0.5
			print("RAND_WEIGHT not found")
			
	for object in objects:
		var object_instance = object.new()
		if "RAND_WEIGHT" in object_instance:
			if rand_range(0, total_weight) < object_instance.RAND_WEIGHT:
				return object
			else:
				total_weight -= object_instance.RAND_WEIGHT
			
		else:
			if rand_range(0, total_weight) < 0.5:
				return object
			else:
				total_weight -= 0.5
				
				
				
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



