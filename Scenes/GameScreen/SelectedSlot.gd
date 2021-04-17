extends TextureRect




func _on_item_hold(_item):
	
	if Game.held_item != null:
		owner.last_selected_character.inventory.append(Game.held_item)
	Game.held_item = _item
	
	for _child in get_children():
		_child.queue_free()
		
	if _item != null:
		load_selected_item_texture(Game.held_item)

func load_selected_item_texture(_selected_item):
		var _item_rect = TextureRect.new()
		_item_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_item_rect.texture = load(_selected_item.TEXTURE)
		_item_rect.rect_position = Vector2(1,1)
		add_child(_item_rect)
