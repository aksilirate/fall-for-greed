extends Control
class_name GameScreen

export(NodePath) onready var threat_container = get_node(threat_container) as VBoxContainer
export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var hold_slot = get_node(hold_slot) as Node
export(NodePath) onready var characters = get_node(characters) as Node
export(NodePath) onready var area = get_node(area) as Node


onready var history_label = get_node("HistoryLabel")
onready var selected = get_node("StoryFrame")

var save_file = SaveFile.new()
var last_selected_character: Object
var menu_open = false

signal story_selected

func _init():
	visible = false


func _ready():
	if OS.is_debug_build():
		var _debug = Debug.new()
		add_child(_debug)
	animation_player.play("Load") 
	history_label.text = selected.story
	emit_signal("story_selected")



func _on_character_death(_character):
	if _character:
		emit_signal("story_selected")
		save_file.erase_value("Characters", _character.character_name)
		_character.free()
		
		
		
	if characters.get_child_count() == 0:
		save_file.delete()
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/DeathScreen/DeathScreen.tscn")
		
		
	for _label in $CharacterLabels.get_children():
		_label.hide()
	for _character in characters.get_children():
		characters.update_character_label(_character)
		
		
		
func _on_summon_character(_character):
	characters.summon_character(_character)


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
		
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if animation_player.is_playing():
				animation_player.playback_speed = 3
				yield(animation_player, "animation_finished")
				animation_player.playback_speed = 1
			
			

func _on_AnimationPlayer_animation_finished(_anim_name):
	if _anim_name == "load":
		selected.modulate.a = 0.3




func save_game():
	save_file.save_value("game", "selected_item", hold_slot.selected_item)
	
func save():
	call_deferred("save_game")
	
	
