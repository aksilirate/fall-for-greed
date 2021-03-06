extends CheckBox

var OptionsConfigFile = OptionsFile.new()



func _ready():
	pressed = OptionsConfigFile.get_Option("prologue")

func _on_PrologueCheckBox_toggled(button_pressed):
	if button_pressed:
		OptionsConfigFile.save_Option("prologue", true)
	else:
		OptionsConfigFile.save_Option("prologue", false)
