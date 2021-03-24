extends ForgedTextureRect

onready var animation_player = owner.get_node("AnimationPlayer")
onready var history_label = owner.get_node("HistoryLabel")
onready var actions = owner.get_node("Actions")
var current_mode = "story"



func _on_ActionStoryButton_mouse_entered():
	if not animation_player.is_playing():
		emit_Sound_Effect("res://Sounds/Interface/Hover.wav")
		modulate = Color(0.5,0.5,0.5,1)


func _on_ActionStoryButton_mouse_exited():
	modulate = Color(1,1,1,1)


func _on_ActionStoryButton_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed and not animation_player.is_playing():
			var time_choice_slider = get_tree().get_nodes_in_group("time_choice_slider").front()
			emit_Sound_Effect("res://Sounds/Interface/Button.wav")
			var _button_texture: Resource
			if current_mode == "action":
				_button_texture = preload("res://Textures/Interface/Story Button.png")
				history_label.visible = true
				time_choice_slider.visible = false
				actions.visible = false
				current_mode = "story"
			elif current_mode == "story":
				_button_texture = preload("res://Textures/Interface/Action Button.png")
				history_label.visible = false
				if time_choice_slider.active:
					time_choice_slider.visible = true
				actions.visible = true
				current_mode = "action"
			texture = _button_texture
			
