extends Node










func _ready():
	var world_environment = WorldEnvironment.new()
	world_environment.environment = preload("res://default_env.tres")
	add_child(world_environment)
