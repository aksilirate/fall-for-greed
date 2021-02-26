extends Node

var save_file = SaveFile.new()
var minutes_passed = 0

signal time_updated(_minutes_passed)


func _ready():
	prepare_story_variants()
	
	
func update_time():
	save_file.save_value("Story", "minutes_passed",minutes_passed)
	emit_signal("time_updated", minutes_passed)
	
	
func prepare_story_variants():
	prepare_minutes_passed() 

func prepare_minutes_passed():
	if not save_file.get_saved_value("Story", "minutes_passed"):
		randomize()
		minutes_passed = int(rand_range(0,121))
		update_time()
	else:
		minutes_passed = save_file.get_saved_value("Story", "minutes_passed")
		emit_signal("time_updated", minutes_passed)

	

