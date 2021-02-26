extends TextureRect

var selected_item: Object

func _on_item_selected(_item):
	selected_item = _item
	
	for _child in get_children():
		_child.queue_free()
		
	if _item != null:
		var _item_rect = TextureRect.new()
		_item_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_item_rect.texture = load(_item.TEXTURE)
		_item_rect.rect_position = Vector2(1,1)
		add_child(_item_rect)

