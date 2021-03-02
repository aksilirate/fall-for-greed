extends LineEdit




func _on_ConsoleInput_text_changed(new_text):
	var game_screen = get_tree().get_root().get_node("GameScreen")
	match new_text:
		"change event to wolf":
			game_screen.get_node("Logic/Area").current_event = WolfEnemy.new()
			game_screen.get_node("Logic/Area").update_story_info()
			game_screen.get_node("Logic/Area").update_actions()
