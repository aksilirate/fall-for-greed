extends TextureRect

var selected_item: Object


func _ready():
	var save_file = SaveFile.new()
	var saved_selected_item = save_file.get_saved_value("game", "selected_item")
	if saved_selected_item:
		selected_item = saved_selected_item
		load_selected_item_texture(selected_item)


func _on_item_hold(_item):
	
	if selected_item != null:
		owner.last_selected_character.inventory.append(selected_item)
	selected_item = _item
	
	for _child in get_children():
		_child.queue_free()
		
	if _item != null:
		load_selected_item_texture(selected_item)

	owner.save()

func load_selected_item_texture(_selected_item):
		var _item_rect = TextureRect.new()
		_item_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_item_rect.texture = load(_selected_item.TEXTURE)
		_item_rect.rect_position = Vector2(1,1)
		add_child(_item_rect)
