extends Node



func to_snake_case(_text: String):
	var _new_text = _text.replace(" ","_")
	_new_text = _new_text.to_lower()
	return _new_text
	
	
func save_value(_section: String, _key: String, _value):
	var save = ConfigFile.new()
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
	
	
	save.set_value(to_snake_case(_section), to_snake_case(_key), _value)
	save.save(PathDictionary.SAVE_PATH)
	
	
func get_saved_value(_section: String, _key):
	var save = ConfigFile.new()
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	if save.has_section_key(to_snake_case(_section), to_snake_case(_key)):
		return save.get_value(to_snake_case(_section), to_snake_case(_key))
	else:
		return false
		

func get_section_values(_section):
	var save = ConfigFile.new()
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	if save.has_section(to_snake_case(_section)):
		return save.get_section_keys(to_snake_case(_section))
	else:
		return null
	


		
func save_section(_section: String):
	var save = ConfigFile.new()
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	save.set_value(to_snake_case(_section))
	return save.save(PathDictionary.SAVE_PATH)
		
		
func erase_section(_section: String):
	var save = ConfigFile.new()
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
	
	save.erase_section(to_snake_case(_section))
	return save.save(PathDictionary.SAVE_PATH)
	



func erase_value(_section: String, _key: String):
	var save = ConfigFile.new()
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	save.erase_section_key(to_snake_case(_section), to_snake_case(_key))
	save.save(PathDictionary.SAVE_PATH)


func has_section(_section):
	var save = ConfigFile.new()
	var error = save.load(PathDictionary.SAVE_PATH)
	if error != OK:
		print(error)
		
	if save.has_section(to_snake_case(_section)):
		return true
	else:
		return false

func delete():
	var dir = Directory.new()
	return dir.remove(PathDictionary.SAVE_PATH)
