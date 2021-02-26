extends ForgedLabel

var OptionsFile = preload("res://Clusters/OptionsFile.gd").new()

onready var animation_player = get_node("../AnimationPlayer")


func _ready():
	var directory = Directory.new();
	if directory.file_exists(PathDictionary.SAVE_PATH):
		text = "Continue"
	else:
		text = "New Game"



func _on_PlayLabel_mouse_entered():
	if not animation_player.is_playing():
		emit_Mouse_Entered_Effect()
	
func _on_PlayLabel_mouse_exited():
	modulate.a = 1



func _on_PlayLabel_gui_input(event):
	if event is InputEventMouseButton:
		if not event.pressed and not animation_player.is_playing(): 
			emit_Sound_Effect("res://Sounds/Interface/Button.wav")
			animation_player.play("Fade Out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade Out":
		if OptionsFile.get_Option("prologue") == true:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/PrologueScreen/PrologueScreen.tscn")
		else:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/GameScreen/GameScreen.tscn")
			
		get_parent().queue_free()


