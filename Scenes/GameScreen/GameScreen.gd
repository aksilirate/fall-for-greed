extends Control

export(NodePath) onready var threat_container = get_node(threat_container) as VBoxContainer
export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var hold_slot = get_node(hold_slot) as Node
export(NodePath) onready var area = get_node(area) as Node


onready var history_label = get_node("HistoryLabel")
onready var selected = get_node("StoryFrame")

var last_selected_character: Object
var menu_open = false

signal story_selected

func _init():
	visible = false


func _ready():
# warning-ignore:return_value_discarded
	Events.connect("slept", self, "save_game")
# warning-ignore:return_value_discarded
	Events.connect("console_command_save", self, "save_game")
	
# warning-ignore:return_value_discarded
	Events.connect("location_reset", self, "_on_location_reset")
	
	var west_action = $Actions/WestAction
	area.connect("update_west_action", west_action, "_on_update_west_action")
	var left_action = $Actions/LeftAction
	area.connect("update_left_action", left_action, "_on_update_left_action")
	var right_action = $Actions/RightAction
	area.connect("update_right_action", right_action, "_on_update_right_action")
	var east_action = $Actions/EastAction
	area.connect("update_east_action", east_action, "_on_update_east_action")
	
	
	load_game()
	
	
	if OS.is_debug_build():
		var _debug = Debug.new()
		add_child(_debug)



	if not Game.selected_tarot_card:
		load_card_picking_scene()
	else:
		$TarotCardTexture.texture = load(Game.selected_tarot_card.TEXTURE)
		animation_player.play("Load")
		history_label.text = selected.story
		emit_signal("story_selected")





func load_card_picking_scene():
	var card_picking_scene = preload("res://Scenes/CardPickingScene/CardPickingScene.tscn").instance()
	add_child(card_picking_scene)
	$BlackScreen.modulate.a = 1.0
	show()



func _on_character_death(_character):
	if _character:
		_character.free()
		emit_signal("story_selected")

		
		
		
	if $Logic/Characters.get_child_count() == 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/DeathScreen/DeathScreen.tscn")
		
		
	for _label in $CharacterLabels.get_children():
		_label.hide()
	for _character in $Logic/Characters.get_children():
		$Logic/Characters.update_character_label(_character)
		
		
		
func _on_summon_character(_character):
	$Logic/Characters.summon_character(_character)


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
			
			


func show_information():
	if $TarotCardTexture.modulate.a > 0:
		$AnimationPlayer.play("Hide Tarot Card")
	$AnimationPlayer.queue("Show Information")


func hide_information():
	if $ProfileBorder.modulate.a > 0:
		$AnimationPlayer.play("Hide Information")
	if $TarotCardTexture.modulate.a < 1.0:
		$AnimationPlayer.queue("Show Tarot Card")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Load":
		selected.modulate.a = 0.3

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Load":
		$TarotCardTexture.texture = load(Game.selected_tarot_card.TEXTURE)
		emit_signal("story_selected")
		
	if anim_name == "Show Screen":
		$TarotCardTexture.texture = load(Game.selected_tarot_card.TEXTURE)
		emit_signal("story_selected")



func _on_location_reset():
	$Logic/Area.update_story_info()
	$Logic/Area.update_actions()



func save_game():
	var characters = Save.get_section_values("characters")
	if characters:
		for character_name in characters:
			if not $Logic/Characters.get_node_or_null(character_name):
				Save.erase_value("characters", character_name)
			
	for character in get_tree().get_nodes_in_group("characters"):
		Save.save_value("characters", character.character_name, inst2dict(character))
		
	Save.save_value("Game", "minutes_passed", Game.minutes_passed)
	Save.save_value("Game", "current_area", Game.current_area)
	Save.save_value("Game", "current_event", Game.current_event)
	Save.save_value("Game", "upcoming_locations", Game.upcoming_locations)
	Save.save_value("Game", "location_index", Game.location_index)
	Save.save_value("Game", "findings_left", Game.findings_left)
	Save.save_value("Game", "selected_tarot_card", Game.selected_tarot_card)
	Save.save_value("Game", "equipped_artifact", Game.equipped_artifact)
	Save.save_value("game", "held_item", Game.held_item)






func load_game():
	var saved_minutes_passed  = Save.get_saved_value("Game", "minutes_passed")
	if saved_minutes_passed:
		Game.minutes_passed = saved_minutes_passed
	else:
		randomize()
		Game.minutes_passed = int(rand_range(0,121))
		
		
	var saved_current_area = Save.get_saved_value("Game", "current_area")
	if saved_current_area:
		Game.current_area = saved_current_area
	else:
		Game.current_area = AbandonedForest.new()
		Game.current_event = Game.current_area

		
	var saved_current_event = Save.get_saved_value("Game", "current_event")
	if saved_current_event:
		Game.current_event = saved_current_event
	else:
		Game.current_event = Game.current_area
		
		
	var saved_location_index = Save.get_saved_value("Game", "location_index")
	if saved_location_index:
		Game.location_index = saved_location_index
	else:
		Game.location_index = 0
		
		
	var saved_findings_left = Save.get_saved_value("Game", "findings_left")
	if saved_findings_left:
		Game.findings_left = saved_findings_left
	else: 
		$Logic/Area.reset_findings_left()

	
	var saved_upcoming_locations = Save.get_saved_value("Game", "upcoming_locations")
	if saved_upcoming_locations:
		Game.upcoming_locations = saved_upcoming_locations
	else:
		Game.generate_locations()

	var saved_selected_tarot_card =  Save.get_saved_value("Game", "selected_tarot_card")
	if saved_selected_tarot_card:
		Game.selected_tarot_card = saved_selected_tarot_card

	var saved_artifact = Save.get_saved_value("Game", "equipped_artifact")
	if saved_artifact:
		Game.equipped_artifact = saved_artifact
	else:
		Game.equipped_artifact = null
	
	var saved_held_item = Save.get_saved_value("game", "held_item")
	if saved_held_item:
		Game.held_item = saved_held_item
		$HoldSlot.load_selected_item_texture(Game.held_item)
	
	
	$Logic/Area.update_story_info()


