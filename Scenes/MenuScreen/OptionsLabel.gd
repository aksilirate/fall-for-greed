extends ForgedLabel



func _on_OptionsLabel_mouse_entered():
	emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
	modulate.a = 0.5

func _on_OptionsLabel_mouse_exited():
	modulate.a = 1


func _on_OptionsLabel_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			emit_Sound_Effect("res://Sounds/Interface/Button.wav")
			var options_screen = preload("res://Scenes/OptionsScreen/OptionsScreen.tscn").instance()
			get_tree().get_root().add_child(options_screen)



