extends ActionTextureRect



func _on_EastAction_mouse_entered():
	if not owner.animation_player.is_playing():
		emit_Mouse_Entered_Effect()

func _on_EastAction_mouse_exited():
	deselect()


func _on_character_update_action(_texture, _action, _executer):
	update_action(_texture, _action, _executer)


func _on_update_east_action(_texture, _action, _executer):
	update_action(_texture, _action, _executer)


func _on_EastAction_gui_input(event):
	emit_action_pressed(event)
