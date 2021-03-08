extends ActionLibrary
class_name FightAction

const TEXTURE = "res://Textures/Actions/Fight.png"
const TOOLTIP := "fight"


func _ready():
	
	var start_battle = start_battle()
	
	yield(start_battle, "completed")
	queue_free()
	
