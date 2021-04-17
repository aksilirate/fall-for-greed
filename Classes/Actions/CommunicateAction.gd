extends ActionLibrary
class_name CommunicateAction



const TEXTURE = "res://Textures/Actions/Communicate.png"
const TOOLTIP := "communicate"


func _ready():
	
	var _character = Game.current_event
	
	if Game.selected_tarot_card.get_script() == HermitCard.new().get_script():
		upcoming_stories.push_back(_character.NAME + " doesn't want to join you")
	else:
		upcoming_stories.push_back(_character.NAME + " have decided to join you")
		summon_character(_character.CHARACTER_OBJECT)
		
	var _main_story = "you have talked with " + _character.NAME
	var emit_story_telling = emit_story_telling(_main_story)
	
	
	reset_location()
	
	yield(emit_story_telling, "completed")
	queue_free()
