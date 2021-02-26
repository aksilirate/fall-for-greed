class_name PrayAction

const TEXTURE = "res://Textures/Action Icons/Pray.png"


func init_action(action_methods: ActionTextureRect) -> void:

	var _minutes_passed = 1
	var _energy_cost = 1
	var _main_story = str(action_methods.executer.NAME) + " have prayed"
	
	action_methods.emit_story_telling(_main_story)
	action_methods.calculate_turn(_energy_cost, _minutes_passed)
