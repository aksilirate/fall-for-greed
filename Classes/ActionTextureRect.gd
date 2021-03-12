extends ForgedTextureRect
class_name ActionTextureRect


var action
var executer


func emit_action_pressed(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			
			var story = get_tree().get_nodes_in_group("story").front()
			var area = get_tree().get_nodes_in_group("area").front()
			
			if story.minutes_passed >= 144000 and area.current_event.get("NAME"):
				if area.current_event.NAME != "the witch":
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



func update_action(_texture, _action, _executer):
	var time_choice_scroll = get_tree().get_nodes_in_group("time_choice_scroll").front()
	time_choice_scroll.active = false
	time_choice_scroll.hide()
	
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

