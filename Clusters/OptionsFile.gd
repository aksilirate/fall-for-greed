extends Node

var path = "user://Options.cfg"
var config = ConfigFile.new()
var load_response = config.load(path)


func save_Option(_key: String, _value):
	config.set_value("Options",_key, _value)
	config.save(path)
	
func get_Option(_key: String):
	if config.has_section_key("Options", _key):
		return config.get_value("Options", _key)
	else:
		return null


func assign_Default_Options():
	if get_Option("fullscreen") == null:
		save_Option("fullscreen", false)
	if get_Option("prologue") == null:
		save_Option("prologue", true)
		
		
func apply_Options():
	OS.window_fullscreen = get_Option("fullscreen")
