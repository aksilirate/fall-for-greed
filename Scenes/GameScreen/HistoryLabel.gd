extends Label








func _on_HistoryLabel_visibility_changed():
		if visible and not owner.animation_player.current_animation == "Load":
			owner.animation_player.play("Show History")
