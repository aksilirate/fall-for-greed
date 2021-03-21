extends ActionLibrary
class_name WalkAction

const TEXTURE = "res://Textures/Actions/Walk.png"
const TOOLTIP := "walk"

var emit_location_advanced
func _ready():
	connect("ready_to_advance", self, "_on_ready_to_advance")

	emit_location_advanced = emit_location_advanced()



func _on_ready_to_advance(_minutes_passed):
#	if emit_location_advanced is Object:
	var _formatted_minutes = Time.get_formatted_time("minute", _minutes_passed)
	var formatted_hours = Time.get_formatted_time("hour", _minutes_passed)
	var _energy_cost = 0.001 * _minutes_passed
	
	var _main_story: String
	if _minutes_passed < 60:
		 _main_story= "you have traveled for " + str(_minutes_passed) + " minutes"
	elif _minutes_passed == 60:
		_main_story= "you have traveled for 1 hour"
	elif not _formatted_minutes and _minutes_passed > 60:
		_main_story= "you have traveled for " + str(formatted_hours) + " hours"
	elif _formatted_minutes and _minutes_passed > 60:
		_main_story= "you have traveled for " + str(formatted_hours) + " hours and " + str(_formatted_minutes) + " minutes"
		
	calculate_turn(_energy_cost, _minutes_passed)
	var emit_story_telling = emit_story_telling(_main_story)
	yield(emit_story_telling, "completed")
	queue_free()
