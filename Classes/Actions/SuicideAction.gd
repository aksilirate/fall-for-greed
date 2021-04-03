extends ActionLibrary
class_name SuicideAction


const TEXTURE = "res://Textures/Actions/Suicide.png"
const TOOLTIP := "suicide"


func _ready():
	

	
	var emit_story_telling =  emit_story_telling(executer.character_name + " have killed himself")
	yield(emit_story_telling, "completed")
	emit_signal("kill_character", executer)
	queue_free()

