extends Node


var equipped_artifact: Object





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
