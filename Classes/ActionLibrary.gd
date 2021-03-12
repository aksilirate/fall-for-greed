extends Node
class_name ActionLibrary


onready var game_screen: GameScreen = get_tree().get_root().get_node("GameScreen") as GameScreen

onready var animation_player: AnimationPlayer = game_screen.animation_player
onready var story: Node = game_screen.get_node("Logic/Story")
onready var area: Node = game_screen.area

signal search_for_item(_action_texture_rect)
signal summon_character(_character)
signal kill_character(_character)
signal story_telling_started
signal story_telling_finished
signal location_advanced
signal location_reseted


var character_passed_out = false
var upcoming_stories = []
var action: Object
var executer


func _ready():
# warning-ignore:return_value_discarded
	connect("kill_character", game_screen, "_on_character_death")
# warning-ignore:return_value_discarded
	connect("summon_character", game_screen, "_on_summon_character")
# warning-ignore:return_value_discarded
	connect("location_advanced", area, "_on_location_advanced")
# warning-ignore:return_value_discarded
	connect("location_reseted", area , "_on_location_reseted")
# warning-ignore:return_value_discarded
	connect("search_for_item", area, "_on_search_for_item")
# warning-ignore:return_value_discarded
	connect("story_telling_started", area, "_on_story_selected")
# warning-ignore:return_value_discarded
	
	
	
	
func change_event_to(_event: Object):
	yield(self,"story_telling_started")
	area.change_event_to(_event.new())



func add_to_minutes_passed(amount):
	story.minutes_passed += amount
	story.update_time()
	
#----------------------------------- [ v STORY v ] ---------------------------------
	
var show_screen_disabled := false
func emit_story_telling(_main_story):
	upcoming_stories.push_front(_main_story)
	
	animation_player.play("Hide Screen")
	
	yield(animation_player,"animation_finished")
	emit_signal("story_telling_started")
	run_through_upcoming_stories()
	yield(self,"story_telling_finished")
	if not show_screen_disabled:
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
	yield(story_animation_player,"animation_finished")
	story_label.queue_free()
	
#----------------------------------- [ ^ STORY ^ ] ---------------------------------



#------------------------------- [ v CALCULATIONS v ] ----------------------------------

func calculate_turn(_energy_cost, _minutes_passed):
	yield(self,"story_telling_started")

	add_to_minutes_passed(_minutes_passed)
	
	
	if executer is Object:
		calculate_character_turn(executer, _energy_cost, _minutes_passed)
	else:
		for _character in executer:
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
	calculate_mood(_character, _minutes_passed)
	calculate_misfortune(_character)
	var _hunger_check = _character.get_hunger_status()
	
	var _health_gained = _minutes_passed * 0.00006
	_character.stats["health"] += _health_gained
	if _character.stats["health"] > 1.0:
		_character.stats["health"] = 1.0
	_character.stats["hunger"] -= (_energy_cost / 3) + _health_gained
	_character.stats["energy"] -= _energy_cost
	
	
	if _hunger_check != _character.get_hunger_status():
		var _updated_hunger_check = _character.get_hunger_status()
		upcoming_stories.push_back(_character.character_name + " is " + _updated_hunger_check)
	
	
	if _character.stats["energy"] <= 0:
		upcoming_stories.push_back(_character.character_name + " has fallen asleep")
		pass_out()
		_character.stats["energy"] = 1.0
		
	if _character.stats["health"] <= 0 or _character.stats["hunger"] <= 0:
		upcoming_stories.push_back(_character.character_name + " have died")
		yield(self,"story_telling_finished")
		emit_signal("kill_character", _character)
		
	elif _character.stats["mood"] <= 0:
		upcoming_stories.push_back(_character.character_name + " have killed himself")
		yield(self,"story_telling_finished")
		emit_signal("kill_character", _character)
	
	
func calculate_mood(_character, _minutes_passed):
	if _character.stats["health"] <= 0.5:
		_character.stats["mood"] -= ((1 - _character.stats["health"]) / 300) * _minutes_passed
	if _character.stats["hunger"] <= 0.5:
		_character.stats["mood"] -= ((1 - _character.stats["health"]) / 430) * _minutes_passed


func calculate_misfortune(_character):
	if area.current_event is load("res://Areas/AbandonedForest/AbandonedForest.gd") as Script:
		if _character.stats.misfortune > rand_range(0,1):
			upcoming_stories.push_back(_character.character_name + " has stepped on a thorn by accident")
			var _effect = Effect.new()
			var _bleed = Bleed.new()
			randomize()
			_bleed.deactivation_minute = round(rand_range(3,6))
			_effect.active_effect = _bleed
			_character.add_child(_effect)

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

	
func reset_location():
	yield(self,"story_telling_started")
	emit_signal("location_reseted")



func emit_location_advanced():
	yield(self,"story_telling_started")
	emit_signal("location_advanced")
	var next_location = area.upcoming_locations[area.locations_passed - 1]
	if next_location is Enemy:
		if rand_range(0,1) < 0.37:
			upcoming_stories.push_back("you think you saw something")
	else:
		if rand_range(0,1) < 0.01:
			upcoming_stories.push_back("you think you saw something")


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
	

