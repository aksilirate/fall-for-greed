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
	
	if owner.last_selected_character.stats["mood"] < 0.1:
		add_threat("depressed")
	elif owner.last_selected_character.stats["mood"] < 0.4:
		add_threat("angry")
	elif owner.last_selected_character.stats["mood"] < 0.6:
		add_threat("irritated")
	elif owner.last_selected_character.stats["mood"] < 0.8:
		add_threat("indifferent")
	elif owner.last_selected_character.stats["mood"] < 1.0:
		add_threat("calm")

	if owner.last_selected_character.stats["health"] < 0.1:
		add_threat("dying")
	elif owner.last_selected_character.stats["health"] < 0.5:
		add_threat("injured")
	elif owner.last_selected_character.stats["health"] < 0.8:
		add_threat("wounded")


	if owner.last_selected_character.stats["hunger"] < 0.2:
		add_threat("starving")
	elif owner.last_selected_character.stats["hunger"] < 0.4:
		add_threat("famished")
	elif owner.last_selected_character.stats["hunger"] < 0.6:
		add_threat("hungry")
	
	
	if owner.last_selected_character.stats["energy"] < 0.3:
		add_threat("sleepy")
	elif owner.last_selected_character.stats["energy"] < 0.5:
		add_threat("tired")
