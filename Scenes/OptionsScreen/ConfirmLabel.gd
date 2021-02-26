extends ForgedLabel


func _on_ConfirmLabel_mouse_entered():
	emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
	modulate.a = 0.5


func _on_ConfirmLabel_mouse_exited():
	modulate.a = 1

func _on_ConfirmLabel_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			emit_Sound_Effect("res://Sounds/Interface/Button.wav")
			get_parent().queue_free()
