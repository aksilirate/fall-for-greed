extends ActionLibrary
class_name WaitAction

const TEXTURE = "res://Textures/Actions/Wait.png"
const TOOLTIP := "wait"


func _ready():
	randomize()
	
	var _minutes_passed = floor(rand_range(3,7))
	var _energy_cost = 0
	var _main_story = "you have waited for " + str(_minutes_passed) + " minutes"
	
	var emit_story_telling = emit_story_telling(_main_story)
	calculate_turn(_energy_cost, _minutes_passed)
	
	yield(emit_story_telling, "completed")
	queue_free()
	
	

