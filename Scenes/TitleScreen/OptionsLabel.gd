extends ForgedLabel

onready var animation_player = get_node("../AnimationPlayer")



func _on_OptionsLabel_mouse_entered():
	if not animation_player.is_playing():
		emit_Mouse_Entered_Effect()
	
func _on_OptionsLabel_mouse_exited():
	modulate.a = 1





func _on_OptionsLabel_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed and not animation_player.is_playing():
			emit_Sound_Effect("res://Sounds/Interface/Button.wav")
# warning-ignore:return_value_discarded
			var options_screen = preload("res://Scenes/OptionsScreen/OptionsScreen.tscn").instance()
			get_tree().get_root().add_child(options_screen)
