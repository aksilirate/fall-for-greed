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


var west_action: Object
var left_action: Object
var right_action: Object
var east_action : Object

var character_name = "unnamed"

var game_logic = GameLogic.new()
var inventory: Array

var stats = {
	"mood" : 1,
	"health": 1,
	"hunger": 1,
	"energy": 1
}




func save_stats():
	var save_file = SaveFile.new()
	for _stat in stats:
		save_file.save_value(character_name, _stat, stats[_stat])

func save_inventory():
	var save_file = SaveFile.new()
	save_file.save_value(character_name, "inventory", inventory)
	
	
	
func get_hunger_status():
	if stats["hunger"] < 0.2:
		return "starving"
	elif stats["hunger"] < 0.4:
		return "famished"
	elif stats["hunger"] < 0.6:
		return "hungry"
	
	
#	gets connected by Character: Node 
func _on_character_selected(_owner: Node) -> void:
	update_actions(_owner)
	update_inventory()
	
	
func init_character_data(_character_name) -> void:
	var save_file = SaveFile.new()
	
	for _stat in stats:
		if not save_file.get_saved_value(_character_name, _stat):
			stats[_stat] = rand_range(0.5,1)
			save_file.save_value(_character_name, _stat, stats[_stat])
		else:
			stats[_stat] = save_file.get_saved_value(_character_name, _stat)

	if not save_file.get_saved_value(_character_name, "inventory"):
		save_file.save_value(_character_name, "inventory", [])
	else:
		inventory = save_file.get_saved_value(_character_name, "inventory")
	
	
	
func update_actions(_owner: Node) -> void:
	if _owner.area.current_event.get("ITEM") or _owner.hold_slot.selected_item != null:
		if inventory.size() < 8:
			west_action = TakeAction.new()
	else:
		west_action = PrayAction.new()
	
	left_action = RemoveToothAction.new()
	right_action = BiteTongueAction.new()
	east_action = TakeEyeAction.new()
		
	
	emit_signal("update_west_action",load(west_action.TEXTURE), west_action, self)
	emit_signal("update_left_action",load(left_action.TEXTURE), left_action, self)
	emit_signal("update_right_action",load(right_action.TEXTURE), right_action, self)
	emit_signal("update_east_action",load(east_action.TEXTURE), east_action, self)

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
