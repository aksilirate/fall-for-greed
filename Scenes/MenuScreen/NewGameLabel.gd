extends LabelButton








func _on_NewGameLabel_pressed():
	Save.delete()
	Game.new_game_ready = true
	get_parent().get_parent().queue_free()
