extends ActionLibrary
class_name FightAction

const TEXTURE = "res://Textures/Actions/Fight.png"



func _ready():
	
	var start_battle = start_battle()
	
	yield(start_battle, "completed")
	queue_free()
	
