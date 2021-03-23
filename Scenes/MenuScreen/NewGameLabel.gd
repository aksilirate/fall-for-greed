extends LabelButton








func _on_NewGameLabel_pressed():
	# Finish later
	var save_file = SaveFile.new()
	save_file.delete()
	
