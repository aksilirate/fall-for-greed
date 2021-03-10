extends LabelButton







func _on_OptionsLabel_pressed():
	var options_screen = preload("res://Scenes/OptionsScreen/OptionsScreen.tscn").instance()
	get_tree().get_root().add_child(options_screen)
