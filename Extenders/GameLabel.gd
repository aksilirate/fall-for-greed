extends ForgedLabel
class_name GameLabel

onready var animation_player = owner.get_node("AnimationPlayer")
onready var profile_texture = owner.get_node("ProfileTexture")
onready var history_label = owner.get_node("HistoryLabel")

signal label_clicked

var self_profile_texture = null
var story: String




func emit_Mouse_Entered_Effect():
	if owner.selected != self and not animation_player.is_playing():
		emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5

func emit_Pressed_Effect(event):
	if event is InputEventMouseButton:
		if not event.pressed and owner.selected != self and not animation_player.is_playing():
			emit_Sound_Effect("res://Sounds/Interface/Button.wav")
			if owner.selected:
				owner.selected.deselect()
			if owner.selected != self:
				profile_texture.texture = self_profile_texture
				animation_player.play("Show Information")
				
			history_label.text = story
			owner.selected = self
			modulate.a = 0.3
			emit_signal("label_clicked")
	
