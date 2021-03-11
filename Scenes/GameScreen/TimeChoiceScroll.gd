extends HScrollBar




var active := false
func _init():
	visible = false


func _on_TimeChoiceScroll_value_changed(value):
	if value == 1:
		$TimeChoiceLabel.text = "1 minute"
	else:
		$TimeChoiceLabel.text = str(value) + " minutes"
