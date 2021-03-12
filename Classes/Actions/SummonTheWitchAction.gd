extends ActionLibrary
class_name SummonTheWitchAction






func _ready():
	
	upcoming_stories.push_back("it's the same feeling you felt a long time ago")
	upcoming_stories.push_back("it whispers...")
	
	var emit_story_telling =  emit_story_telling("you feel a presence beside you...")
	change_event_to(Witch)
	yield(emit_story_telling, "completed")
	queue_free()

