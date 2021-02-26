extends Node

onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")
onready var executer = owner.get_node("Logic/Characters").get_children()
onready var history_label = owner.get_node("HistoryLabel")
onready var story_texture = owner.get_node("StoryTexture")
onready var story_frame = owner.get_node("StoryFrame")

var current_area: Object
var current_event: Object

signal update_west_action(_texture, _action, _executer)
signal update_left_action(_texture, _action, _executer)
signal update_right_action(_texture, _action, _executer)
signal update_east_action(_texture, _action, _executer)

func _ready():
	current_area = AbandonedForest.new()
	current_event = current_area


func _on_location_reseted():
	current_event = current_area
	update_story_texture()
	update_actions()
	
#need to save locations_before_new_area
func _on_location_advanced():
	current_event.locations_before_new_area -= 1
	if current_event.locations_before_new_area <= 0:
		current_event = current_event.next_area
		
	update_story_texture()
	
func update_story_texture():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var textures = filtered_textures()
	var texture_index = rand.randi_range(0,textures.size() - 1)
	story_texture.texture = load(textures[texture_index])


func filtered_textures():
	var textures_cache = [] + current_event.TEXTURES
	textures_cache.erase(story_texture.texture.resource_path)
	return textures_cache
	
	
func _on_search_for_item(_action_texture_rect: ActionTextureRect) -> void:
	randomize()
	var index = round(rand_range(0,current_area.FINDINGS.size()-1))
	current_event = load(current_area.FINDINGS[index]).new()
	yield(_action_texture_rect,"story_telling_started")
	update_story_texture()
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
	var west_action = current_event.WEST_ACTION.new()
	var left_action = current_event.LEFT_ACTION.new()
	var right_action = current_event.RIGHT_ACTION.new()
	var east_action = current_event.EAST_ACTION.new()
	emit_signal("update_west_action",load(west_action.TEXTURE), west_action, executer)
	emit_signal("update_left_action", load(left_action.TEXTURE), left_action, executer)
	emit_signal("update_right_action", load(right_action.TEXTURE), right_action, executer)
	emit_signal("update_east_action", load(east_action.TEXTURE), east_action, executer)
