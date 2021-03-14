extends ForgedLabel
class_name CharacterLabel

onready var animation_player = owner.get_node("AnimationPlayer")
onready var threat_container = owner.get_node("ThreatContainer")
onready var profile_texture = owner.get_node("ProfileTexture")
onready var history_label = owner.get_node("HistoryLabel")

var character: Object

var self_profile_texture = null
var story: String

signal character_selected()

func _ready():
# warning-ignore:return_value_discarded
	connect("character_selected", threat_container,"_on_character_selected")
# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")
# warning-ignore:return_value_discarded
	connect("gui_input", self, "_on_gui_input")

func _on_mouse_entered():
	if owner.selected != self and not animation_player.is_playing():
		emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5

func _on_mouse_exited():
	if owner.selected != self:
		modulate.a = 1


func label_clicked():
	owner.last_selected_character = character
	emit_signal("character_selected")


func _on_gui_input(event):
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
			label_clicked()
	
