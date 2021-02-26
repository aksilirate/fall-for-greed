extends ForgedLabel

onready var animation_player = get_node("../AnimationPlayer")



func _on_QuitLabel_mouse_entered():
	if not animation_player.is_playing():
		emit_Mouse_Entered_Effect()

func _on_QuitLabel_mouse_exited():
	modulate.a = 1


func _on_QuitLabel_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed and not animation_player.is_playing():
			get_tree().quit()
