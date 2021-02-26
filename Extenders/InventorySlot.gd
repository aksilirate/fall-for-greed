extends GameTextureRect
class_name InventorySlot

var item: Object

signal update_west_action(_texture, _action, _executer)
signal update_left_action(_texture, _action, _executer)
signal update_right_action(_texture, _action, _executer)
signal update_east_action(_texture, _action, _executer)


func _ready():
# warning-ignore:return_value_discarded
	connect("texture_rect_clicked", self , "_on_slot_selected")
	
	var west_action = owner.get_node("Actions/WestAction")
# warning-ignore:return_value_discarded
	connect("update_west_action", west_action, "_on_update_west_action")
	
	var left_action = owner.get_node("Actions/LeftAction")
# warning-ignore:return_value_discarded
	connect("update_left_action", left_action, "_on_update_left_action")
	
	var right_action = owner.get_node("Actions/RightAction")
# warning-ignore:return_value_discarded
	connect("update_right_action", right_action, "_on_update_right_action")
	
	var east_action = owner.get_node("Actions/EastAction")
# warning-ignore:return_value_discarded
	connect("update_east_action", east_action, "_on_update_east_action")



func _on_slot_update(_item: Object):
	item = _item
	
	for _child in get_children():
		_child.queue_free()
		
	if _item != null:
		var _item_rect = TextureRect.new()
		_item_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_item_rect.texture = load(_item.TEXTURE)
		add_child(_item_rect)

func _on_slot_selected():
	history_label.text = item.HISTORY
	update_actions()

func update_actions():
	var west_action = item.WEST_ACTION.new()
	var left_action = item.LEFT_ACTION.new()
	var right_action = item.RIGHT_ACTION.new()
	var east_action = item.EAST_ACTION.new()
	emit_signal("update_west_action",load(west_action.TEXTURE), west_action, owner.last_selected_character)
	emit_signal("update_left_action", load(left_action.TEXTURE), left_action, owner.last_selected_character)
	emit_signal("update_right_action", load(right_action.TEXTURE), right_action, owner.last_selected_character)
	emit_signal("update_east_action", load(east_action.TEXTURE), east_action, owner.last_selected_character)
