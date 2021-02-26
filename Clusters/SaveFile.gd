extends Node
class_name SaveFile

var save = ConfigFile.new()


func save_value(_section: String, _key, _value):
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
	save.set_value(_section, _key, _value)
	save.save(PathDictionary.SAVE_PATH)
	
	
func get_saved_value(_section: String, _key):
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	if save.has_section_key(_section, _key):
		return save.get_value(_section, _key)
	else:
		return false

