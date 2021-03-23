extends ActionLibrary
class_name CommunicateAction



const TEXTURE = "res://Textures/Actions/Communicate.png"



func _ready():
	var _character = area.current_event
	upcoming_stories.push_back(_character.NAME + " have decided to join you")
	var _main_story = "you have talked with " + _character.NAME
	
	var emit_story_telling = emit_story_telling(_main_story)
	
	summon_character(_character.CHARACTER_OBJECT)
	reset_location()
	
	yield(emit_story_telling, "completed")
	queue_free()
