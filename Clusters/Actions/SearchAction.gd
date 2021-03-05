extends ActionLibrary
class_name SearchAction

const TEXTURE = "res://Textures/Actions/Search.png"



func _ready():
	randomize()
	var _minutes_passed = floor(rand_range(9,21))
	var _energy_cost = 0.01 * _minutes_passed
	
	var search_for_item = search_for_item(_minutes_passed)
	
	yield(search_for_item, "completed")
	queue_free()
