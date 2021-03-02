extends HBoxContainer









func _ready():
	var _characters = owner.get_node_or_null("Logic/Characters")
	if _characters == null:
		var _character_texture_rect = preload("res://Scenes/CharacterTextureRect/CharacterTextureRect.tscn").instance()
		var _character = PyryWright.new()
		_character_texture_rect.character_reference = _character
		_character_texture_rect.texture = load(_character.UNIT_TEXTURE)
		add_child(_character_texture_rect)
	else:
		for _character in _characters.get_children():
			var _character_texture_rect = preload("res://Scenes/CharacterTextureRect/CharacterTextureRect.tscn").instance()
			_character_texture_rect.character_reference = _character
			_character_texture_rect.texture = load(_character.UNIT_TEXTURE)
			add_child(_character_texture_rect)
