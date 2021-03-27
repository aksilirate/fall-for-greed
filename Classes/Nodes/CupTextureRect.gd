extends TextureRect
class_name CupTextureRect

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var cup_hover_sound = get_node(cup_hover_sound) as AudioStreamPlayer
export(NodePath) onready var tween = get_node(tween) as Tween

var hover_time = 0 setget set_hover_time
var hold_time = 0 setget set_hold_time
var hovering := false
var peeked := false
var holding := false

signal pressed

func _ready():
# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")
# warning-ignore:return_value_discarded
	connect("gui_input", self, "_on_gui_input")
# warning-ignore:return_value_discarded
	animation_player.connect("animation_finished", self, "_on_animation_finished")


func _physics_process(delta):
	if hovering and not Input.is_mouse_button_pressed(BUTTON_LEFT):
		self.hover_time += delta
	elif hover_time:
		self.hover_time = 0
	
	if holding:
		self.hold_time += delta
	

func _on_animation_finished(anim_name):
	if anim_name == "Load":
		peeked = false
	
	
	
func _on_mouse_exited():
	tween.stop_all()
	var current_volume = cup_hover_sound.volume_db
	tween.interpolate_property(cup_hover_sound, "volume_db", current_volume, -80, 6.0, Tween.TRANS_LINEAR)
	tween.start()
	
	get_material().set_shader_param("enabled", false)
	hovering = false



func _on_mouse_entered():
	tween.stop_all()
	var current_volume = cup_hover_sound.volume_db
	tween.interpolate_property(cup_hover_sound, "volume_db", current_volume, 19, 1.0, Tween.TRANS_LINEAR)
	tween.start()
	
	get_material().set_shader_param("enabled", true)
	hovering = true




func set_hover_time(_value):
	hover_time = _value
	if hover_time >= 0.666:
		if not peeked:
			get_parent().peek_count += 1
			peeked = true
			
			var peek_tween = Tween.new()
			add_child(peek_tween)
			
			peek_tween.interpolate_property(self, "rect_position", rect_position, rect_position - Vector2(0,6.66), 0.3, Tween.TRANS_SINE)
			peek_tween.start()
			yield(peek_tween,"tween_completed")
			peek_tween.interpolate_property(self, "rect_position", rect_position, rect_position + Vector2(0,6.66), 0.3, Tween.TRANS_SINE)
			peek_tween.start()
			yield(peek_tween,"tween_completed")
			peek_tween.queue_free()


func set_hold_time(_value):
	hold_time = _value
	if hold_time >= 0.666:
		get_parent().avoided_fool = true
		cup_pressed()


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed and not animation_player.is_playing():
			cup_pressed()
		elif event.pressed and not animation_player.is_playing():
			holding = true


func cup_pressed():
	get_material().set_shader_param("enabled", false)
	animation_player.playback_speed = 1.0
	holding = false
	hold_time = 0
	emit_signal("pressed")
	







