extends Control

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer



func _init():
	visible = false


func _ready():
	var options_file = OptionsFile.new()
	options_file.assign_Default_Options()
	options_file.apply_Options()
	animation_player.play("Load")

	
# warning-ignore:unused_argument
func _input(event):
	if Input.is_action_just_pressed("ui_esc"):
		if animation_player.current_animation == "Load" and animation_player.is_playing():
			animation_player.seek(4.5, true)



