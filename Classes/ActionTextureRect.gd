extends ForgedTextureRect
class_name ActionTextureRect


var action
var executer


func emit_action_pressed(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			if action and executer:
				action.executer = executer
				if get_child_count() < 2:
					add_child(action)
			else:
				print("No action or executer found.")




func update_action(_texture, _action, _executer):
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
