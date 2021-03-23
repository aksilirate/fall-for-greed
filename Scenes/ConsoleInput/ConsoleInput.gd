extends LineEdit

onready var game_screen = get_tree().get_root().get_node("GameScreen")
onready var characters = get_tree().get_root().get_node("GameScreen/Logic/Characters")

var path_dictionary = PathDictionary.new()

signal kill_character(_character)
signal summon_character(_character)

func _ready():
# warning-ignore:return_value_discarded
	connect("kill_character", game_screen, "_on_character_death")
# warning-ignore:return_value_discarded
	connect("summon_character", characters, "summon_character")

func _on_ConsoleInput_text_changed(new_text):


	if new_text.left(10) == "add effect":
		if game_screen.last_selected_character:
			var _effect_name: String = new_text.lstrip("add effect ")
			_effect_name = _effect_name.capitalize()
			var _character = game_screen.last_selected_character
			match _effect_name:
				"Nausea":
					_character.add_effect(Nausea.new())
					text = ""
				"Poison":
					_character.add_effect(Poison.new())
					text = ""



	elif new_text.left(4) == "kill":
		var _character_name: String = new_text.lstrip("kill ")
		_character_name = _character_name.capitalize()
		var _character = game_screen.get_node_or_null("Logic/Characters/" + _character_name)
		if _character != game_screen.get_node_or_null("Logic/Characters") and _character != null:
			emit_signal("kill_character", _character)
			text = ""



	elif new_text.left(6) == "summon":
		var _character_name: String = new_text.lstrip("summon ")
		_character_name = _character_name.capitalize()
		var _character = characters.character_object_from_name(_character_name)
		if _character:
			emit_signal("summon_character", _character)
			text = ""



	elif new_text.left(15) == "change event to":
		var _event_name: String = new_text.lstrip("change event to ")
		_event_name = _event_name.to_upper()
		_event_name = _event_name.replace(" ", "_")
		var _event = path_dictionary.get(_event_name)
		if _event != null:
			game_screen.get_node("Logic/Area").current_event = load(_event).new()
			game_screen.get_node("Logic/Area").update_story_info()
			game_screen.get_node("Logic/Area").update_actions()
			text = ""