var sleep_story_shown = false
func execute_sleep(_character):
	var emit_story_telling
	if _character.stats["energy"] < 0.5:
		if not sleep_story_shown:
			emit_story_telling = emit_story_telling("you have slept for " + str(round(calculate_sleep_time())) + " hours")
			yield(self,"story_telling_started")
			
		if area.current_event.get_class() == "CampfireEvent":
			_character.stats["energy"] = 1.0
		else:
			_character.stats["energy"] = 1.0
			
		if not sleep_story_shown:
			add_to_minutes_passed(round(calculate_sleep_time() * 60))
	else:
		if not sleep_story_shown:
			emit_story_telling = emit_story_telling("you don't want to sleep yet")
			
	if not sleep_story_shown:
		yield(emit_story_telling, "completed")
		sleep_story_shown = true
	
func calculate_sleep_time():
	var _character_with_lowest_energy
	
	if executer is Object:
		_character_with_lowest_energy = executer
	else:
		for _character in executer:
			if not _character_with_lowest_energy:
				 _character_with_lowest_energy = _character
			elif _character.stats["energy"] < _character_with_lowest_energy.stats["energy"]:
				_character_with_lowest_energy = _character
				
				
	randomize()
	
	var energy_regain: float
	if _character_with_lowest_energy.stats["energy"] < 0.1:
		energy_regain = rand_range(0.09,0.1)
	else:
		energy_regain = rand_range(0.1,0.125)
		
	var _hours_passed = (1.0 - _character_with_lowest_energy.stats["energy"]) / energy_regain
	
	return _hours_passed
	

func pass_out():
	if not character_passed_out:
		character_passed_out = true
		upcoming_stories.push_back(str(round(calculate_sleep_time())) + " hours have passed")
		add_to_minutes_passed(round(calculate_sleep_time() * 60))

#----------------------------------------- [ ^ SLEEP ^ ] -----------------------------------------







func search_for_item(_minutes_passed):
	var emit_story_telling
	var finding_name
	if area.current_area.FINDINGS.size() != 0:
		emit_signal("search_for_item", self)
		finding_name = area.current_event.NAME
	else:
		finding_name = null
		
	randomize()
	
	var _main_story
	if _minutes_passed == 1:
		_main_story = "you have searched for 1 minute"
	else:
		_main_story = "you have searched for " + str(_minutes_passed) + " minutes"
		
	if area.findings_left > 0 and rand_range(0,1) < _minutes_passed*0.0166 and finding_name:
		upcoming_stories.push_back("you have found " + str(finding_name))
		emit_story_telling = emit_story_telling(_main_story)
	else:
		upcoming_stories.push_back("you have not found anything")
		reset_location()
		emit_story_telling = emit_story_telling(_main_story)
		
	if area.findings_left > 0:
		area.findings_left -= 1
		
	yield(self,"story_telling_started")
	add_to_minutes_passed(_minutes_passed)
	yield(emit_story_telling, "completed")
	
	
func emit_take_item():
	var emit_story_telling
	var _main_story: String
	var item: Object
	
	if area.current_event != null and area.current_event.get("ITEM"):
		item = area.current_event.ITEM.new()
		_main_story = "you have acquired " + str(item.NAME)
		emit_story_telling = emit_story_telling(_main_story)
		executer.inventory.append(item)
	else: # <------- if holding an Item
		item = game_screen.hold_slot.selected_item
		game_screen.hold_slot.selected_item = null
		game_screen.hold_slot._on_item_hold(null)
		game_screen.last_selected_character.update_actions(game_screen)
		
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
	shell_scene.enemy = area.current_event
	game_screen.add_child(shell_scene)



func run():
	var _run_chance = clamp(4 - area.current_event.SPEED, 0, 4)
	var emit_story_telling
	
	randomize()
	if rand_range(0,10) < _run_chance:
		emit_story_telling = emit_story_telling("you have ran away")
		emit_location_advanced()
		yield(emit_story_telling,"completed")
		queue_free()
	else:
		emit_story_telling("you could not run away")
		show_screen_disabled = true
		yield(self,"story_telling_finished")
		var shell_scene = load("res://Scenes/ShellsScene/ShellsScene.tscn").instance()
		shell_scene.enemy = area.current_event
		shell_scene.auto_lose = true
		game_screen.add_child(shell_scene)
		queue_free()



func eat():
	var _character = game_screen.last_selected_character
	var _selected_item = game_screen.selected.item
	_character.stats["hunger"] += _selected_item.CALORIES
	
	if _selected_item.get("effect") and _selected_item.effect:
		_character.add_effect(_selected_item.effect)

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
	if area.current_event.NEXT_AREA.get("NAME"):
		_main_story = "you have entered " + area.current_event.NEXT_AREA.NAME
	else:
		_main_story = "you have exited " + area.current_event.NAME
		
	emit_story_telling(_main_story)
	yield(self,"story_telling_started")
	area.current_area = area.current_event.NEXT_AREA.new()
	area.current_event = area.current_area
	area.generate_locations()
	area.update_story_info()
	area.update_actions()
	yield(self,"story_telling_finished")
