extends LabelButton


signal update_west_action(_texture, _action, _executer)
signal update_left_action(_texture, _action, _executer)
signal update_right_action(_texture, _action, _executer)
signal update_east_action(_texture, _action, _executer)

onready var animation_player = owner.get_node("AnimationPlayer")
onready var threat_container = owner.get_node("ThreatContainer")
onready var profile_texture = owner.get_node("ProfileTexture")
onready var profile_border = owner.get_node("ProfileBorder")
onready var history_label = owner.get_node("HistoryLabel")
onready var inventory = owner.get_node("Inventory")

func _ready():
	var west_action = owner.get_node("Actions/WestAction")
# warning-ignore:return_value_discarded
	connect("update_west_action", west_action, "_on_update_west_action")
	
	var left_action = owner.get_node("Actions/LeftAction")
# warning-ignore:return_value_discarded
	connect("update_left_action", left_action, "_on_update_left_action")
	
	var right_action = owner.get_node("Actions/RightAction")
# warning-ignore:return_value_discarded
	connect("update_right_action", right_action, "_on_update_right_action")
	
	var east_action = owner.get_node("Actions/EastAction")
# warning-ignore:return_value_discarded
	connect("update_east_action", east_action, "_on_update_east_action")
	
# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_pressed")


func _on_pressed():
	var story = get_tree().get_nodes_in_group("story").front()

	emit_Sound_Effect("res://Sounds/Interface/Button.wav")

	
	if owner.selected:
		owner.selected.deselect()
		
	if owner.selected != self:
		if inventory.visible:
			animation_player.play("Hide Information")
			owner.selected = self
			yield(animation_player,"animation_finished")
		threat_container.hide()
		inventory.rect_position.x = -100
		if story.current_artifact != null:
			profile_texture.texture = story.current_artifact.SELF_PROFILE_PICTURE
		else:
			profile_border.hide()
			profile_texture.texture = null
			
		get_parent().show_information()
		
		update_actions()
		
	if story.current_artifact != null:
		history_label.text = story.current_artifact.STORY
	else:
		history_label.text = "You don't have any artifact."

	owner.selected = self
	modulate.a = 0.3

func _on_mouse_entered():
	if owner.selected != self:
		emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
		modulate.a = 0.5

func _on_mouse_exited():
	if owner.selected != self:
		modulate.a = 1

func deselect():
	modulate.a = 1


func update_actions():
	var story = get_tree().get_nodes_in_group("story").front()
	var executer = owner.get_node("Logic/Characters").get_children()
	
	if story.current_artifact != null:
		emit_signal("update_west_action", load(BreakArtifact.TEXTURE), BreakArtifact, executer)
	else:
		emit_signal("update_west_action", null, null, null)
		
	emit_signal("update_left_action",null, null, null)
	emit_signal("update_right_action", null, null, null)
	emit_signal("update_east_action", null, null, null)


