extends ActionLibrary
class_name DigAction

const CLASS_NAME = "DigAction"
const TEXTURE := "res://Textures/Actions/Dig.png"
const TOOLTIP := "dig"


func _ready():
	var emit_story_telling
	
	emit_story_telling = emit_story_telling("you have dug up the grave")
	change_event_to(VoodooDollEvent)
	
	yield(emit_story_telling, "completed")
	queue_free()
