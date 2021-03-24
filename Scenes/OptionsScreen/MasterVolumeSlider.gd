extends HSlider




func _ready():
	value = 100 + AudioServer.get_bus_volume_db(0)


func _on_MasterVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value-100)
