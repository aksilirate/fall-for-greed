extends ActionLibrary
class_name HangAction

const TEXTURE = "res://Textures/Actions/Hang.png"
const TOOLTIP := "hang yourself"


func _ready():
	var emit_story_telling = emit_story_telling(executer.character_name + " has hang himself and died")
	yield(self,"story_telling_finished")
	emit_signal("kill_character", executer)
	yield(emit_story_telling, "completed")
	queue_free()



