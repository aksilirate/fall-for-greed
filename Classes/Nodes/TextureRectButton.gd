extends TextureRect
class_name TextureRectButton

signal pressed


func _ready():
# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")
# warning-ignore:return_value_discarded
	connect("gui_input", self, "_on_gui_input")
	
	
func emit_Sound_Effect(path: String):
	var _sound_effect = preload("res://Scenes/SoundEffect/SoundEffect.tscn").instance()
	_sound_effect.stream = load(path)
	get_node("/root").add_child(_sound_effect)


func _on_mouse_entered():
	emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
	modulate.a = 0.5

func _on_mouse_exited():
	modulate.a = 1
	

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			emit_Sound_Effect("res://Sounds/Interface/Button.wav")
			emit_signal("pressed")

