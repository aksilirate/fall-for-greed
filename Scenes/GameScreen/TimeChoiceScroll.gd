extends HSlider




var active := false
func _init():
	visible = false


func _on_TimeChoiceScroll_value_changed(value):
	if value == 1:
		$TimeChoiceLabel.text = "1 minute"
	elif value == 60:
		$TimeChoiceLabel.text = "1 hour"
	else:
		$TimeChoiceLabel.text = str(value) + " minutes"
