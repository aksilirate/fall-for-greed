extends CupTextureRect


signal left_cup_selected(_cup)





func _on_CupLeft_pressed():
	emit_signal("left_cup_selected", "Left")
