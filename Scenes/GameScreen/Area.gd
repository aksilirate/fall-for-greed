extends Node

onready var game_screen = get_parent().get_parent()
onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")
onready var history_label = owner.get_node("HistoryLabel")
onready var story_texture = owner.get_node("StoryTexture")
onready var story_frame = owner.get_node("StoryFrame")


signal update_west_action(_texture, _action, _executer)
signal update_left_action(_texture, _action, _executer)
signal update_right_action(_texture, _action, _executer)
signal update_east_action(_texture, _action, _executer)


	
func reset_findings_left():
	randomize()
	Game.findings_left = randi() % 10
	
	
	
	
func change_event_to(_event: Object):
	Game.current_event = _event
	update_story_info()
	update_actions()


	
func used_location_removed():
	if Game.upcoming_locations[Game.location_index].get_script() != Game.current_area.get_script() and not Game.upcoming_locations[Game.location_index] is Zone:
		Game.upcoming_locations.remove(Game.location_index)
		Game.current_area.total_locations -= 1
		return true
	else:
		Game.location_index += 1
		return false
		
#need to save location_index
func advance_location():
	
	if used_location_removed():
		print("last location removed (area.gd)")
	else:
		print("last location was not removed (area.gd)")
		

	if Game.location_index == Game.current_area.total_locations:
		Game.current_area = Game.current_area.NEXT_AREA.new()
		Game.current_event = Game.current_area
		Game.generate_locations()
	else:
		if Game.upcoming_locations[Game.location_index] is Enemy and Game.selected_tarot_card.get("HERMIT") and \
		Game.location_index != Game.upcoming_locations.size() - 1:
			Game.current_event = Game.current_area
		else:
			Game.current_event = Game.upcoming_locations[Game.location_index]
	
	
		if Game.current_event.get_script() == Game.current_area.get_script():
			if rand_range(0,1) < 0.02:
				if Game.equipped_artifact == null:
					Game.current_event = Wanderer
			
	reset_findings_left()
	update_story_info()
	update_actions()




	
func update_story_info():
	randomize()
	var textures = filtered_textures()
	if textures.size() > 0:
		var texture_index = randi() % textures.size()
		story_texture.texture = load(textures[texture_index])
	else:
		print("Error: texture.size() < 0")
	history_label.text = Game.current_event.HISTORY
	

func filtered_textures():
	var texture_cache = [] + Game.current_event.TEXTURES
	texture_cache.erase(story_texture.texture.resource_path)
	return texture_cache
	
	
func _on_story_selected():
	if owner.selected:
		owner.selected.deselect()
	owner.hide_information()
	history_label.text = Game.current_event.HISTORY
	story_frame.modulate.a = 0.3
	owner.selected = story_frame
	update_actions()
	
	
func update_actions():
	var executer = owner.get_node("Logic/Characters").get_children()
	
	if Game.current_event.WEST_ACTION != null:
		var west_action = Game.current_event.WEST_ACTION
		emit_signal("update_west_action",load(west_action.TEXTURE), west_action, executer)
	else:
		emit_signal("update_west_action",null, null, null)
		
		
	if Game.current_event.LEFT_ACTION != null:
		var left_action = Game.current_event.LEFT_ACTION
		emit_signal("update_left_action", load(left_action.TEXTURE), left_action, executer)
	else:
		emit_signal("update_left_action",null, null, null)
	
	
	if Game.current_event.RIGHT_ACTION != null:
		var right_action = Game.current_event.RIGHT_ACTION
		
		if Game.current_event.RIGHT_ACTION == ChangeDirectionAction:
			var tired_character = false
			for _character in get_tree().get_nodes_in_group("characters"):
				if _character.hormones["melatonin"] > 0.83:
					tired_character = true
					
			if tired_character:
				right_action = SleepAction

		emit_signal("update_right_action", load(right_action.TEXTURE), right_action, executer)
		
	else:
		emit_signal("update_right_action",null, null, null)
	


	if Game.current_event.EAST_ACTION != null:
		var east_action = Game.current_event.EAST_ACTION
		emit_signal("update_east_action", load(east_action.TEXTURE), east_action, executer)
	else:
		emit_signal("update_east_action", null, null, null)
