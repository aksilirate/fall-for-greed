extends ActionLibrary
class_name WalkAction

const TEXTURE = "res://Textures/Actions/Walk.png"
const TOOLTIP := "walk"

func _ready():
# warning-ignore:return_value_discarded
	connect("ready_to_advance", self, "_on_ready_to_advance")
	
	var action_execution_issues = action_execution_issues()
	if action_execution_issues is bool and action_execution_issues == true:
		emit_location_advanced()
	else:
		var _main_story = action_execution_issues + " to walk"
		var emit_story_telling = emit_story_telling(_main_story)
		yield(emit_story_telling, "completed")
		queue_free()

func _on_ready_to_advance(_minutes_passed):
	var _formatted_minutes = Time.get_formatted_time("minute", _minutes_passed)
	var formatted_hours = Time.get_formatted_time("hour", _minutes_passed)
	var _energy_cost = 0.00084 * _minutes_passed
	
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
