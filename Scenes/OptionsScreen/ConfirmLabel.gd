extends LabelButton







func _on_ConfirmLabel_pressed():
	var OptionsConfigFile = OptionsFile.new()
	OptionsConfigFile.save_Option("master_volume", AudioServer.get_bus_volume_db(0))
	get_parent().queue_free()
