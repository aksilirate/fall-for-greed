extends LabelButton





func _on_NewMemoryLabel_pressed():
	Save.delete()
	Game.new_game_ready = true
	get_parent().get_parent().queue_free()
