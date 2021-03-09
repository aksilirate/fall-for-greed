extends ActionLibrary
class_name SleepAction

const TEXTURE = "res://Textures/Actions/Sleep.png"
const TOOLTIP := "sleep"


func _ready():
	
	var sleep = sleep()
	if sleep is Object:
		yield(sleep, "completed")
		queue_free()
	else:
		queue_free()
