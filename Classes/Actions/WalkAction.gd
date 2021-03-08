extends ActionLibrary
class_name WalkAction

const TEXTURE = "res://Textures/Actions/Walk.png"
const TOOLTIP := "walk"


func _ready():
	randomize()
	var _minutes_passed = floor(rand_range(13,56))
	var _energy_cost = 0.005 * _minutes_passed
	var _main_story = "you have traveled for " + str(_minutes_passed) + " minutes"
	
	var emit_story_telling = emit_story_telling(_main_story)
	calculate_turn(_energy_cost, _minutes_passed)
	emit_location_advanced()
	
	yield(emit_story_telling, "completed")
	queue_free()



