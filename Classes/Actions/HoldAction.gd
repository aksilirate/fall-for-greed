extends ActionLibrary
class_name HoldAction

const TEXTURE = "res://Textures/Actions/Hold.png"
const TOOLTIP := "hold"


func _ready():
	hold_selected_item()
	queue_free()
