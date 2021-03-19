extends ActionLibrary
class_name WalkAction

const TEXTURE = "res://Textures/Actions/Walk.png"
const TOOLTIP := "walk"


func _ready():
	
	var emit_location_advanced = emit_location_advanced()
	if emit_location_advanced is Object:
		yield(emit_location_advanced, "completed")
		queue_free()
	else:
		print("Walking error.")
		queue_free()



