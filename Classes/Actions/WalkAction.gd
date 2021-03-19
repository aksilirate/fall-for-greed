extends ActionLibrary
class_name WalkAction

const TEXTURE = "res://Textures/Actions/Walk.png"
const TOOLTIP := "walk"


func _ready():
	
	var emit_location_advanced = emit_location_advanced()
	yield(emit_location_advanced, "completed")
	queue_free()



