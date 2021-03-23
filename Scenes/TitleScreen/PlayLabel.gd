extends LabelButton


onready var animation_player = get_node("../AnimationPlayer")




func _ready():
	var directory = Directory.new();
	if directory.file_exists(PathDictionary.SAVE_PATH):
		text = "Continue"
	else:
		text = "New Game"



func _on_PlayLabel_pressed():
	animation_player.play("Fade Out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade Out":
		var options_file = OptionsFile.new()
		if options_file.get_Option("prologue") == true:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/PrologueScreen/PrologueScreen.tscn")
		else:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/GameScreen/GameScreen.tscn")
			
		get_parent().queue_free()



