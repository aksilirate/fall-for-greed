extends Label



func _ready():
	$AnimationPlayer.play("Show Label")



func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$AnimationPlayer.playback_speed = 6
