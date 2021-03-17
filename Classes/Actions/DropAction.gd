extends ActionLibrary
class_name DropAction


const TEXTURE = "res://Textures/Actions/Drop.png"
const TOOLTIP := "drop"


func _ready():
	drop_selected_item()
	queue_free()
