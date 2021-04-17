extends Node


var minutes_passed = 0 setget set_minutes_passed

var current_area: Object
var current_event: Object
var upcoming_locations: Array
var location_index: int
var findings_left: int

var selected_tarot_card: Object
var equipped_artifact: Object

var held_item: Object


signal minutes_passed_updated



func _ready():
# warning-ignore:return_value_discarded
	get_tree().connect("node_removed", self, "_on_node_removed")
	var world_environment = WorldEnvironment.new()
	world_environment.environment = preload("res://default_env.tres")
	add_child(world_environment)


func set_minutes_passed(value):
	minutes_passed = value
	emit_signal("minutes_passed_updated")
	
	
var new_game_ready := false
func _on_node_removed(_node):
	if _node.name == "GameScreen" and new_game_ready:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/GameScreen/GameScreen.tscn")
		new_game_ready = false




# total_locations are generated inside the current_location
func generate_locations():
	# Generates NPCs, enemies and zones
	upcoming_locations.clear()
	location_index = 0
	randomize()
	
	var spawned_enemies = []
	var spawned_zones = []
	var npc_cache = [] + current_area.NPCS
	
	var _last_location: Object
	for _index in current_area.total_locations:
		if _index > 3 and _last_location == current_area:
			
			var _enemy = Rand.weighted_random_object(current_area.ENEMIES)
			var _zone = Rand.weighted_random_object(current_area.ZONES)
			
			if current_area.ENEMIES.size() > 0 and spawned_enemies.size() <= current_area.ENEMIES.size() and spawned_enemies.find(_enemy) == -1:
				_last_location = _enemy.new()
				upcoming_locations.push_front(_enemy.new())
				spawned_enemies.push_front(_enemy)
				
			
			elif current_area.ZONES.size() > 0 and spawned_zones.size() <= current_area.ZONES.size() and spawned_zones.find(_zone) == -1:
				_last_location = _zone.new()
				upcoming_locations.push_front(_zone.new())
				spawned_zones.push_front(_zone)
				
				
			elif rand_range(0,1) < 0.3 and npc_cache.size() > 0:
				_last_location = npc_cache.front()
				upcoming_locations.push_front(npc_cache.pop_front().new())
				
				
			else:
				upcoming_locations.push_front(current_area)
				_last_location = current_area
		else:
			upcoming_locations.push_front(current_area)
			_last_location = current_area
			
	if current_area.get("LAST_EVENT"):
		upcoming_locations[upcoming_locations.size() - 1] = current_area.LAST_EVENT
				
				
				
func reset_location():
	if Game.current_area.get_script() != Game.current_event.get_script():
		Game.current_event = Game.current_area
	Events.emit_signal("location_reset")
