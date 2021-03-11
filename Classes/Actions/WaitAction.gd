extends ActionLibrary
class_name WaitAction

const TEXTURE = "res://Textures/Actions/Wait.png"
const TOOLTIP := "wait"


func _ready():
	var time_choice_scroll = get_tree().get_nodes_in_group("time_choice_scroll").front()
	if time_choice_scroll:
		if not time_choice_scroll.visible:
			
			for _action_button in get_tree().get_nodes_in_group("action_button"):
				if _action_button != get_parent():
					_action_button.update_action(null, null, null)
					
			time_choice_scroll.max_value = 10
			time_choice_scroll.visible = true
			time_choice_scroll.active = true
			queue_free()
		else:
			randomize()
			var _minutes_passed = time_choice_scroll.value
			var _energy_cost = 0
			var _main_story = "you have waited for " + str(_minutes_passed) + " minutes"

			var emit_story_telling = emit_story_telling(_main_story)
			calculate_turn(_energy_cost, _minutes_passed)

			yield(emit_story_telling, "completed")
			time_choice_scroll.active = true
			time_choice_scroll.hide()
			queue_free()
	
	

