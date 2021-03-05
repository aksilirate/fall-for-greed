extends Control



func _init():
	visible = false

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/TitleScreen/TitleScreen.tscn")


func _ready():
	$AnimationPlayer.play("Play Death Message")
