extends Label
class_name ForgedLabel



func emit_Sound_Effect(path: String):
	var _sound_effect = preload("res://Scenes/SoundEffect/SoundEffect.tscn").instance()
	_sound_effect.stream = load(path)
	get_node("/root").add_child(_sound_effect)

func emit_Mouse_Entered_Effect():
	emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
	modulate.a = 0.5

func deselect():
	modulate.a = 1
