extends Control

export(NodePath) onready var threat_container = get_node(threat_container) as VBoxContainer
export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var hold_slot = get_node(hold_slot) as Node
export(NodePath) onready var characters = get_node(characters) as Node
export(NodePath) onready var area = get_node(area) as Node

onready var history_label = get_node("HistoryLabel")
onready var selected = get_node("StoryFrame")

var last_selected_character: Object
var menu_open = false

signal story_selected

func _ready():
	if OS.is_debug_build():
		var _debug = Debug.new()
		add_child(_debug)
	animation_player.play("Load") 
	history_label.text = selected.story
	emit_signal("story_selected")

	
func _on_character_death(_character):
	if _character:
		var save_file = SaveFile.new()
		save_file.erase_section(_character.character_name)
		characters.update_characters()
		emit_signal("story_selected")

	
# warning-ignore:unused_argument
func _input(event):
	if Input.is_action_just_pressed("ui_esc"):
		if not menu_open:
			var _menu = preload("res://Scenes/MenuScreen/MenuScreen.tscn").instance()
			add_child(_menu)
			menu_open = true
		else:
			get_node("MenuScreen").queue_free()
			menu_open = false

func _on_AnimationPlayer_animation_finished(_anim_name):
	if _anim_name == "load":
		selected.modulate.a = 0.3
