extends Control

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var tween = get_node(tween) as Tween
onready var game_screen = get_tree().get_root().get_node("GameScreen")

const ENEMY_ORIGIN = Vector2(168,56)

var action_library = ActionLibrary.new()

var fool: bool
var peek_count: int
var enemy: Object 
var heart_found: bool

signal kill_character(_character)
signal death_message_finished
signal battle_finished



func _ready():
	
# warning-ignore:return_value_discarded
	connect("battle_finished", get_parent(), "_on_battle_finished")
# warning-ignore:return_value_discarded
	connect("kill_character", game_screen, "_on_character_death")
	
	#Setup ActionLibrary
	action_library.hide_screen = false
	action_library.show_screen = false
	add_child(action_library)
	
	if enemy == null:
		enemy = Wolf.new()
		
	$Enemy.texture = load(enemy.UNIT_TEXTURE)
	
	visible = false
	animation_player.play("Load")
	yield(animation_player,"animation_finished")
	if heart_found:
		character_attack()
	else:
		enemy_attack()
	



func character_attack():
	for _character in $CharactersContainer.get_children():
		var _character_origin = _character.rect_position
		var _enemy_position = Vector2(ENEMY_ORIGIN.x, ENEMY_ORIGIN.y + 36) - $CharactersContainer.rect_position
		
		
		if peek_count == 2:
			_character.character_reference.stats["luck"] -= rand_range(0,1.67) * 3
		else:
			_character.character_reference.stats["luck"] -= rand_range(0,1.67) * peek_count
		
		
		
		tween.interpolate_property(_character, "rect_position", _character.rect_position, _enemy_position, 0.3, Tween.TRANS_EXPO)
		tween.start()
		yield(get_tree().create_timer(0.19), "timeout")
		
		
		
		
		var story = get_tree().get_nodes_in_group("story").front()
		var _current_artifact = story.current_artifact
		var _damage = (_character.character_reference.traits["combat"] * 3)
		
		
		if game_screen.selected_tarot_card.get("STRENGTH"):
			_damage += 0.37
		
		if _current_artifact != null and _current_artifact.get("DOUBLE_DAMAGE"):
			_damage = _damage * 2
			

		
			
		enemy.health -= _damage
		hit($Enemy, _damage)
		improve_combat(_character.character_reference)
		
		
		yield(tween,"tween_completed")
		tween.interpolate_property(_character, "rect_position", _character.rect_position, _character_origin, 0.3, Tween.TRANS_EXPO)
		tween.start()
		yield(tween,"tween_completed")
		
		if enemy.health <= 0:
			animation_player.play("Unload")
			yield(animation_player,"animation_finished")
			
			if enemy.get_script() == Witch.new().get_script():
				goal_reached()
				
			play_death_message("you have killed " + enemy.NAME)
			yield(self, "death_message_finished")
			game_screen.animation_player.play("Show Screen")
			
			game_screen.area._on_location_reseted()
			if enemy.has_method("death_curse"):
				enemy.death_curse(game_screen)
			get_parent().queue_free()
			
	complete_battle()





func enemy_attack():
	var _character = pick_random_character()
	var _character_position = _character.get_global_transform_with_canvas().get_origin()
	var _edited_character_position = Vector2(_character_position.x, _character_position.y - 36)
	
	if peek_count == 2:
		_character.character_reference.stats["luck"] -= rand_range(0,1.67) * 3
	else:
		_character.character_reference.stats["luck"] -= rand_range(0,1.67) * peek_count
	
	tween.interpolate_property($Enemy, "rect_position", $Enemy.rect_position, _edited_character_position, 0.3, Tween.TRANS_EXPO)
	tween.start()

	
	
	if dodged(_character.character_reference):
		var _character_origin = _character.rect_position

		tween.interpolate_property(_character, "rect_position", _character.rect_position, _character.rect_position + Vector2(0,23), 0.4, Tween.TRANS_EXPO)
		yield(tween,"tween_all_completed")
		tween.interpolate_property(_character, "rect_position", _character.rect_position, _character_origin, 0.4, Tween.TRANS_EXPO)
		tween.interpolate_property($Enemy, "rect_position", $Enemy.rect_position, ENEMY_ORIGIN, 0.3, Tween.TRANS_EXPO)
		tween.start()
		yield(tween,"tween_completed")
		
	else:
		yield(get_tree().create_timer(0.19), "timeout")
		var _armor = _character.character_reference.stats["armor"]
		var _damage = enemy.DAMAGE
		
		if fool:
			 _damage = _damage/ 1.98
		if game_screen.selected_tarot_card.get("DEATH"):
			_damage = _damage * 2
		
		var _total_damage = max(0.034, _damage - _armor)
		_character.character_reference.stats["health"] -= _total_damage
		
		if enemy.has_method("hit_effect") and _armor < 0.5:
			enemy.call("hit_effect", _character.character_reference)
			
		hit(_character, _total_damage)
		
		tween.interpolate_property($Enemy, "rect_position", $Enemy.rect_position, ENEMY_ORIGIN, 0.3, Tween.TRANS_EXPO)
		tween.start()
	

	
	if _character.character_reference.stats["health"] <= 0:
		animation_player.play("Unload")
		yield(animation_player,"animation_finished")
		var _character_name = _character.character_reference.character_name
		emit_signal("kill_character", _character.character_reference)
		_character.free()
		play_death_message(_character_name + " have died")
		yield(self, "death_message_finished")
		if $CharactersContainer.get_child_count() > 0:
			animation_player.play("Load")
			yield(animation_player,"animation_finished")
			
	complete_battle()
	




func play_death_message(_death_message):
	var emit_story_telling = action_library.emit_story_telling(_death_message)
	yield(emit_story_telling, "completed")
	emit_signal("death_message_finished")
	action_library.queue_free()
	
	
func goal_reached():
	var save_file = SaveFile.new()
	save_file.delete()
# warning-ignore:return_value_discarded
	var death_screen = preload("res://Scenes/DeathScreen/DeathScreen.tscn").instance()
	death_screen.get_node("DeathLabel").text = "you made it"
	get_tree().get_root().add_child(death_screen)
	get_tree().get_root().get_node("GameScreen").queue_free()
	
	
	
func pick_random_character():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	return $CharactersContainer.get_child(rand.randi_range(0, $CharactersContainer.get_child_count()-1))
		
		
func hit(_target, _damage):
	_target.get_material().set_shader_param("enabled", true)
	$Camera2D/ScreenShake.max_offset = Vector2(max(0.1,_damage) * 30, max(0.1,_damage) * 30)
	$Camera2D/ScreenShake.add_trauma(1.0)
	yield(get_tree().create_timer(0.19), "timeout")
	_target.get_material().set_shader_param("enabled", false)


func dodged(_character: Character):
	
	var story = get_tree().get_nodes_in_group("story").front()
	var _current_artifact = story.current_artifact
	
	if _current_artifact != null and _current_artifact.get("ANTI_DODGE") or game_screen.selected_tarot_card.get("ANTI_DODGE"):
		return false
			
	if rand_range(0,1) < _character.stats["energy"] / 2:
		return true
	else:
		return false



func improve_combat(_character):
	var _old_combat_level = _character.traits["combat"]
	_character.traits["combat"] += rand_range(0.001, 0.0083)
	if floor(_character.traits["combat"] * 10) > floor(_old_combat_level * 10):
		action_library.upcoming_stories.push_back(_character.character_name + " has improved his combat")



func complete_battle():
	if $CharactersContainer.get_child_count() > 0:
		animation_player.play("Unload")
		yield(animation_player,"animation_finished")
	emit_signal("battle_finished")
	queue_free()
