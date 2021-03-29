extends ActionLibrary
class_name SearchAction

const TEXTURE = "res://Textures/Actions/Search.png"
const TOOLTIP := "search"


func _ready():
		var stamina_issue = stamina_issue()
		if not stamina_issue:
			var _minutes_passed = (randi() % 59) + 1
			var _energy_cost = 0.00096 * _minutes_passed
			var search_for_item = search_for_item(_minutes_passed)
			calculate_turn(_energy_cost, _minutes_passed)
			yield(search_for_item, "completed")
			queue_free()
		else:
			var _main_story = stamina_issue + " to search"
			var emit_story_telling = emit_story_telling(_main_story)
			yield(emit_story_telling, "completed")
			queue_free()
		randomize()

