extends CupTextureRect


signal right_cup_selected(_cup)










func _on_CupRight_pressed():
	emit_signal("right_cup_selected", "Right")
