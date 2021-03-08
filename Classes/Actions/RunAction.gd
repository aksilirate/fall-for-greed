extends ActionLibrary
class_name RunAction


const TEXTURE = "res://Textures/Actions/Run.png"
const TOOLTIP := "run"



func _ready():
	run() # <--------- has queue_free()
