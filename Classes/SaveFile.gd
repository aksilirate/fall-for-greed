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
		
func save_section(_section: String):
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	save.set_value(_section)
	save.save(PathDictionary.SAVE_PATH)
		
		
func erase_section(_section: String):
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
	
	save.erase_section(_section)
	return save.save(PathDictionary.SAVE_PATH)
	
func has_section(_section):
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	if save.has_section(_section):
		return true
	else:
		return false


func get_saved_characters():
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	var _section_cache = Array(save.get_sections())
	_section_cache.erase("Game")
	
	return _section_cache

func delete():
	var dir = Directory.new()
	dir.remove(PathDictionary.SAVE_PATH)
