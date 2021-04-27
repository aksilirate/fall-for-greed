extends LabelButton








func _on_NewGameLabel_pressed():
	Save.delete()
	Game.new_game_ready = true
	Game.selected_tarot_card = null
	get_parent().get_parent().queue_free()
