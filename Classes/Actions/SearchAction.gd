extends ActionLibrary
class_name SearchAction

const TEXTURE = "res://Textures/Actions/Search.png"
const TOOLTIP := "search"


func _ready():
	var time_choice_scroll = get_tree().get_nodes_in_group("time_choice_scroll").front() as HScrollBar
	if time_choice_scroll:
		if not time_choice_scroll.visible:
			
			for _action_button in get_tree().get_nodes_in_group("action_button"):
				if _action_button != get_parent():
					_action_button.update_action(null, null, null)
					
			time_choice_scroll.max_value = 30
			time_choice_scroll.visible = true
			time_choice_scroll.active = true
			queue_free()
			
		else:
			
			randomize()
			var _minutes_passed = time_choice_scroll.value
			var _energy_cost = 0.008 * _minutes_passed

			var search_for_item = search_for_item(_minutes_passed)
			yield(search_for_item, "completed")
			time_choice_scroll.active = false
			queue_free()
