extends ForgedTextureRect
class_name ActionTextureRect



var action
var executer


func emit_action_pressed(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			if action and executer:
				action.executer = executer
				add_child(action)
			else:
				print("No action or executer found.")
			
			
			
			

func update_action(_texture, _action, _executer):
	if _action == null:
		visible = false
	else:
# warning-ignore:standalone_expression
		visible = true
	get_child(0).texture = _texture
	
	executer = _executer
	action = _action

