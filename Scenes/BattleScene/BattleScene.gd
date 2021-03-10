extends Control

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var tween = get_node(tween) as Tween
onready var game_screen = get_tree().get_root().get_node("GameScreen")

const ENEMY_ORIGIN = Vector2(168,56)

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
		tween.interpolate_property(_character, "rect_position", _character.rect_position, _enemy_position, 0.3, Tween.TRANS_EXPO)
		tween.start()
		yield(get_tree().create_timer(0.19), "timeout")
		hit($Enemy)
		enemy.health -= _character.character_reference.damage
		yield(tween,"tween_completed")
		tween.interpolate_property(_character, "rect_position", _character.rect_position, _character_origin, 0.3, Tween.TRANS_EXPO)
		yield(tween,"tween_completed")
		
		if enemy.health <= 0:
			animation_player.play("Unload")
			yield(animation_player,"animation_finished")
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
	tween.interpolate_property($Enemy, "rect_position", $Enemy.rect_position, _edited_character_position, 0.3, Tween.TRANS_EXPO)
	tween.start()
	yield(get_tree().create_timer(0.19), "timeout")
	hit(_character)
	_character.character_reference.stats["health"] -= enemy.DAMAGE * 3
	yield(tween,"tween_completed")
	tween.interpolate_property($Enemy, "rect_position", $Enemy.rect_position, ENEMY_ORIGIN, 0.3, Tween.TRANS_EXPO)
	yield(tween,"tween_completed")
	
	if _character.character_reference.stats["health"] <= 0:
		animation_player.play("Unload")
		yield(animation_player,"animation_finished")
		var _character_name = _character.character_reference.character_name
		_character.character_reference.queue_free()
		_character.queue_free()
		emit_signal("kill_character", _character.character_reference)
		play_death_message(_character_name + " have died")
		yield(self, "death_message_finished")
		if $CharactersContainer.get_child_count() > 0:
			animation_player.play("Load")
			yield(animation_player,"animation_finished")
			
	complete_battle()
	

func play_death_message(_death_message):
	var story_label = preload("res://Scenes/StoryLabel/StoryLabel.tscn").instance()
	var story_animation_player = story_label.get_node("AnimationPlayer")
	story_label.text =  _death_message
	add_child(story_label)
	yield(story_animation_player,"animation_finished")
	story_label.queue_free()
	
	emit_signal("death_message_finished")

func pick_random_character():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	return $CharactersContainer.get_child(rand.randi_range(0, $CharactersContainer.get_child_count()-1))
		
		
func hit(_target):
	_target.get_material().set_shader_param("enabled", true)
	yield(get_tree().create_timer(0.19), "timeout")
	_target.get_material().set_shader_param("enabled", false)
	
		
func complete_battle():
	if $CharactersContainer.get_child_count() > 0:
		animation_player.play("Unload")
		yield(animation_player,"animation_finished")
	emit_signal("battle_finished")
	queue_free()
