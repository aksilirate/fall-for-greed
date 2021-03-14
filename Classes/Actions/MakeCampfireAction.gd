extends ActionLibrary
class_name MakeCampfireAction


const CLASS_NAME = "MakeCampfireAction"
const TEXTURE = "res://Textures/Actions/Make Campfire.png"
const TOOLTIP := "make a campfire"


func _ready():
	destroy_item_after_story()
	
	var emit_story_telling
	
	if area.current_event.get_class() != "CampfireEvent":
		emit_story_telling = emit_story_telling("you have started a campfire")
		change_event_to(CampfireEvent)
	else:
		emit_story_telling = emit_story_telling("you threw your sticks into the campfire")
	
	yield(emit_story_telling, "completed")
	queue_free()
