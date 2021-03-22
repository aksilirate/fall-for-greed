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
			
			owner.show_information()

			
		history_label.text = story
		owner.selected = self
		modulate.a = 0.3
		owner.last_selected_character = character
		emit_signal("character_selected")



func _on_mouse_entered():
	var _trait_levels = []
	
	for _trait in character.traits.keys():
		if character.traits[_trait] == 0.0:
			_trait_levels.push_back("dreadful " + _trait)
		elif character.traits[_trait] < 0.1:
			_trait_levels.push_back("terrible " + _trait)
		elif character.traits[_trait] < 0.2:
			_trait_levels.push_back("awful " + _trait)
		elif character.traits[_trait] < 0.3:
			_trait_levels.push_back("bad " + _trait)
		elif character.traits[_trait] < 0.4:
			_trait_levels.push_back("poor " + _trait)
		elif character.traits[_trait] < 0.5:
			_trait_levels.push_back("moderate " + _trait)
		elif character.traits[_trait] < 0.6:
			_trait_levels.push_back("fair " + _trait)
		elif character.traits[_trait] < 0.7:
			_trait_levels.push_back("good " + _trait)
		elif character.traits[_trait] < 0.8:
			_trait_levels.push_back("great " + _trait)
		elif character.traits[_trait] < 0.9:
			_trait_levels.push_back("impressive " + _trait)
		elif character.traits[_trait] < 1.0:
			_trait_levels.push_back("incredible " + _trait)
		elif character.traits[_trait] == 1.0:
			_trait_levels.push_back("brilliant " + _trait)
		
	
	var _tooltip_text: String
	for _trait_text in _trait_levels:
# warning-ignore:unassigned_variable_op_assign
		_tooltip_text += _trait_text + "\n"
		
	hint_tooltip = _tooltip_text
	
	if owner.selected != self:
		emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5

func _on_mouse_exited():
	if owner.selected != self:
		modulate.a = 1

func deselect():
	modulate.a = 1
