extends Node

onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")
onready var executer = owner.get_node("Logic/Characters").get_children()
onready var history_label = owner.get_node("HistoryLabel")
onready var story_texture = owner.get_node("StoryTexture")
onready var story_frame = owner.get_node("StoryFrame")

var save_file = SaveFile.new()
var upcoming_locations: Array
var locations_passed: int
var current_area: Object
var current_event: Object

signal update_west_action(_texture, _action, _executer)
signal update_left_action(_texture, _action, _executer)
signal update_right_action(_texture, _action, _executer)
signal update_east_action(_texture, _action, _executer)

# total_locations are generated inside the current_location

func generate_locations():
	# Generates NPCs and enemies
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var enemy_cache = [] + current_area.ENEMIES
	var npc_cache = [] + current_area.NPCS
	for _index in current_area.total_locations:
		if _index < 6:
			upcoming_locations.insert(_index, current_area)
		else:
			var _penultimate = upcoming_locations.size() - 1
			if rand.randi_range(0,10) == 3 and upcoming_locations[_penultimate] == current_area:
				var _enemy_index = rand.randi_range(0, enemy_cache.size() - 1)
				upcoming_locations.insert(_index,enemy_cache[_enemy_index].new())
				enemy_cache.remove(_enemy_index)
			elif rand.randi_range(0,10) == 3 and npc_cache.size() > 0 and upcoming_locations[_penultimate] == current_area:
				var _save_file = SaveFile.new()
				if not _save_file.has_section(npc_cache.front().new().NAME):
					upcoming_locations.insert(_index,npc_cache.pop_front().new())
				else:
					npc_cache.pop_front()
					upcoming_locations.insert(_index, current_area)
			else:
				upcoming_locations.insert(_index, current_area)


func _ready():
	if not save_file.get_saved_value("Game", "current_area"):
		current_area = AbandonedForest.new()
		save_file.save_value("Game", "current_area",current_area)
		current_event = current_area
	else:
		current_area = save_file.get_saved_value("Game", "current_area")
		
	if not save_file.get_saved_value("Game", "current_event"):
		current_event = current_area
	else:
		current_event = save_file.get_saved_value("Game", "current_event")
		
	generate_locations()
	update_story_info()
	
func _on_location_reseted():
	current_event = current_area
	save_file.save_value("Game", "current_event",current_event)
	update_story_info()
	update_actions()
	
#need to save locations_passed
func _on_location_advanced():
	locations_passed += 1
	if locations_passed == current_area.total_locations:
		current_area = current_area.next_area
		current_event = current_area
		
		locations_passed = 0
	current_event = upcoming_locations[locations_passed]
	save_file.save_value("Game", "current_event",current_event)
	update_story_info()
	update_actions()
	
func update_story_info():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var textures = filtered_textures()
	var texture_index = rand.randi_range(0,textures.size() - 1)
	story_texture.texture = load(textures[texture_index])
	history_label.text = current_event.HISTORY


func filtered_textures():
	var texture_cache = [] + current_event.TEXTURES
	texture_cache.erase(story_texture.texture.resource_path)
	return texture_cache
	
	
func _on_search_for_item(_action_texture_rect: ActionTextureRect) -> void:
	randomize()
	var index = round(rand_range(0,current_area.FINDINGS.size()-1))
	current_event = load(current_area.FINDINGS[index]).new()
	yield(_action_texture_rect,"story_telling_started")
	update_story_info()
	update_actions()
	
	
func _on_story_selected():
	owner.selected.deselect()
	if owner.threat_container.modulate.a > 0:
		animation_player.queue("Hide Information")
	history_label.text = current_event.HISTORY
	story_frame.modulate.a = 0.3
	owner.selected = story_frame
	update_actions()
	
	
	
func update_actions():
	var left_action = current_event.LEFT_ACTION.new()
	var right_action = current_event.RIGHT_ACTION.new()
	
	if current_event.WEST_ACTION != null:
		var west_action = current_event.WEST_ACTION.new()
		emit_signal("update_west_action",load(west_action.TEXTURE), west_action, executer)
	else:
		emit_signal("update_west_action",null, null, null)
		
	emit_signal("update_left_action", load(left_action.TEXTURE), left_action, executer)
	
	emit_signal("update_right_action", load(right_action.TEXTURE), right_action, executer)
	
	if current_event.EAST_ACTION != null:
		var east_action = current_event.EAST_ACTION.new()
		emit_signal("update_east_action", load(east_action.TEXTURE), east_action, executer)
	else:
		emit_signal("update_east_action", null, null, null)
