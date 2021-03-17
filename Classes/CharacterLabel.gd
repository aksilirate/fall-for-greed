extends LabelButton
class_name CharacterLabel

onready var animation_player = owner.get_node("AnimationPlayer")
onready var threat_container = owner.get_node("ThreatContainer")
onready var profile_texture = owner.get_node("ProfileTexture")
onready var profile_border = owner.get_node("ProfileBorder")
onready var history_label = owner.get_node("HistoryLabel")
onready var inventory = owner.get_node("Inventory")

var character: Object

var self_profile_texture = null
var story: String

signal character_selected()

func _ready():
# warning-ignore:return_value_discarded
	connect("character_selected", threat_container,"_on_character_selected")
	
# warning-ignore:return_value_discarded
	connect("pressed", self , "_on_pressed")


func _on_pressed():
	if owner.selected != self and not animation_player.is_playing():
		emit_Sound_Effect("res://Sounds/Interface/Button.wav")
		if owner.selected:
			owner.selected.deselect()
		if owner.selected != self:
			threat_container.show()
			profile_border.show()
			inventory.rect_position.x = 0
			
			profile_texture.texture = self_profile_texture
			animation_player.play("Show Information")
			
		history_label.text = story
		owner.selected = self
		modulate.a = 0.3
		owner.last_selected_character = character
		emit_signal("character_selected")



func _on_mouse_entered():
	var _focus_level: String
	
	if character.traits["focus"] == 0.0:
		_focus_level = "worst focus"
	elif character.traits["focus"] < 0.1:
		_focus_level = "terrible focus"
	elif character.traits["focus"] < 0.2:
		_focus_level = "awful focus"
	elif character.traits["focus"] < 0.3:
		_focus_level = "bad focus"
	elif character.traits["focus"] < 0.4:
		_focus_level = "poor focus"
	elif character.traits["focus"] < 0.5:
		_focus_level = "moderate focus"
	elif character.traits["focus"] < 0.6:
		_focus_level = "fair focus"
	elif character.traits["focus"] < 0.7:
		_focus_level = "good focus"
	elif character.traits["focus"] < 0.8:
		_focus_level = "great focus"
	elif character.traits["focus"] < 0.9:
		_focus_level = "impressive focus"
	elif character.traits["focus"] < 1.0:
		_focus_level = "incredible focus"
	elif character.traits["focus"] == 1.0:
		_focus_level = "best focus"
		
	hint_tooltip = _focus_level
	
	if owner.selected != self:
		emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5

func _on_mouse_exited():
	if owner.selected != self:
		modulate.a = 1

func deselect():
	modulate.a = 1
