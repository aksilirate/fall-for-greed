extends TextureRectButton


func _ready():
	mouse_filter = MOUSE_FILTER_STOP


func _on_DeckTexture_pressed():
	Sound.emit_sound_effect("res://Sounds/Game/Card Draw.wav")




func _on_DeckTexture_mouse_entered():
	$Tween.stop_all()
	var current_volume = $HoverSound.volume_db
	$Tween.interpolate_property($HoverSound, "volume_db", current_volume, 11, 1.0, Tween.TRANS_LINEAR)
	$Tween.start()


func _on_DeckTexture_mouse_exited():
	$Tween.stop_all()
	var current_volume = $HoverSound.volume_db
	$Tween.interpolate_property($HoverSound, "volume_db", current_volume, -80, 6.0, Tween.TRANS_LINEAR)
	$Tween.start()


func _on_AnimationPlayer_animation_started(_anim_name):
	$Tween.stop_all()
	var current_volume = $HoverSound.volume_db
	$Tween.interpolate_property($HoverSound, "volume_db", current_volume, -80, 3.0, Tween.TRANS_LINEAR)
	$Tween.start()
