extends ActionLibrary
class_name EnterAction


const TEXTURE = "res://Textures/Actions/Enter.png"
const TOOLTIP := "enter"




func _ready():
	var change_area = change_area()
	yield(change_area, "completed")
	queue_free()
