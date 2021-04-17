extends LabelButton




func _ready():
	var directory = Directory.new();
	if not directory.file_exists(PathDictionary.SAVE_PATH):
		text = "no save file found"
		
		
func _on_DeleteSaveFileLabel_pressed():
	var title_screen = get_tree().get_nodes_in_group("title_screen").front()
	Save.delete()
	title_screen.get_node("PlayLabel").text = "New Game"
	text = "no save file found"


func _on_mouse_entered():
	var directory = Directory.new();
	if directory.file_exists(PathDictionary.SAVE_PATH):
		Audio.emit_sound_effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5
