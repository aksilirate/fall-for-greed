extends ActionLibrary
class_name ChangeDirectionAction



const TEXTURE = "res://Textures/Actions/Change Direction.png"
const TOOLTIP := "change direction"


func _ready():
	randomize()
	area.upcoming_locations.shuffle()
	area.update_actions()
	area.save_game()
	var emit_story_telling = emit_story_telling("you will travel to a different direction from now on")
	yield(emit_story_telling, "completed")
	queue_free()
