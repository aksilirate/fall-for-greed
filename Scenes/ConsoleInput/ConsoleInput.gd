extends LineEdit

onready var game_screen = get_tree().get_root().get_node("GameScreen")

var path_dictionary = PathDictionary.new()

signal kill_character(_character)


func _ready():
# warning-ignore:return_value_discarded
	connect("kill_character", game_screen, "_on_character_death")

func _on_ConsoleInput_text_changed(new_text):
	
	
	if new_text.left(4) == "kill":
		var _character_name: String = new_text.lstrip("kill ")
		var _character = game_screen.get_node_or_null("Logic/Characters/" + _character_name)
		if _character != game_screen.get_node_or_null("Logic/Characters") and _character != null:
			emit_signal("kill_character", _character)
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
