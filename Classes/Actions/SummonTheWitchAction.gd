extends ActionLibrary
class_name SummonTheWitchAction


const TEXTURE = "res://Textures/Actions/Summon Witch.png"
const TOOLTIP := "summon the witch"


func _ready():
	
	upcoming_stories.push_back("it's the same feeling you felt a long time ago")
	upcoming_stories.push_back("it whispers...")
	
	var emit_story_telling =  emit_story_telling("you feel a presence beside you...")
	change_event_to(Witch)
	yield(emit_story_telling, "completed")
	queue_free()

