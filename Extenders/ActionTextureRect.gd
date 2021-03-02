extends ForgedTextureRect
class_name ActionTextureRect

onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")
onready var characters: Node = owner.get_node("Logic/Characters")
onready var area: Node = owner.get_node("Logic/Area")
onready var story: Node = owner.get_node("Logic/Story")

signal search_for_item(_action_texture_rect)
signal story_telling_started
signal story_telling_finished
signal location_advanced
signal location_reseted


var upcoming_stories = []
var action: Object
var executer


func _ready():
# warning-ignore:return_value_discarded
	connect("location_advanced", area, "_on_location_advanced")
# warning-ignore:return_value_discarded
	connect("location_reseted", area , "_on_location_reseted")
# warning-ignore:return_value_discarded
	connect("search_for_item", area, "_on_search_for_item")
# warning-ignore:return_value_discarded
	connect("story_telling_started", area, "_on_story_selected")
	
	
func update_action(_texture, _action, _executer):
	if _action == null:
		visible = false
	else:
# warning-ignore:standalone_expression
		visible == true
	get_child(0).texture = _texture
	action = _action
	executer = _executer



func emit_action_pressed(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			action.init_action(self)



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
		story_label.text = _story
		owner.add_child(story_label)
		yield(story_animation_player,"animation_finished")
		story_label.queue_free()
	emit_signal("story_telling_finished")



func calculate_turn(_energy_cost, _minutes_passed):
	yield(self,"story_telling_started")

	add_to_minutes_passed(_minutes_passed)
	
	if executer is Object:
		executer.stats["hunger"] -= _energy_cost
		executer.stats["energy"] -= _energy_cost
		executer.save_stats()
	else:
		for _character in executer:
			_character.stats["hunger"] -= _energy_cost
			_character.stats["energy"] -= _energy_cost
			_character.save_stats()



func hold_selected_item():
	# Removes item from an inventory, method found inside a child under the Inventory node (...Slot)
	owner.selected.remove_item_from_inventory()
	pass


func reset_location():
	yield(self,"story_telling_started")
	emit_signal("location_reseted")



func emit_location_advanced():
	yield(self,"story_telling_started")
	emit_signal("location_advanced")
	
	
	
func emit_search_for_item(_minutes_passed):
	emit_signal("search_for_item", self)
	var finding_name = area.current_event.ITEM.new().NAME
	
	var _main_story = "you have searched for " + str(_minutes_passed) + " minutes"
	upcoming_stories.append("you have found " + str(finding_name))
	emit_story_telling(_main_story)
	
	
	
	
func emit_take_item():
	var _main_story: String
	var item: Object
	
	if area.current_event != null and area.current_event.get("ITEM"):
		item = area.current_event.ITEM.new()
		_main_story = "you have acquired " + str(item.NAME)
		emit_story_telling(_main_story)
		executer.inventory.append(item)
	else:
		item = owner.hold_slot.selected_item
		owner.hold_slot.selected_item = null
		owner.hold_slot._on_item_selected(null)
		owner.last_selected_character.update_actions(owner)
		if item != null:
			executer.inventory.append(item)
			owner.last_selected_character.update_inventory()
		
	save_inventory(executer)
	
	
	
		
func save_inventory(_character):
	var save_file = SaveFile.new()
	save_file.save_value(_character.NAME, "inventory", _character.inventory)
