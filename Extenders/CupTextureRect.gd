extends TextureRect
class_name CupTextureRect

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var cup_hover_sound = get_node(cup_hover_sound) as AudioStreamPlayer
export(NodePath) onready var tween = get_node(tween) as Tween




func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")


func _on_mouse_exited():
	tween.stop_all()
	var current_volume = cup_hover_sound.volume_db
	tween.interpolate_property(cup_hover_sound, "volume_db", current_volume, -80, 6.0, Tween.TRANS_LINEAR)
	tween.start()
	
	get_material().set_shader_param("enabled", false)
		
func _on_mouse_entered():
	tween.stop_all()
	var current_volume = cup_hover_sound.volume_db
	tween.interpolate_property(cup_hover_sound, "volume_db", current_volume, 19, 1.0, Tween.TRANS_LINEAR)
	tween.start()
	
	get_material().set_shader_param("enabled", true)
