extends LabelButton





func _on_NewMemoryLabel_pressed():
	Save.delete()
	Game.selected_tarot_card = null
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/GameScreen/GameScreen.tscn")
