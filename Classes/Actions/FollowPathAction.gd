extends ActionLibrary
class_name FollowPathAction


const TEXTURE = "res://Textures/Actions/Follow Path.png"
const TOOLTIP := "follow path"




func _ready():
	var follow_path = follow_path()
	yield(follow_path, "completed")
	queue_free()
