extends Control

onready var animation_player = get_node("AnimationPlayer")


func _ready():
	animation_player.play("Prologue")
