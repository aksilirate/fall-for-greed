class_name TakeAction

const TEXTURE = "res://Textures/Actions/Take.png"


func init_action(action_methods: ActionTextureRect) -> void:
	var _minutes_passed = 0
	var _energy_cost = 0.000001
	action_methods.reset_location()
	action_methods.emit_take_item()
