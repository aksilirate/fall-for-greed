extends Control








func _on_Actions_visibility_changed():
	if visible:
		owner.animation_player.play("Show Actions")
