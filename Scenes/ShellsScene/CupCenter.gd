extends CupTextureRect


signal center_cup_selected(_cup)





func _on_CupCenter_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			get_material().set_shader_param("enabled", false)
			animation_player.playback_speed = 1.0
			emit_signal("center_cup_selected", "Center")
		



