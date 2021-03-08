extends HBoxContainer









func _ready():
	var _characters = get_tree().get_root().get_node_or_null("GameScreen/Logic/Characters")
	if _characters == null:
		var _character_texture_rect = preload("res://Scenes/CharacterTextureRect/CharacterTextureRect.tscn").instance()
		var _character = Character.new()
		_character_texture_rect.character_reference = _character
		_character_texture_rect.texture = _character.unit_texture
		add_child(_character_texture_rect)
	else:
		for _character in _characters.get_children():
			var _character_texture_rect = preload("res://Scenes/CharacterTextureRect/CharacterTextureRect.tscn").instance()
			_character_texture_rect.character_reference = _character
			_character_texture_rect.texture = _character.unit_texture
			add_child(_character_texture_rect)
