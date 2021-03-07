extends ActionLibrary
class_name EatAction

const TEXTURE = "res://Textures/Actions/Eat.png"



func _ready():
	var _character = game_screen.last_selected_character
	var _selected_item = game_screen.selected.item
	
	var _minutes_passed = 1
	var _energy_cost = 0
	
	var _main_story = _character.character_name + " have eaten " + _selected_item.NAME
	

	eat()
	destroy_item_after_story()
	
	var emit_story_telling = emit_story_telling(_main_story)
	calculate_turn(_energy_cost, _minutes_passed)
	emit_location_advanced()
	
	yield(emit_story_telling, "completed")
	queue_free()
