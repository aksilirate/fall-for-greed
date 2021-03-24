extends ActionLibrary
class_name SearchAction

const TEXTURE = "res://Textures/Actions/Search.png"
const TOOLTIP := "search"


func _ready():
	var time_choice_slider = get_tree().get_nodes_in_group("time_choice_slider").front()
	if time_choice_slider:
		if not time_choice_slider.visible:
			
			for _action_button in get_tree().get_nodes_in_group("action_button"):
				if _action_button != get_parent():
					_action_button.update_action(null, null, null)
					
			time_choice_slider.max_value = 60
			time_choice_slider.visible = true
			time_choice_slider.active = true
			queue_free()
			
		else:
			var action_execution_issues = action_execution_issues()
			if action_execution_issues is bool and action_execution_issues == true:
				var _minutes_passed = time_choice_slider.value
				var _energy_cost = 0.00096 * _minutes_passed
				var search_for_item = search_for_item(_minutes_passed)
				calculate_turn(_energy_cost, _minutes_passed)
				yield(search_for_item, "completed")
				time_choice_slider.active = false
				queue_free()
			else:
				var _main_story = action_execution_issues + " to search"
				var emit_story_telling = emit_story_telling(_main_story)
				yield(emit_story_telling, "completed")
				queue_free()
			randomize()

