extends LabelButton








func _on_NewGameLabel_pressed():
	var save_file = SaveFile.new()
	save_file.delete()
	Game.new_game_ready = true
	get_parent().get_parent().queue_free()
