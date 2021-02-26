extends VBoxContainer



func _on_character_selected(_owner):
	for _child in get_children():
		_child.queue_free()
		
	display_threats()
		
		
func add_threat(_name):
	var threat = Label.new()
	threat.align = Label.ALIGN_CENTER
	threat.text = _name
	add_child(threat)

func display_threats():

	if owner.last_selected_character.stats["hunger"] < 0.2:
		add_threat("starving")
	elif owner.last_selected_character.stats["hunger"] < 0.4:
		add_threat("famished")
	elif owner.last_selected_character.stats["hunger"] < 0.6:
		add_threat("hungry")
	
 
