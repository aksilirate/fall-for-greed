extends ForgedTextureRect
class_name GameTextureRect

onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")
onready var profile_texture = owner.get_node("ProfileTexture")
onready var history_label = owner.get_node("HistoryLabel")

signal texture_rect_clicked

var self_profile_texture = null
var story: String



func emit_Mouse_Entered_Effect():
	if owner.selected != self and not animation_player.is_playing():
		Audio.emit_sound_effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5

func emit_Pressed_Effect(event):
	if event is InputEventMouseButton:
		if not event.pressed and owner.selected != self and not animation_player.is_playing():
			Audio.emit_sound_effect("res://Sounds/Interface/Button.wav")
			if owner.selected:
				owner.selected.deselect()
			owner.selected = self
			modulate.a = 0.3
			emit_signal("texture_rect_clicked")
