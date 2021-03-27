extends CupTextureRect


signal center_cup_selected(_cup)








func _on_CupCenter_pressed():
	emit_signal("center_cup_selected", "Center")
