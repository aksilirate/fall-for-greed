extends Label
class_name LabelButton

signal pressed


func _ready():
# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")
# warning-ignore:return_value_discarded
	connect("gui_input", self, "_on_gui_input")


func _on_mouse_entered():
	Sound.emit_sound_effect("res://Sounds/Interface/Hover.wav")
	modulate.a = 0.5

func _on_mouse_exited():
	modulate.a = 1
	

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			Sound.emit_sound_effect("res://Sounds/Interface/Button.wav")
			emit_signal("pressed")
