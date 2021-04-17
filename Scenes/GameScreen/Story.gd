extends Node

var minutes_passed = 0 setget set_minutes_passed

var tarot_prophecy_ready := false

signal time_updated(_minutes_passed)



func set_minutes_passed(_value):
	if Time.get_formatted_time("day", _value) > Time.get_formatted_time("day", minutes_passed):
		tarot_prophecy_ready = true
	minutes_passed = _value
	
	


func _ready():
	prepare_story_variants()
	
	
func update_time():
	Save.save_value("Game", "minutes_passed",minutes_passed)
	emit_signal("time_updated", minutes_passed)

	
	
func prepare_story_variants():
	if not Save.get_saved_value("Game", "equipped_artifact"):
		Game.equipped_artifact = null
	else:
		Game.equipped_artifact = Save.get_saved_value("Game", "equipped_artifact")
	prepare_minutes_passed() 

func prepare_minutes_passed():
	if not Save.get_saved_value("Game", "minutes_passed"):
		randomize()
		minutes_passed = int(rand_range(0,121))
		update_time()
	else:
		minutes_passed = Save.get_saved_value("Game", "minutes_passed")
		emit_signal("time_updated", minutes_passed)

	

