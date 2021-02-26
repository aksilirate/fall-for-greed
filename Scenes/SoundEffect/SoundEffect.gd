extends AudioStreamPlayer



func _on_SoundEffect_finished():
	queue_free()
