extends CupTextureRect


signal left_cup_selected(_cup)



func _on_CupLeft_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed and not animation_player.is_playing():
			get_material().set_shader_param("enabled", false)
			animation_player.playback_speed = 1.0
			emit_signal("left_cup_selected", "Left")



