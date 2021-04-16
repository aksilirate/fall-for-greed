extends Node





func emit_sound_effect(path: String):
	var _sound_effect = preload("res://Scenes/SoundEffect/SoundEffect.tscn").instance()
	_sound_effect.stream = load(path)
	add_child(_sound_effect)

func emit_ambient_sound_effect(path: String):
	var _sound_effect = preload("res://Scenes/SoundEffect/SoundEffect.tscn").instance()
	_sound_effect.stream = load(path)
	_sound_effect.volume_db = 21.666
	_sound_effect.bus = "Ambient"
	call_deferred("add_child", _sound_effect)
