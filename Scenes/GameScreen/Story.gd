extends Node



var save_file = SaveFile.new()
var current_artifact: Object setget set_current_artifact
var artifacts = [
	FallenKingsChaliceCup,
	PrisonersMask
]

var minutes_passed = 0

signal time_updated(_minutes_passed)


func set_current_artifact(_value):
	current_artifact = _value
	save_file.save_value("Game", "current_artifact",current_artifact)

func _ready():
	prepare_story_variants()
	
	
func update_time():
	save_file.save_value("Game", "minutes_passed",minutes_passed)
	emit_signal("time_updated", minutes_passed)

	
	
func prepare_story_variants():
	if not save_file.get_saved_value("Game", "current_artifact"):
		current_artifact = null
	else:
		current_artifact = save_file.get_saved_value("Game", "current_artifact")
	prepare_minutes_passed() 

func prepare_minutes_passed():
	if not save_file.get_saved_value("Game", "minutes_passed"):
		randomize()
		minutes_passed = int(rand_range(0,121))
		update_time()
	else:
		minutes_passed = save_file.get_saved_value("Game", "minutes_passed")
		emit_signal("time_updated", minutes_passed)

	

