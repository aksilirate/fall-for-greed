extends CheckBox





func _ready():
	if OS.window_fullscreen:
		pressed = true



func _on_FullscreenCheckBox_toggled(button_pressed):
	var OptionsConfigFile = OptionsFile.new()
	if button_pressed:
		OS.window_fullscreen = true
		OptionsConfigFile.save_Option("fullscreen", true)
	else:
		OS.window_fullscreen = false
		OptionsConfigFile.save_Option("fullscreen", false)
