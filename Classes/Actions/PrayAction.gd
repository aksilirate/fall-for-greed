extends ActionLibrary
class_name PrayAction

const TEXTURE = "res://Textures/Actions/Pray.png"
const TOOLTIP := "pray"

func _ready():

	var _minutes_passed = 1
	var _energy_cost = 0.001
	var _main_story = str(executer.character_name) + " have prayed"
	
	var emit_story_telling = emit_story_telling(_main_story)
	calculate_turn(_energy_cost, _minutes_passed)
	
	yield(emit_story_telling, "completed")
	queue_free()
