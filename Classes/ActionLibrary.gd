extends Node
class_name ActionLibrary


onready var game_screen = get_tree().get_root().get_node("GameScreen")

onready var animation_player: AnimationPlayer = game_screen.animation_player
onready var area: Node = game_screen.area

signal ready_to_advance(_minutes_passed)
signal summon_character(_character)
signal kill_character(_character)
signal story_telling_started
signal story_telling_finished
signal location_reseted

var tarot_prophecy_ready := false
var upcoming_stories = []
var action: Object
var executer



func _ready():
# warning-ignore:return_value_discarded
	connect("kill_character", game_screen, "_on_character_death")
# warning-ignore:return_value_discarded
	connect("summon_character", game_screen, "_on_summon_character")
# warning-ignore:return_value_discarded
	connect("location_reseted", area , "_on_location_reseted")
# warning-ignore:return_value_discarded
	connect("story_telling_started", area, "_on_story_selected")
# warning-ignore:return_value_discarded
	
	
	
	
func change_event_to(_event: Object):
	yield(self,"story_telling_started")
	area.change_event_to(_event.new())



func add_to_minutes_passed(amount):
	if Time.get_formatted_time("day", Game.minutes_passed + amount) > Time.get_formatted_time("day", Game.minutes_passed):
		tarot_prophecy_ready = true
		
	Game.minutes_passed += amount
	for _character in get_tree().get_nodes_in_group("characters"):
		for _key in _character.action_cooldowns:
			_character.action_cooldowns[_key] -= amount
			_character.action_cooldowns[_key] = max(0, _character.action_cooldowns[_key])
	
#----------------------------------- [ v STORY v ] ---------------------------------
	
var hide_screen := true
var show_screen := true
func emit_story_telling(_main_story):
	upcoming_stories.push_front(_main_story)
	
	if hide_screen:
		animation_player.play("Hide Screen")
		yield(animation_player,"animation_finished")
		
	emit_signal("story_telling_started")
	run_through_upcoming_stories()
	yield(self,"story_telling_finished")
	area.update_actions()
	
	if tarot_prophecy_ready:
		game_screen.load_card_picking_scene()
		tarot_prophecy_ready = false
	elif show_screen:
		animation_player.play("Show Screen")
		
		
		
		
	upcoming_stories.clear()


func run_through_upcoming_stories():
	for _story in upcoming_stories:
		var show_story_label = show_story_label(_story)
		yield(show_story_label, "completed")
		
	for _character in get_tree().get_nodes_in_group("characters"):
#		var _character: Character = _node
		if _character.upcoming_stories.size() > 0:
			for _story in _character.upcoming_stories:
				var show_story_label = show_story_label(_story)
				yield(show_story_label, "completed")
				_character.upcoming_stories.erase(_story)
				
	emit_signal("story_telling_finished")


func show_story_label(_story):
	var story_label = preload("res://Scenes/StoryLabel/StoryLabel.tscn").instance()
	var story_animation_player = story_label.get_node("AnimationPlayer")
	story_label.text = _story.to_lower()
	game_screen.add_child(story_label)
	Audio.emit_sound_effect("res://Sounds/Interface/Echo Hit.wav")
	yield(story_animation_player,"animation_finished")
	story_label.queue_free()

#----------------------------------- [ ^ STORY ^ ] ---------------------------------


#----------------------------------- [ v ISSUES v ] ---------------------------------

func stamina_issue():
	for _character in get_tree().get_nodes_in_group("characters"):
		if _character.stats["energy"] < 0.3:
			return _character.character_name + " too exhausted"
				
	return false

#----------------------------------- [ ^ ISSUES ^ ] ---------------------------------


#------------------------------- [ v CALCULATIONS v ] ----------------------------------

func calculate_turn(_energy_cost, _minutes_passed):
	yield(self,"story_telling_started")

	add_to_minutes_passed(_minutes_passed)
	
	
	if executer is Object:
		calculate_character_turn(executer, _energy_cost, _minutes_passed)
	else:
		for _character in executer:
			if _character:
				calculate_character_turn(_character, _energy_cost, _minutes_passed)
			



func calculate_character_effects(_character, _minutes_passed):
	for _child in _character.get_children():
		if _child.is_in_group("Effect"):
			var _effect: Effect = _child
			_effect.active_minutes += _minutes_passed
			var _result = _effect.apply_effect(_minutes_passed)
			if _result:
				upcoming_stories.push_back(_character.character_name + _result)


