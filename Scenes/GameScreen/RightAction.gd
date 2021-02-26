extends ActionTextureRect



func _on_RightAction_mouse_entered():
	if not animation_player.is_playing():
		emit_Mouse_Entered_Effect()


func _on_RightAction_mouse_exited():
	deselect()


func _on_update_right_action(_texture, _action, _executer):
	update_action(_texture, _action, _executer)


func _on_character_update_action(_texture, _action, _executer):
	update_action(_texture, _action, _executer)


func _on_RightAction_gui_input(event):
	emit_action_pressed(event)
