extends Node

onready var character_labels = owner.get_node("CharacterLabels")

var threats = ["Bleeding", "Starving", "Hungry", "Tired", "Wounded"]



func _ready():
	add_character_to_party(PyryWright.new())
	add_character_to_party(RowanSmith.new())
	
func threat_level_of(_threat):
	return threats.find(_threat)



func add_character_to_party(character):
	for _character_label in character_labels.get_children():
		if not _character_label.visible:
			connect_character_signals(character)
			_character_label.text = character.NAME
			_character_label.connect("character_selected", character, "_on_character_selected")
			_character_label.self_profile_texture = character.SELF_PROFILE_PICTURE
			_character_label.story = character.STORY
			_character_label.character = character
			_character_label.visible = true
			break
	add_child(character)




func connect_character_signals(character):
#	Connect Actions
	var west_action = owner.get_node("Actions/WestAction")
	character.connect("update_west_action", west_action, "_on_update_west_action")
	
	var left_action = owner.get_node("Actions/LeftAction")
	character.connect("update_left_action", left_action, "_on_update_left_action")
	
	var right_action = owner.get_node("Actions/RightAction")
	character.connect("update_right_action", right_action, "_on_update_right_action")
	
	var east_action = owner.get_node("Actions/EastAction")
	character.connect("update_east_action", east_action, "_on_update_east_action")
	
	
#	Connect Inventory Slots
	var north_west_slot = owner.get_node("Inventory/NorthWestSlot")
	character.connect("update_north_west_slot", north_west_slot, "_on_slot_update")
	
	var north_slot = owner.get_node("Inventory/NorthSlot")
	character.connect("update_north_slot", north_slot, "_on_slot_update")
	
	var north_east_slot = owner.get_node("Inventory/NorthEastSlot")
	character.connect("update_north_east_slot", north_east_slot, "_on_slot_update")
	
	var west_slot = owner.get_node("Inventory/WestSlot")
	character.connect("update_west_slot", west_slot, "_on_slot_update")
	
	var center_slot = owner.get_node("Inventory/CenterSlot")
	character.connect("update_center_slot", center_slot, "_on_slot_update")
	
	var east_slot = owner.get_node("Inventory/EastSlot")
	character.connect("update_east_slot", east_slot, "_on_slot_update")
	
	var south_slot = owner.get_node("Inventory/SouthSlot")
	character.connect("update_south_slot", south_slot, "_on_slot_update")
	
	var south_east_slot = owner.get_node("Inventory/SouthEastSlot")
	character.connect("update_south_east_slot", south_east_slot, "_on_slot_update")
	
	
	
	
	