func calculate_character_turn(_character, _energy_cost, _minutes_passed):
	calculate_character_effects(_character, _minutes_passed)
	calculate_loneliness(_character, _minutes_passed)
	calculate_melatonin(_character, _minutes_passed)
	calculate_mood(_character, _minutes_passed)
	calculate_luck(_character, _minutes_passed)
	
	
	var _mood_check = _character.get_mood_status()
	var _hunger_check = _character.get_hunger_status()
	var _energy_check = _character.get_energy_status()
	
	var _health_gained = _minutes_passed * 0.00006
	_character.stats["health"] += _health_gained
	if _character.stats["health"] > 1.0:
		_character.stats["health"] = 1.0
		

	if Game.equipped_artifact != null and Game.equipped_artifact.get("ANTI_HUNGER"):
		_character.stats["hunger"] = max(1.0, _character.stats["hunger"])
	else:
		_character.stats["hunger"] -= (_energy_cost / 3.5) + _health_gained
		
	_character.stats["energy"] -= _energy_cost
	
	
	if _mood_check != _character.get_mood_status():
		var _updated_mood_check = _character.get_mood_status()
		upcoming_stories.push_back(_character.character_name + " is " + _updated_mood_check)
	
	if _hunger_check != _character.get_hunger_status():
		var _updated_hunger_check = _character.get_hunger_status()
		upcoming_stories.push_back(_character.character_name + " is " + _updated_hunger_check)

	if _energy_check != _character.get_energy_status():
		if _character.stats["energy"] < 0.5 and rand_range(0,1) < 0.5:
			rest(_character, round(rand_range(3,5)))
		else:
			var _updated_energy_check = _character.get_energy_status()
			upcoming_stories.push_back(_character.character_name + " is " + _updated_energy_check)
			
	if _character.hormones["melatonin"] >= 1.5:
		upcoming_stories.push_back(_character.character_name + " has passed out")
		pass_out(_character)
		_character.hormones["melatonin"] = 0.0
		_character.stats["mood"] -= 0.173
	
	
	
	if ate_food(_character):
		print("character have eaten on it's own")
	
	if died(_character):
		emit_signal("kill_character", _character)
		print("character have died")
	

	
func died(_character):
	if _character.stats["health"] <= 0 or _character.stats["hunger"] <= 0:
		upcoming_stories.push_back(_character.character_name + " have died")
		yield(self,"story_telling_finished")
		return true
		
	elif _character.stats["mood"] <= 0:
		upcoming_stories.push_back(_character.character_name + " have killed himself")
		yield(self,"story_telling_finished")
		return true
		
	else:
		return false
	
	
func ate_food(_character):
	if _character.get_hunger_status():
		for _item in _character.inventory:
			var calories = _item.get("CALORIES")
			if calories and calories >= 0.1:
				if rand_range(0,1) < 0.08:
					eat(_character, _item)
					upcoming_stories.push_back(_character.character_name + " have eaten " + _item.NAME)
					if _item.CALORIES < 0.1:
						upcoming_stories.push_back(_character.character_name + " did not like the taste")
					
					_character.inventory.erase(_item)
					return true
	
	return false
	
	
func calculate_mood(_character, _minutes_passed):
	var _tarot_mood = Game.selected_tarot_card.get("MOOD")
	if _tarot_mood:
		_character.stats["mood"] += _tarot_mood
		_character.stats["mood"] = min(_character.stats["mood"], 1.5)
		
	if _character.stats["health"] <= 0.5:
		_character.stats["mood"] -= ((1 - _character.stats["health"]) / 718) * _minutes_passed
	if _character.stats["hunger"] <= 0.5:
		_character.stats["mood"] -= ((1 - _character.stats["health"]) / 821) * _minutes_passed
	if _character.hormones["melatonin"] > 0.9:
		_character.stats["mood"] -= (_character.hormones["melatonin"] * _minutes_passed) * 0.0003666
	
	if _character.stats["mood"] < 0.23:
		if rand_range(0,1) < 0.074:
			if rand_range(0,1) < 0.5:
				upcoming_stories.push_back(_character.character_name + " is having suicidal thoughts")
			else:
				upcoming_stories.push_back(_character.character_name + " wants to end it all")




