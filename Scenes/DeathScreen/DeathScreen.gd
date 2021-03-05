extends Control



func _init():
	visible = false

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/TitleScreen/TitleScreen.tscn")


func _ready():
	$AnimationPlayer.play("Play Death Message")
