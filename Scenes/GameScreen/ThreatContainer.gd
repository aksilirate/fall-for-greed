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
	
	
	var hunger_status = owner.last_selected_character.get_hunger_status()
	if hunger_status:
		add_threat(hunger_status)
	
	
	
	if owner.last_selected_character.stats["mood"] < 0.1:
		add_threat("depressed")
	elif owner.last_selected_character.stats["mood"] < 0.4:
		add_threat("angry")
	elif owner.last_selected_character.stats["mood"] < 0.6:
		add_threat("irritated")

	if owner.last_selected_character.stats["health"] < 0.1:
		add_threat("dying")
	elif owner.last_selected_character.stats["health"] < 0.5:
		add_threat("injured")
	elif owner.last_selected_character.stats["health"] < 0.8:
		add_threat("wounded")
	
	
	if owner.last_selected_character.stats["energy"] < 0.3:
		add_threat("sleepy")
	elif owner.last_selected_character.stats["energy"] < 0.5:
		add_threat("tired")
