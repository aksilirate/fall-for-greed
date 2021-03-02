extends Control


func _init():
	visible = false

func _ready():
	$InputBlocker.visible = true


func _on_battle_finished():
	$InputBlocker.visible = true
	$ShellGame.animation_player.play("Load")
	yield($ShellGame.animation_player,"animation_finished")
	$ShellGame.start_cup_game()