func calculate_loneliness(_character, _minutes_passed):
	if _character.stats["loneliness"] < 0:
		_character.stats["loneliness"] = 0
	
	if _character.stats["loneliness"] <= 0.5:
		_character.stats["mood"] -= _character.stats["loneliness"] / 18.3
		if _character.stats["loneliness"] <= 0.3:
			if rand_range(0,1) < 0.076:
				upcoming_stories.push_back(_character.character_name + " is talking to himself")
	
	if get_tree().get_nodes_in_group("characters").size() > 1:
		_character.stats["loneliness"] = 1.0
	else:
		_character.stats["loneliness"] -= _minutes_passed / 1056
		



func calculate_melatonin(_character, _minutes_passed):
	var _melatonin_check = _character.get_melatonin_status()
	var hour = Time.get_formatted_time("hour", Game.minutes_passed)
	_character.hormones["melatonin"] += (0.00011277497 * _minutes_passed) * hour
	if _melatonin_check != _character.get_melatonin_status():
		var _updated_melatonin_check = _character.get_melatonin_status()
		upcoming_stories.push_back(_character.character_name + " is " + _updated_melatonin_check)


func calculate_luck(_character, _minutes_passed):
	var _total_luck: float
	var _tarot_luck = Game.selected_tarot_card.get("LUCK")
	if _tarot_luck:
		_total_luck = _character.stats["luck"] + _tarot_luck
	else:
		_total_luck = _character.stats["luck"]
		
	if Game.current_event is load("res://Areas/AbandonedForest/AbandonedForest.gd") as Script:
		if _character.stats["armor"] < 0.3:
			if _total_luck <= -0.3:
				if rand_range(0,5) < min( 1.0 / (_character.mistakes.count("step on thorn") + 1), 1.0):
					upcoming_stories.push_back(_character.character_name + " has stepped on a thorn by accident")
					var _effect = Effect.new()
					var _bleed = Bleed.new()
					randomize()
					_bleed.deactivation_minute = round(rand_range(3,6))
					_effect.active_effect = _bleed
					_character.add_child(_effect)
					_character.mistakes.append("step on thorn")

		if _total_luck <= -10.0:
			if rand_range(0,1) < 0.084:
				upcoming_stories.push_back( "a tree has fallen on " + _character.character_name)
				upcoming_stories.push_back(_character.character_name + " have died")
				kill_character(_character)
				
	elif Game.current_event is load("res://Areas/Mountains/Mountains.gd") as Script:
		if _total_luck <= -10.0:
			if rand_range(0,1) < 0.084:
				upcoming_stories.push_back( "a boulder has fallen on " + _character.character_name)
				upcoming_stories.push_back(_character.character_name + " have died")
				kill_character(_character)




	var _missing_items_messages = []
	if _character.inventory:
		
		for _item in _character.inventory:
			randomize()
			for _minute in range(1, _minutes_passed):
				if rand_range(-3000, 0) > max(_total_luck, -0.666):
					_character.inventory.erase(_item)
					var _missing_message: String
					if _item.get("MISSING_MESSAGE"):
						_missing_message = "his " + _item.MISSING_MESSAGE
					else:
						_missing_message = "his " + _item.TOOLTIP + " is missing"
						
					if not _missing_items_messages.has(_missing_message):
						_missing_items_messages.append(_missing_message)
	
	if _missing_items_messages:
		upcoming_stories.push_back(_character.character_name + " has noticed something")
		for _message in _missing_items_messages:
			upcoming_stories.push_back(_message)
				
	
#------------------------------ [ ^ CALCULATIONS ^ ] ---------------------------------



func destroy_item_after_story():
	var _selected_item_cache = game_screen.selected
	yield(self,"story_telling_started")
	_selected_item_cache.destroy_item()

func hold_selected_item():
	# Removes item from an inventory, method found inside a child under the Inventory node (...Slot)
	game_screen.selected.hold_item()



func summon_character(_character):
	yield(self,"story_telling_started")
	emit_signal("summon_character", _character.new())


func kill_character(_character):
	yield(self,"story_telling_finished")
	upcoming_stories.push_back(_character.character_name + " have died")
	var _death_index = upcoming_stories.find(_character.character_name + " have died")
	for _story in upcoming_stories:
		if upcoming_stories.find(_story) > _death_index:
			upcoming_stories.erase(_story)
	emit_signal("kill_character", _character)

	
