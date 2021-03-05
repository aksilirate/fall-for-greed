class_name WalkAction

const TEXTURE = "res://Textures/Actions/Walk.png"



func init_action(action_methods: ActionTextureRect) -> void:
	randomize()
	var _minutes_passed = floor(rand_range(13,56))
	var _energy_cost = 0.005 * _minutes_passed
	var _main_story = "you have traveled for " + str(_minutes_passed) + " minutes"
	
	action_methods.emit_story_telling(_main_story)
	action_methods.calculate_turn(_energy_cost, _minutes_passed)
	action_methods.emit_location_advanced()


