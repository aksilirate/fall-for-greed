extends Node
class_name ActionLibrary


onready var game_screen: GameScreen = get_tree().get_root().get_node("GameScreen") as GameScreen

onready var animation_player: AnimationPlayer = game_screen.animation_player
onready var characters: Node = game_screen.characters
onready var area: Node = game_screen.area
onready var story: Node = game_screen.get_node("Logic/Story")

signal search_for_item(_action_texture_rect)
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



func emit_story_telling(_main_story):
	upcoming_stories.push_front(_main_story)
	
	animation_player.play("Hide Screen")
	
	yield(animation_player,"animation_finished")
	emit_signal("story_telling_started")
	run_through_upcoming_stories()
	yield(self,"story_telling_finished")
	animation_player.play("Show Screen")
	upcoming_stories.clear()



func add_to_minutes_passed(amount):
	yield(self,"story_telling_started")
	story.minutes_passed += amount
	story.update_time()
	
	
	
func run_through_upcoming_stories():
	for _story in upcoming_stories:
		var story_label = preload("res://Scenes/StoryLabel/StoryLabel.tscn").instance()
		var story_animation_player = story_label.get_node("AnimationPlayer")
		story_label.text = _story.to_lower()
		game_screen.add_child(story_label)
		yield(story_animation_player,"animation_finished")
		story_label.queue_free()
	emit_signal("story_telling_finished")






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
	var _hunger_check = _character.get_hunger_status()
	
	
	_character.stats["hunger"] -= _energy_cost / 3
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
	characters.summon_character(_character.new())
	
	
	
func reset_location():
	yield(self,"story_telling_started")
	emit_signal("location_reseted")



func emit_location_advanced():
	yield(self,"story_telling_started")
	emit_signal("location_advanced")




#--------------------------------------- [ v SLEEP v ] ----------------------------------------

func sleep():
	var execute_sleep
	if executer is Object:
		execute_sleep = execute_sleep(executer)
	else:
		for _character in executer:
			execute_sleep = execute_sleep(_character)
	yield(execute_sleep, "completed")

func execute_sleep(_character):
	var emit_story_telling
	if _character.stats["energy"] < 0.5:
		emit_story_telling = emit_story_telling("you have slept for " + str(round(calculate_sleep_time())) + " hours")
			
		yield(self,"story_telling_started")
		if area.current_event.get_class() == "CampfireEvent":
			_character.stats["energy"] = 1.0
		else:
			_character.stats["energy"] = 1.0
		add_to_minutes_passed(round(calculate_sleep_time() * 60))
	else:
		emit_story_telling = emit_story_telling("you don't want to sleep yet")
		
	yield(emit_story_telling, "completed")
	
	
	
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
	emit_signal("search_for_item", self)
	var emit_story_telling
	var finding_name = area.current_event.NAME
	randomize()
	if area.findings_left > 0 and round(rand_range(0,1)) == OK:
		var _main_story = "you have searched for " + str(_minutes_passed) + " minutes"
		upcoming_stories.push_back("you have found " + str(finding_name))
		emit_story_telling = emit_story_telling(_main_story)
	else:
		var _main_story = "you have searched for " + str(_minutes_passed) + " minutes"
		upcoming_stories.push_back("you have not found anything")
		reset_location()
		emit_story_telling = emit_story_telling(_main_story)
		
	if area.findings_left > 0:
		area.findings_left -= 1
	
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






func eat():
	var _character = game_screen.last_selected_character
	var _selected_item = game_screen.selected.item
	_character.stats["hunger"] += _selected_item.CALORIES
	
	if _selected_item.effect:
		_character.add_effect(_selected_item.effect)



func _exit_tree():
	game_screen.save()


