extends LabelButton








func _ready():
	var directory = Directory.new();
	if not directory.file_exists(PathDictionary.SAVE_PATH):
		text = "no save file found"
		
		
func _on_DeleteSaveFileLabel_pressed():
	var save_file = SaveFile.new()
	save_file.delete()
	text = "no save file found"


func _on_mouse_entered():
	var directory = Directory.new();
	if directory.file_exists(PathDictionary.SAVE_PATH):
		emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5