func reset_location():
	yield(self,"story_telling_started")
	emit_signal("location_reseted")


func acquire_random_artifact():
	var random_artifact = Artifacts.get_random_artifact()
	emit_story_telling("you have accepted the offer and acquired" + random_artifact.NAME)
	yield(self,"story_telling_started")
	Game.equipped_artifact = random_artifact.new()
	for _character in get_tree().get_nodes_in_group("characters"):
		_character.stats["health"] = _character.stats["health"] / 2
	yield(self,"story_telling_finished")
	queue_free()

func break_artifact():
	emit_story_telling("you have broken the artifact")
	yield(self,"story_telling_started")
	Game.equipped_artifact = null
	yield(self,"story_telling_finished")
	queue_free()


func emit_location_advanced():
	randomize()
	var locations_to_advance = 1
	
	var _minutes_passed = floor(rand_range(13,34 - calculate_speed()))
	
	
	for _i in range(6):
		if Game.location_index + locations_to_advance < Game.upcoming_locations.size():
			var next_location = Game.upcoming_locations[Game.location_index + locations_to_advance]
			if next_location.get_script() == Game.current_area.get_script():
				locations_to_advance += 1
				randomize()
				_minutes_passed += floor(rand_range(13,34 - calculate_speed()))
				if rand_range(0,1) < 0.192:
					break
					
		
	var skipped_next_location_index = Game.location_index + locations_to_advance
	if skipped_next_location_index < Game.upcoming_locations.size():
		var skipped_next_location = Game.upcoming_locations[skipped_next_location_index]

		if skipped_next_location.get_script() != Game.current_area.get_script():
			if rand_range(0,1) < 0.01:
				upcoming_stories.push_back("you think you saw something")
			
	
	var new_next_location_index = Game.location_index + locations_to_advance + 1
	if new_next_location_index < Game.upcoming_locations.size():
		var new_next_location = Game.upcoming_locations[new_next_location_index]
		if new_next_location is Enemy:
			if rand_range(0,1) < 0.37:
				upcoming_stories.push_back("you think you saw something")
	
	
#	Used for the WalkAction.gd
	emit_signal("ready_to_advance", _minutes_passed)
	yield(self,"story_telling_started")
	
	while locations_to_advance > 0:
		area.advance_location()
		locations_to_advance -= 1
	
	
func calculate_speed():
	var _total_speed := 0.0
	for _character in get_tree().get_nodes_in_group("characters"):
		_total_speed -= 3 - (min(1.0, _character.stats["hunger"])*3)
		_total_speed -= 3 - (min(1.0, _character.stats["health"])*3)
			
	return _total_speed
#--------------------------------------- [ v SLEEP v ] ----------------------------------------

func sleep():
	var execute_sleep
	if executer is Object:
		execute_sleep = execute_sleep(executer)
		yield(execute_sleep, "completed")
	else:
		for _character in executer:
			execute_sleep = execute_sleep(_character)
			if execute_sleep is Object:
				yield(execute_sleep, "completed")
				
		if not sleep_story_shown:
			var emit_story_telling = emit_story_telling("you don't want to sleep yet")
			yield(emit_story_telling, "completed")

var sleep_story_shown = false
func execute_sleep(_character):
	var emit_story_telling
	if _character.hormones["melatonin"] > 0.83:
		calculate_sleep_hazzards(_character)
		if not sleep_story_shown:
			var calculated_sleep_time = round(calculate_sleep_time())
			emit_story_telling = emit_story_telling("you have slept for " + str(calculated_sleep_time) + " hours")
			yield(self,"story_telling_started")
			add_to_minutes_passed(round(calculated_sleep_time * 60))
			
	if Game.current_event.get_class() == "CampfireEvent":
		_character.hormones["melatonin"] = 0.0
		_character.stats["energy"] = 1.0
	else:
		_character.hormones["melatonin"] = 0.024
		_character.stats["energy"] = 0.8
			
			

			
	if not sleep_story_shown and emit_story_telling:
		yield(emit_story_telling, "completed")
		sleep_story_shown = true


