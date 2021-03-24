extends Node

onready var game_screen = get_parent().get_parent()
onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")
onready var history_label = owner.get_node("HistoryLabel")
onready var story_texture = owner.get_node("StoryTexture")
onready var story_frame = owner.get_node("StoryFrame")

var rand = RandomNumberGenerator.new()

var upcoming_locations: Array
var findings_left: int
var location_index: int
var current_area: Object
var current_event: Object

signal update_west_action(_texture, _action, _executer)
signal update_left_action(_texture, _action, _executer)
signal update_right_action(_texture, _action, _executer)
signal update_east_action(_texture, _action, _executer)

# total_locations are generated inside the current_location

func generate_locations():
	# Generates NPCs, enemies and zones
	upcoming_locations.clear()
	location_index = 0
	
	randomize()
	rand.randomize()
	
	var enemy_cache = [] + current_area.ENEMIES
	var npc_cache = [] + current_area.NPCS
	var zone_cache = [] + current_area.ZONES
	var findings_cache = [] + current_area.FINDINGS
	
	for _index in current_area.total_locations:
		if _index < 3:
			upcoming_locations.insert(_index, current_area)
		else:
#			var _next_index = upcoming_locations.size() - 1
#
#			if upcoming_locations[_next_index] == current_area:
			if rand.randi_range(0,10) == 3 and enemy_cache.size() > 0:
				var _enemy_index = rand.randi_range(0, enemy_cache.size() - 1)
				upcoming_locations.insert(_index,enemy_cache[_enemy_index].new())
				enemy_cache.remove(_enemy_index)
				
			elif rand.randi_range(0,10) == 3 and npc_cache.size() > 0:
				upcoming_locations.insert(_index,npc_cache.pop_front().new())
				
			elif rand.randi_range(0,10) == 3 and zone_cache.size() > 0:
				upcoming_locations.insert(_index,zone_cache.pop_front().new())
				
			elif rand_range(0,1) < 0.0267 and findings_cache.size() > 0 :
				upcoming_locations.insert(_index,findings_cache.pop_front().new())
				
			else:
				upcoming_locations.insert(_index, current_area)
				
				
	if current_area.get("LAST_EVENT"):
		upcoming_locations[upcoming_locations.size() - 1] = current_area.LAST_EVENT
				
				
	var save_file = SaveFile.new()
	save_file.save_value("Game", "upcoming_locations",upcoming_locations)


func _ready():
	load_game()
	update_story_info()
	
	
func reset_findings_left():
	var save_file = SaveFile.new()
	rand.randomize()
	findings_left = rand.randi_range(0,9)
	save_file.save_value("Game", "findings_left",findings_left)
	
	
func load_game():
	var save_file = SaveFile.new()
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
	
	if not save_file.get_saved_value("Game", "location_index"):
		location_index = 0
	else:
		location_index = save_file.get_saved_value("Game", "location_index")
		
		
	if not save_file.get_saved_value("Game", "upcoming_locations"):
		generate_locations()
	else:
		upcoming_locations = save_file.get_saved_value("Game", "upcoming_locations")
	
	
	if not save_file.get_saved_value("Game", "findings_left"):
		reset_findings_left()
	else:
		findings_left = save_file.get_saved_value("Game", "findings_left")
		
	
	
func save_game():
	var save_file = SaveFile.new()
	save_file.save_value("Game", "current_area",current_area)
	save_file.save_value("Game", "current_event",current_event)
	save_file.save_value("Game", "location_index",location_index)
	save_file.save_value("Game", "upcoming_locations",upcoming_locations)
	save_file.save_value("Game", "findings_left",findings_left)
	
func change_event_to(_event: Object):
	current_event = _event
	update_story_info()
	update_actions()
	save_game()



func _on_location_reseted():
	if current_area.get_script() != current_event.get_script():
		current_event = current_area
		update_story_info()
	update_actions()
	save_game()




#need to save location_index
func advance_location():
	if upcoming_locations[location_index].get_script() != current_area.get_script() and not upcoming_locations[location_index] is Zone:
		upcoming_locations.remove(location_index)
		current_area.total_locations -= 1
	else:
		location_index += 1
		
	if location_index == current_area.total_locations:
		current_area = current_area.NEXT_AREA.new()
		current_event = current_area
		generate_locations()
	
	
	
	if upcoming_locations[location_index] is Enemy and game_screen.selected_tarot_card.get("HERMIT") and location_index != upcoming_locations.size() - 1:
		current_event = current_area
	else:
		current_event = upcoming_locations[location_index]
	
	
	if current_event.get_script() == current_area.get_script():
		if rand_range(0,1) < 0.02:
			var story = get_tree().get_nodes_in_group("story").front()
			if story.current_artifact == null:
				current_event = Wanderer
			
			
	var save_file = SaveFile.new()
	save_file.save_value("Game", "current_event",current_event)
	reset_findings_left()
	update_story_info()
	update_actions()
	save_game()




	
func update_story_info():
	rand.randomize()
	var textures = filtered_textures()
	var texture_index = rand.randi_range(0,textures.size() - 1)
	if textures.size() > 0:
		story_texture.texture = load(textures[texture_index])
	else:
		print("Error: texture.size() < 0")
	history_label.text = current_event.HISTORY
	

func filtered_textures():
	var texture_cache = [] + current_event.TEXTURES
	texture_cache.erase(story_texture.texture.resource_path)
	return texture_cache
	
	
func _on_story_selected():
	owner.selected.deselect()
	owner.hide_information()
	history_label.text = current_event.HISTORY
	story_frame.modulate.a = 0.3
	owner.selected = story_frame
	update_actions()
	
	
func update_actions():
	var executer = owner.get_node("Logic/Characters").get_children()
	
	if current_event.WEST_ACTION != null:
		var west_action = current_event.WEST_ACTION
		emit_signal("update_west_action",load(west_action.TEXTURE), west_action, executer)
	else:
		emit_signal("update_west_action",null, null, null)
		
		
	if current_event.LEFT_ACTION != null:
		var left_action = current_event.LEFT_ACTION
		emit_signal("update_left_action", load(left_action.TEXTURE), left_action, executer)
	else:
		emit_signal("update_left_action",null, null, null)
	
	
	if current_event.RIGHT_ACTION != null:
		var right_action = current_event.RIGHT_ACTION
		
		if current_event.RIGHT_ACTION == ChangeDirectionAction:
			var tired_character = false
			for _character in owner.characters.get_children():
				if _character.hormones["melatonin"] > 0.83:
					tired_character = true
					
			if tired_character:
				right_action = SleepAction

		emit_signal("update_right_action", load(right_action.TEXTURE), right_action, executer)
		
	else:
		emit_signal("update_right_action",null, null, null)
	


	if current_event.EAST_ACTION != null:
		var east_action = current_event.EAST_ACTION
		emit_signal("update_east_action", load(east_action.TEXTURE), east_action, executer)
	else:
		emit_signal("update_east_action", null, null, null)
