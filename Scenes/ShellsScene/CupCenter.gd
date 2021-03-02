extends TextureRect

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer

signal center_cup_selected(_cup)




func _on_CupCenter_mouse_entered():
	get_material().set_shader_param("enabled", true)

func _on_CupCenter_mouse_exited():
	get_material().set_shader_param("enabled", false)


func _on_CupCenter_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			get_material().set_shader_param("enabled", false)
			animation_player.playback_speed = 1.0
			emit_signal("center_cup_selected", "Center")
		