func calculate_sleep_hazzards(_character):
	had_nightmare(_character)
	if not Game.current_event.get_class() == "CampfireEvent":
		if Game.current_area.get("MOSQUITOES"):
			if rand_range(0,1) < 0.678:
				_character.stats["mood"] -= 0.05
				upcoming_stories.push_back(_character.character_name + " has been bitten by mosquitoes")
				var _effect = Effect.new()
				var _mosquito_bite = MosquitoBite.new()
				randomize()
				_mosquito_bite.deactivation_minute = round(rand_range(720,856))
				_effect.active_effect = _mosquito_bite
				_character.add_child(_effect)


func calculate_sleep_time():
	var _character_with_highest_melotonin
	
	if executer is Object:
		_character_with_highest_melotonin = executer
	else:
		for _character in executer:
			if not _character_with_highest_melotonin:
				 _character_with_highest_melotonin = _character
			elif _character.hormones["melatonin"] > _character_with_highest_melotonin.hormones["melatonin"]:
				_character_with_highest_melotonin = _character
				
	randomize()
	
	var melatonin_loss: float
	if _character_with_highest_melotonin.hormones["melatonin"] > 0.9:
		melatonin_loss = rand_range(0.09,0.1)
	else:
		melatonin_loss = rand_range(0.0833,0.0793)
		
	var _hours_passed = _character_with_highest_melotonin.hormones["melatonin"] / melatonin_loss
	
	return _hours_passed



func pass_out(_character):
		upcoming_stories.push_back(str(round(calculate_sleep_time())) + " hours have passed")
		add_to_minutes_passed(round(calculate_sleep_time() * 60))



func had_nightmare(_character):
	if _character.stats["energy"] < 0.5:
		if rand_range(0,1) < 0.09:
			_character.stats["mood"] -= 0.05
			upcoming_stories.push_back(_character.character_name + " had a nightmare")


#----------------------------------------- [ ^ SLEEP ^ ] -----------------------------------------




func improve_focus(_minutes_passed):
	for _character in get_tree().get_nodes_in_group("characters"):
		var _old_focus_level = _character.traits["focus"]
		_character.traits["focus"] += _minutes_passed * rand_range(0.0001, 0.00097)
		if floor(_character.traits["focus"] * 10) > floor(_old_focus_level * 10):
			upcoming_stories.push_back(_character.character_name + " has improved his focus")
			
		_character.traits["focus"] = clamp(_character.traits["focus"], 0.0, 1.0)

func improve_humor(_character):
	var _old_humor_level = _character.traits["humor"]
	_character.traits["humor"] += rand_range(0.08, 0.17)
	if floor(_character.traits["humor"] * 10) > floor(_old_humor_level * 10):
		upcoming_stories.push_back(_character.character_name + " has improved his humor")
		
	_character.traits["humor"] = clamp(_character.traits["humor"], 0.0, 1.0)



func search_for_item():
	var emit_story_telling
	var _finding
	randomize()

	var _max_focus: float
	for _character in get_tree().get_nodes_in_group("characters"):
		if _max_focus < _character.traits["focus"] / 3:
			_max_focus = _character.traits["focus"] / 3
		
	var _found := false
	var _minutes_passed := 60
	
	var _finding_chance = rand_range(0,1)
	for _minute in range(1,60):
		if Game.findings_left > 0 and _finding_chance < (_minute * 0.01666) + _max_focus and Game.current_area.FINDINGS:
			randomize()
			_finding = Rand.weighted_random_object(Game.current_area.FINDINGS).new()
			var finding_name = _finding.NAME
			
			upcoming_stories.push_back("you have found " + str(finding_name))
			
			
			Game.current_event = _finding
			
			
			_minutes_passed = _minute
			
			if Game.findings_left > 0:
				Game.findings_left -= 1
				
			_found = true
			break
		
		
	if not _found:
		upcoming_stories.push_back("you have not found anything")
		reset_location()
		if rand_range(0,1) < 0.1 and _minutes_passed >= 13:
			emit_location_advanced()
			
	
	var _main_story
	if _minutes_passed == 1:
		_main_story = "you have searched for 1 minute"
	elif _minutes_passed == 60:
		_main_story = "you have searched for 1 hour"
	else:
		_main_story = "you have searched for " + str(_minutes_passed) + " minutes"
	emit_story_telling = emit_story_telling(_main_story)
	
	
	
	var _energy_cost = 0.00096 * _minutes_passed
	calculate_turn(_energy_cost, _minutes_passed)
	
	yield(self,"story_telling_started")
	if _finding:
		area.update_story_info()
		area.update_actions()
				
	add_to_minutes_passed(_minutes_passed)
	improve_focus(_minutes_passed)
	
	
	yield(emit_story_telling, "completed")
	
	
