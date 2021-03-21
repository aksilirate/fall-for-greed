extends Node
class_name Character

signal update_west_action(_texture, _type)
signal update_left_action(_texture, _type)
signal update_right_action(_texture, _type)
signal update_east_action(_texture, _type)

signal update_north_west_slot(_item)
signal update_north_slot(_item)
signal update_north_east_slot(_item)
signal update_west_slot(_item)
signal update_center_slot(_item)
signal update_east_slot(_item)
signal update_south_slot(_item)
signal update_south_east_slot(_item)


var self_profile_picture: Resource
var unit_texture: Resource


var character_name: String
var story: String


var west_action: Object
var left_action: Object
var right_action: Object
var east_action : Object


var inventory: Array setget set_inventory

var mistakes = []
var active_effects = []
var upcoming_stories = []

var saved_effects = []

var stats = {
	"mood" : 1,
	"health": 1,
	"hunger": 1,
	"energy": 1,
	"loneliness": 1,
	"misfortune" : 0,
} setget set_stats

var traits = {
	"focus": 0.0,
	"combat": 0.0,
	"fleetness": 0.0
} setget set_traits


	
var current_character

func _ready():

	self_profile_picture = current_character.SELF_PROFILE_PICTURE
	unit_texture = current_character.UNIT_TEXTURE
	character_name = current_character.NAME
	story = current_character.STORY
	name = character_name


	for _effect in saved_effects:
		add_child(_effect)
	saved_effects = []
	
	
	add_to_group("characters")
	call_deferred("save_character")
	
	
func add_effect(_effect_type: Object):
	var _effect = Effect.new()
	_effect.active_effect = _effect_type
	add_child(_effect)
	

	
func get_hunger_status():
	if stats.hunger < 0.2:
		return "starving"
	elif stats.hunger < 0.4:
		return "famished"
	elif stats.hunger < 0.6:
		return "hungry"
	
func get_energy_status():
	if stats.energy < 0.3:
		return "sleepy"
	elif stats.energy < 0.5:
		return "tired"
		
	
func set_stats(_value):
	stats = _value
	save_character()
	
func set_traits(_value):
	traits = _value
	save_character()
	
func set_inventory(_value):
	inventory = _value
	save_character()
	
	
	
func save_character():
	var save_file = SaveFile.new()
	save_file.save_value("characters", character_name, inst2dict(self))
	
	
	
	
#	gets connected by Character: Node 
func _on_character_selected() -> void:
	update_actions()
	update_inventory()
	
	
	
	
func update_actions() -> void:
	var game_screen = get_tree().get_nodes_in_group("game_screen").front()
	if game_screen.area.current_event.get("ITEM") or game_screen.hold_slot.selected_item != null:
		if inventory.size() < 8:
			west_action = TakeAction
		else:
			west_action = PrayAction
	else:
		west_action = PrayAction
	
	
	
	if game_screen.area.current_event is load("res://Areas/AbandonedForest/Zones/AbandonedForestRopeHang.gd") as Script:
		left_action = HangAction
	else:
		left_action = null
		
	right_action = null
	east_action = null
		
		
	
	if west_action:
		emit_signal("update_west_action",load(west_action.TEXTURE), west_action, self)
	else:
		emit_signal("update_west_action", null, null, null)
		
		
	if left_action:
		emit_signal("update_left_action",load(left_action.TEXTURE), left_action, self)
	else:
		emit_signal("update_left_action",null, null, null)


	if right_action:
		emit_signal("update_right_action",load(right_action.TEXTURE), right_action, self)
	else:
		emit_signal("update_right_action", null, null, null)

	if east_action:
		emit_signal("update_east_action",load(east_action.TEXTURE), east_action, self)
	else:
		emit_signal("update_east_action", null, null, null)

func update_inventory():
	if inventory.size() - 1 >= 0:
		emit_signal("update_north_west_slot",inventory[0])
	else:
		emit_signal("update_north_west_slot", null)
		
	if inventory.size() - 1 >= 1:
		emit_signal("update_north_slot",inventory[1])
	else:
		emit_signal("update_north_slot", null)
		
	if inventory.size() - 1 >= 2:
		emit_signal("update_north_east_slot",inventory[2])
	else:
		emit_signal("update_north_east_slot", null)
		
	if inventory.size() - 1 >= 3:
		emit_signal("update_west_slot",inventory[3])
	else:
		emit_signal("update_west_slot", null)
		
	if inventory.size() - 1 >= 4:
		emit_signal("update_center_slot",inventory[4])
	else:
		emit_signal("update_center_slot", null)
		
	if inventory.size() - 1 >= 5:
		emit_signal("update_east_slot",inventory[5])
	else:
		emit_signal("update_east_slot", null)
		
	if inventory.size() - 1 >= 6:
		emit_signal("update_south_slot",inventory[6])
	else:
		emit_signal("update_south_slot", null)
		
	if inventory.size() - 1 >= 7:
		emit_signal("update_south_east_slot",inventory[7])
	else:
		emit_signal("update_south_east_slot", null)
