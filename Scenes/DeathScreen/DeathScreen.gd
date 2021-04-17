extends Control



func _init():
	visible = false



func _ready():
	$AnimationPlayer.play("Play Death Message")
