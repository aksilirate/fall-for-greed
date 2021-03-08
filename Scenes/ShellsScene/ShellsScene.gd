extends Control

export(NodePath) onready var shell_game = get_node(shell_game) as Node

var auto_lose = false
var enemy: Object

func _init():
	visible = false

func _ready():
	$InputBlocker.visible = true


func _on_battle_finished():
	auto_lose = false
	$InputBlocker.visible = true
	$ShellGame.animation_player.play("Load")
	yield($ShellGame.animation_player,"animation_finished")
	$ShellGame.start_cup_game()
