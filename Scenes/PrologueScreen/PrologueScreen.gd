extends Control

onready var animation_player = get_node("AnimationPlayer")

func _init():
	visible = false

func _ready():
	animation_player.play("Prologue")
