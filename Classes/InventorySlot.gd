extends GameTextureRect
class_name InventorySlot

onready var game_screen = owner

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
		if _item.get("TOOLTIP"):
			hint_tooltip = _item.TOOLTIP
		else:
			hint_tooltip = ""
		add_child(_item_rect)
	else:
		hint_tooltip = ""

func _on_gui_input(event):
	if get_parent().visible:
		emit_Pressed_Effect(event)

func _on_mouse_entered():
	if get_parent().visible:
		if owner.selected != self and not animation_player.is_playing():
			Audio.emit_sound_effect("res://Sounds/Interface/Hover.wav")
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
			var west_action = item.WEST_ACTION
			emit_signal("update_west_action",load(west_action.TEXTURE), west_action, owner.last_selected_character)
		else:
			emit_signal("update_west_action",null, null, owner.last_selected_character)
			
			
		if item.LEFT_ACTION:
			if item.LEFT_ACTION.get("CLASS_NAME") == "MakeCampfireAction" and Game.current_event is Enemy:
				emit_signal("update_left_action", null, null, owner.last_selected_character)
				
			elif item.LEFT_ACTION.get("CLASS_NAME") == "DigAction" and not Game.current_event is QueensGrave:
				emit_signal("update_left_action", null, null, owner.last_selected_character)
			
			else:
				var left_action = item.LEFT_ACTION
				emit_signal("update_left_action", load(left_action.TEXTURE), left_action, owner.last_selected_character)
		else:
			emit_signal("update_left_action", null, null, owner.last_selected_character)

			

		# COOK CHECK
		if item.get("COOKS_INTO") and Game.current_event is CampfireEvent and item.COOKS_INTO != null:
			var right_action = CookAction
			emit_signal("update_right_action", load(right_action.TEXTURE), right_action, owner.last_selected_character)
		elif item.RIGHT_ACTION:
			var right_action = item.RIGHT_ACTION
			emit_signal("update_right_action", load(right_action.TEXTURE), right_action, owner.last_selected_character)
		else:
			emit_signal("update_right_action", null, null, owner.last_selected_character)
			
			
		if item.EAST_ACTION:
			var east_action = item.EAST_ACTION
			emit_signal("update_east_action", load(east_action.TEXTURE), east_action, owner.last_selected_character)
		else:
			emit_signal("update_east_action", null, null, owner.last_selected_character)



