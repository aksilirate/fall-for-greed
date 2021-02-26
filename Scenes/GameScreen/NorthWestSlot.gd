extends InventorySlot

signal item_selected(_item)


func _on_NorthWestSlot_mouse_entered():
	emit_Mouse_Entered_Effect()


func _on_NorthWestSlot_mouse_exited():
	if owner.selected != self:
		modulate.a = 1


func _on_NorthWestSlot_gui_input(event):
	emit_Pressed_Effect(event)


func remove_item_from_inventory():
	owner.get_node("StoryFrame")._on_StoryFrame_texture_rect_clicked()
	owner.last_selected_character.inventory.remove(0)
	emit_signal("item_selected", item)
	for _child in get_children():
		_child.queue_free()


