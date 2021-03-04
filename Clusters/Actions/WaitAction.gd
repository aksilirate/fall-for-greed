class_name WaitAction

const TEXTURE = "res://Textures/Actions/Wait.png"



func init_action(action_methods: ActionTextureRect) -> void:
	randomize()
	
	var _minutes_passed = floor(rand_range(3,7))
	var _energy_cost = 0
	var _main_story = "you have waited for " + str(_minutes_passed) + " minutes"
	
	action_methods.emit_story_telling(_main_story)
	action_methods.calculate_turn(_energy_cost, _minutes_passed)

