extends ActionLibrary
class_name SleepAction

const TEXTURE = "res://Textures/Actions/Sleep.png"



func _ready():
	
	var sleep = sleep()
	
	yield(sleep, "completed")
	queue_free()
