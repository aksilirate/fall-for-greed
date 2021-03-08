extends GameTextureRect
class_name InventorySlot



var item: Object

signal update_west_action(_texture, _action, _executer)
signal update_left_action(_texture, _action, _executer)
signal update_right_action(_texture, _action, _executer)
signal update_east_action(_texture, _action, _executer)

signal item_hold(_item)

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


# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self , "_on_mouse_exited")
# warning-ignore:return_value_discarded
	connect("gui_input", self, "_on_gui_input")
	
# warning-ignore:return_value_discarded
	connect("item_hold", owner.get_node("HoldSlot"), "_on_item_hold")




func destroy_item():
	owner.get_node("StoryFrame")._on_StoryFrame_texture_rect_clicked()
	owner.last_selected_character.inventory.remove(get_index())
	owner.save()
	for _child in get_children():
		_child.queue_free()
	item = null
	
	
func hold_item():
	emit_signal("item_hold", item)
	destroy_item()
	
		
func _on_slot_update(_item: Object):
	item = _item
	for _child in get_children():
		_child.queue_free()
		
	if _item != null:
		var _item_rect = TextureRect.new()
		_item_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_item_rect.texture = load(_item.TEXTURE)
		add_child(_item_rect)


func _on_gui_input(event):
	if get_parent().visible:
		emit_Pressed_Effect(event)

func _on_mouse_entered():
	if get_parent().visible:
		if owner.selected != self and not animation_player.is_playing():
			emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
			modulate.a = 0.5
			
func _on_mouse_exited():
	if owner.selected != self:
		modulate.a = 1

func _on_slot_selected():
	if item:
		history_label.text = item.HISTORY
	else:
		history_label.text = "An empty inventory slot."
	update_actions()
	
	
func update_actions():
	if not item:
		emit_signal("update_west_action", null, null, owner.last_selected_character)
		emit_signal("update_left_action", null, null, owner.last_selected_character)
		emit_signal("update_right_action", null, null, owner.last_selected_character)
		emit_signal("update_east_action", null, null, owner.last_selected_character)
	else:
		if item.WEST_ACTION:
			var west_action = item.WEST_ACTION.new()
			emit_signal("update_west_action",load(west_action.TEXTURE), west_action, owner.last_selected_character)
		else:
			emit_signal("update_west_action",null, null, owner.last_selected_character)
			
			
		if item.LEFT_ACTION:
			var left_action = item.LEFT_ACTION.new()
			emit_signal("update_left_action", load(left_action.TEXTURE), left_action, owner.last_selected_character)
		else:
			emit_signal("update_left_action", null, null, owner.last_selected_character)
			
			
		if item.RIGHT_ACTION:
			var right_action = item.RIGHT_ACTION.new()
			emit_signal("update_right_action", load(right_action.TEXTURE), right_action, owner.last_selected_character)
		else:
			emit_signal("update_right_action", null, null, owner.last_selected_character)
			
			
		if item.EAST_ACTION:
			var east_action = item.EAST_ACTION.new()
			emit_signal("update_east_action", load(east_action.TEXTURE), east_action, owner.last_selected_character)
		else:
			emit_signal("update_east_action", null, null, owner.last_selected_character)