func emit_take_item():
	var emit_story_telling
	var _main_story: String
	var item: Object
	
	if Game.current_event != null and Game.current_event.get("ITEM"):
		item = Game.current_event.ITEM.new()
		_main_story = "you have acquired " + str(item.NAME)
		emit_story_telling = emit_story_telling(_main_story)
		executer.inventory.append(item)
		if Game.current_event is Zone:
			Game.upcoming_locations.remove(Game.location_index)
			Game.current_area.total_locations -= 1
	else: # <------- if holding an Item
		item = game_screen.hold_slot.selected_item
		game_screen.hold_slot.selected_item = null
		game_screen.hold_slot._on_item_hold(null)
		game_screen.last_selected_character.update_actions()
		
		if item != null:
			executer.inventory.append(item)
			
		game_screen.last_selected_character.update_inventory()


	
	if emit_story_telling:
		yield(emit_story_telling, "completed")
		queue_free()
	else:
		queue_free()
	
	
	
	
func start_battle():
	animation_player.play("Hide Screen")
	yield(animation_player,"animation_finished")
	var shell_scene = load("res://Scenes/ShellsScene/ShellsScene.tscn").instance()
	

	if game_screen.hold_slot.selected_item and game_screen.hold_slot.selected_item.get("ANTI_LOSE"):
		shell_scene.get_node(shell_scene.shell_game).anti_lose = true
		game_screen.hold_slot.selected_item = null
		for _child in game_screen.hold_slot.get_children():
			_child.queue_free()
		
	if Game.equipped_artifact != null and Game.equipped_artifact.get("LOSE_FIRST_ROUND"):
		shell_scene.auto_lose = true
		
	shell_scene.enemy = Game.current_event
	game_screen.add_child(shell_scene)



func run():
	var emit_story_telling
	randomize()
	if rand_range(0, Game.current_event.SPEED) < lowest_energy() and not Game.current_event.get("INESCAPABLE"):
		emit_story_telling = emit_story_telling("you have ran away")
		emit_location_advanced()
		yield(emit_story_telling,"completed")
		queue_free()
	else:
		emit_story_telling("you could not run away")
		show_screen = false
		yield(self,"story_telling_finished")
		var shell_scene = load("res://Scenes/ShellsScene/ShellsScene.tscn").instance()
		shell_scene.enemy = Game.current_event
		shell_scene.auto_lose = true
		game_screen.add_child(shell_scene)
		queue_free()



func eat(_character, _selected_item):
	_character.stats["hunger"] += _selected_item.CALORIES

#	OVEREATING
	if _character.stats["hunger"] >= 1.5:
		var _effect = Effect.new()
		var _nausea = Nausea.new()
		randomize()
		_nausea.deactivation_minute = round(rand_range(15,30))
		_effect.active_effect = _nausea
		_character.add_child(_effect)
		if _character.stats["hunger"] >= 2.0:
			upcoming_stories.push_back(_character.character_name + " have vomited")
			_character.stats["hunger"] -= 0.3
			_character.stats["mood"] -= 0.1
	
	
	
	_character.stats["mood"] += _selected_item.CALORIES / 2.6
	
	if _selected_item.has_method("on_eat"):
		_selected_item.call("on_eat", _character)
	
	if _selected_item.get("effects") and _selected_item.effects:
		for _effect in _selected_item.effects:
			_character.add_effect(_effect)



func cook():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var _character = game_screen.last_selected_character
	var _selected_item = game_screen.selected.item
	randomize()
	var cook_time = rand.randi_range(_selected_item.MIN_COOK_TIME, _selected_item.MAX_COOK_TIME)
	add_to_minutes_passed(cook_time)
	emit_story_telling("you have cooked " + _selected_item.NAME + " for " + str(cook_time) + " minutes")
	yield(self,"story_telling_finished")
	var _inventory_item_index = _character.inventory.find(_selected_item)
	if _inventory_item_index != -1:
		_character.inventory[_inventory_item_index] = _selected_item.COOKS_INTO


