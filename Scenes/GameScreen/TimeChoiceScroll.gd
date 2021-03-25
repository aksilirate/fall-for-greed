extends HSlider


var slider_value_memory = {}
var current_action

var active := false
func _init():
	visible = false


func _on_TimeChoiceScroll_value_changed(value):
	if current_action:
		slider_value_memory[current_action] = value
		
	if value == 1:
		$TimeChoiceLabel.text = "1 minute"
	elif value == 60:
		$TimeChoiceLabel.text = "1 hour"
	else:
		$TimeChoiceLabel.text = str(value) + " minutes"

