class_name SearchAction

const TEXTURE = "res://Textures/Actions/Search.png"

func init_action(action_methods: ActionTextureRect) -> void:
	randomize()
	var _minutes_passed = floor(rand_range(9,21))
	var _energy_cost = 0.01 * _minutes_passed
	action_methods.search_for_item(_minutes_passed)

