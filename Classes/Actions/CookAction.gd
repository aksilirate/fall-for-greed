extends ActionLibrary
class_name CookAction


const TEXTURE = "res://Textures/Actions/Cook.png"
const TOOLTIP := "cook"


func _ready():
	var cook = cook()
	yield(cook, "completed")
	queue_free()
