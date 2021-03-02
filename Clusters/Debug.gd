extends Node
class_name Debug

var console_open := false


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if console_open:
			console_open = false
			get_child(0).queue_free()
		else:
			var console_input = preload("res://Scenes/ConsoleInput/ConsoleInput.tscn").instance()
			console_open = true
			add_child(console_input)
			console_input.grab_focus()
