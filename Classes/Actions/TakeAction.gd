extends ActionLibrary
class_name TakeAction

const TEXTURE = "res://Textures/Actions/Take.png"


func _ready():
	var _minutes_passed = 0
	var _energy_cost = 0.000001
	
	reset_location()
	emit_take_item()
	
	queue_free()
