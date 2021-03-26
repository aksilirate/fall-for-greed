extends VBoxContainer


onready var game_screen = get_parent()

func _on_character_selected():
	for _child in get_children():
		_child.queue_free()
		
	display_threats()
		
		
func add_threat(_name):
	var threat = Label.new()
	threat.align = Label.ALIGN_CENTER
	threat.text = _name
	add_child(threat)

func display_threats():
	
	
	var hunger_status = game_screen.last_selected_character.get_hunger_status()
	var energy_status = game_screen.last_selected_character.get_energy_status()
	var melatonin_status = game_screen.last_selected_character.get_melatonin_status()
	
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

	if energy_status:
		add_threat(energy_status)
	
	if melatonin_status:
		add_threat(melatonin_status)

	for _active_effect in owner.last_selected_character.active_effects:
		add_threat(_active_effect)
