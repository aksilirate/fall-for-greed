extends ForgedTextureRect
class_name ActionTextureRect



var action
var executer

signal action_pressed

func emit_action_pressed(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			
			var area = get_tree().get_nodes_in_group("area").front()
			
			
			
			if Game.minutes_passed >= BalanceData.WITCH_SPAWN_MINUTE or Game.current_event is load("res://Areas/Mist/Mist.gd") as Script\
			and area.location_index == area.current_area.total_locations - 1:
				Game.minutes_passed = BalanceData.WITCH_SPAWN_MINUTE
				if Game.current_event.get("NAME"):
					if  Game.current_event.NAME != "the witch":
						action = SummonTheWitchAction
				else:
					action = SummonTheWitchAction




			if action and executer:
				var action_object = action.new()
				action_object.executer = executer
				if get_child_count() < 2:
					add_child(action_object)
			else:
				print("No action or executer found.")
				print("Action:" + str(action))
				print("Executer:" + str(executer))
				
			emit_signal("action_pressed")


func update_action(_texture, _action, _executer):
	var time_choice_slider = get_tree().get_nodes_in_group("time_choice_slider").front()
	time_choice_slider.active = false
	time_choice_slider.hide()
	
	if _action == null:
		visible = false
	else:
# warning-ignore:standalone_expression
		visible = true
		if _action.get("TOOLTIP"):
			hint_tooltip = _action.TOOLTIP
		else:
			hint_tooltip = ""
	get_child(0).texture = _texture
	
	executer = _executer
	action = _action

