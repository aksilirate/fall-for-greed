extends Node


var minutes_passed = 0 setget set_minutes_passed
func set_minutes_passed(value):
	minutes_passed = value
	emit_signal("minutes_passed_updated")
	
var equipped_artifact: Object

signal minutes_passed_updated




func _ready():
# warning-ignore:return_value_discarded
	get_tree().connect("node_removed", self, "_on_node_removed")
	var world_environment = WorldEnvironment.new()
	world_environment.environment = preload("res://default_env.tres")
	add_child(world_environment)



var new_game_ready := false
func _on_node_removed(_node):
	if _node.name == "GameScreen" and new_game_ready:
# warning-ignore:return_value_discarded
		equipped_artifact = null
		get_tree().change_scene("res://Scenes/GameScreen/GameScreen.tscn")
		new_game_ready = false
