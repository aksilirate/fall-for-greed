extends ForgedLabel




func _on_QuitLabel_mouse_entered():
	emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
	modulate.a = 0.5


func _on_QuitLabel_mouse_exited():
	modulate.a = 1


func _on_QuitLabel_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			get_tree().quit()
