extends TextureRect
class_name ForgedTextureRect





func emit_Mouse_Entered_Effect():
	Sound.emit_sound_effect("res://Sounds/Interface/Hover.wav")
	modulate.a = 0.5

func deselect():
	modulate.a = 1
