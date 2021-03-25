extends ActionLibrary
class_name WaitAction

const TEXTURE = "res://Textures/Actions/Wait.png"
const TOOLTIP := "wait"


func _ready():
	
	var time_choice_slider = get_tree().get_nodes_in_group("time_choice_slider").front()
	if time_choice_slider:
		if not time_choice_slider.visible:
			
			for _action_button in get_tree().get_nodes_in_group("action_button"):
				if _action_button != get_parent():
					_action_button.update_action(null, null, null)
					
					
			time_choice_slider.current_action = null
			time_choice_slider.max_value = 10
			time_choice_slider.current_action = "WaitAction"
			if time_choice_slider.slider_value_memory.has("WaitAction"):
				time_choice_slider.value = time_choice_slider.slider_value_memory["WaitAction"]


			time_choice_slider.visible = true
			time_choice_slider.active = true
			queue_free()
			
		else:
			randomize()
			var _minutes_passed = time_choice_slider.value
			var _energy_cost = 0
			var _main_story = "you have waited for " + str(_minutes_passed) + " minutes"
			refill_energy(_minutes_passed)
			var emit_story_telling = emit_story_telling(_main_story)
			calculate_turn(_energy_cost, _minutes_passed)

			yield(emit_story_telling, "completed")
			time_choice_slider.active = false
			time_choice_slider.hide()
			queue_free()
	
	

