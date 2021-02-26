class_name SearchAction

const TEXTURE = "res://Textures/Action Icons/Search.png"

func init_action(action_methods: ActionTextureRect) -> void:
	randomize()
	var _minutes_passed = floor(rand_range(9,21))
	var _energy_cost = 0.01 * _minutes_passed
	var _main_story: String
	if round(rand_range(0,1)) == 1:
		_main_story = "you have searched for " + str(_minutes_passed) + " minutes"
		action_methods.upcoming_stories.append("you have not found anything")
		action_methods.reset_location()
		action_methods.emit_story_telling(_main_story)
	else:
		action_methods.emit_search_for_item(_minutes_passed)

