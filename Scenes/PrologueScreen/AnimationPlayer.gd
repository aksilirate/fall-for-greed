extends AnimationPlayer


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/GameScreen/GameScreen.tscn")
