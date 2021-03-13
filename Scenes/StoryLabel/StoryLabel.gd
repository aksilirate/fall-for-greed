extends Label



func _ready():
	$AnimationPlayer.play("Show Label")



func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if $AnimationPlayer.get_current_animation_position() <= 2.5:
				$AnimationPlayer.seek(2.5, true)
			