func change_area():
	var _main_story
	if Game.current_event.NEXT_AREA.get("NAME"):
		_main_story = "you have entered " + Game.current_event.NEXT_AREA.NAME
	else:
		_main_story = "you have exited " + Game.current_event.NAME
		
	emit_story_telling(_main_story)
	yield(self,"story_telling_started")
	Game.current_area = Game.current_event.NEXT_AREA.new()
	Game.current_event = Game.current_area
	Game.generate_locations()
	area.update_story_info()
	area.update_actions()
	yield(self,"story_telling_finished")






func follow_path():
	randomize()
	var _hours_passed =  (randi() % 5) +1
	var _minutes_passed = randi() % 60
	var _hours_passed_message: String
	var _mintes_passed_message: String
	
	if _hours_passed == 1:
		_hours_passed_message = str(_hours_passed) + " hour"
	else:
		_hours_passed_message = str(_hours_passed) + " hours"
	
	if not _minutes_passed:
		_mintes_passed_message = ""
	elif _minutes_passed == 1:
		_mintes_passed_message = " and a minute"
	else:
		_mintes_passed_message = " and " + str(_minutes_passed) + " minutes"
		
	upcoming_stories.push_back(_hours_passed_message + _mintes_passed_message + " have passed")
	
	emit_story_telling("you have followed the path")
	
	yield(self,"story_telling_started")
	var _total_minutes_passed = (_hours_passed*60) + _minutes_passed
	Game.current_area = Game.current_event.NEXT_AREA.new()
	Game.current_event = Game.current_area
	calculate_turn(0.00028, _total_minutes_passed)
	
	Game.generate_locations()
	area.update_story_info()
	area.update_actions()
	yield(self,"story_telling_finished")
	
	
	
	
	
func drop_selected_item():
	var _character = game_screen.last_selected_character
	var _selected_item = game_screen.selected.item
	var _item_index = _character.inventory.find(_selected_item)
	_character.inventory.remove(_item_index)
	_character.update_inventory()
	_character.update_actions()
	
	game_screen.selected.modulate.a = 1.0
	get_parent().modulate.a = 1.0
	game_screen.selected = null


func refill_energy(_minutes_passed):
	yield(self,"story_telling_started")
	if executer is Object:
		executer.stats["energy"] += min(1.0,_minutes_passed * 0.1)
	else:
		for _character in executer:
			if _character:
				_character.stats["energy"] += min(1.0,_minutes_passed * 0.1)


func rest(_character, _minutes_passed):
	_character.stats["energy"] += min(1.0,_minutes_passed * 0.1)
	upcoming_stories.push_back(_character.character_name + " have rested for " + str(_minutes_passed) + " minutes")
	add_to_minutes_passed(_minutes_passed)

func heal():
	var _selected_item = game_screen.selected.item
	var _character = game_screen.last_selected_character
	emit_story_telling(game_screen.last_selected_character.character_name + " has healed himself using " + _selected_item.NAME)
	yield(self,"story_telling_started")
	game_screen.last_selected_character.stats["health"] += _selected_item.HEAL_AMOUNT
	if game_screen.last_selected_character.stats["health"] > 0.1:
		game_screen.last_selected_character.stats["health"] = 1.0
		
	var _item_index = _character.inventory.find(_selected_item)
	_character.inventory.remove(_item_index)
	_character.update_inventory()
	_character.update_actions()
	
	yield(self,"story_telling_finished")
	queue_free()
	
	
func joke():
	for _character in get_tree().get_nodes_in_group("characters"):
		if _character != executer:
			if rand_range(0 - executer.traits["humor"], 1 + _character.stats["mood"]) < 0.5:
				upcoming_stories.push_back(_character.character_name + " has laughed")
				_character.stats["mood"] += rand_range(0.06, 0.13)
			else:
				upcoming_stories.push_back(_character.character_name + " did not laugh")
				executer.stats["mood"] -= rand_range(0.06, 0.13)
				improve_humor(executer)
				
	executer.action_cooldowns["JokeAction"] = rand_range(0,60)
	emit_story_telling(executer.character_name + " has told a joke")
	yield(self,"story_telling_finished")
	queue_free()
	
	
func lowest_energy():
	var lowest_energy := 1.0
	for _character in get_tree().get_nodes_in_group("characters"):
		if lowest_energy > _character.stats["energy"]:
			lowest_energy = _character.stats["energy"]
	return lowest_energy
