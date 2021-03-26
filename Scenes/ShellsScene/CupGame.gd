extends Control

onready var game_screen = get_tree().get_root().get_node("GameScreen")

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var pick_countdown_label = get_node(pick_countdown_label) as Label
export(NodePath) onready var input_blocker = get_node(input_blocker) as ColorRect

const left_position := Vector2(93,76)
const center_position := Vector2(157,76)
const right_position := Vector2(221,76)

enum {CENTER_LEFT, CENTER_RIGHT, LEFT_RIGHT}
enum {LEFT, CENTER, RIGHT}

var heart_location = [false,true,false]
var rand = RandomNumberGenerator.new()

var speed = 5
var power := 30

var peek_count := 0

signal pick_phase_started
signal shell_picked

func _ready():
	
	if owner.enemy == null:
		owner.enemy = Gnome.new()
		
	var story = get_tree().get_nodes_in_group("story").front()
	
	var _current_artifact = null
	if story:
		_current_artifact = story.current_artifact
	
	
	if _current_artifact != null and _current_artifact.get("DOUBLE_SPEED"):
		speed = owner.enemy.SPEED * 2
	else:
		speed = owner.enemy.SPEED
		
	power = owner.enemy.POWER
	if get_parent().auto_lose:
		heart_found = false
		load_battle_scene()
	else:
		animation_player.play("Load")
		yield(animation_player,"animation_finished")
		start_cup_game()
	
func play_shuffle_sound():
	var _sound_effect = preload("res://Scenes/SoundEffect/SoundEffect.tscn").instance()
	_sound_effect.stream = load("res://Sounds/Game/Cup Shuffle.wav")
	randomize()
	_sound_effect.pitch_scale = rand_range( (animation_player.playback_speed/3) + 0.3, (animation_player.playback_speed/3) + 0.9)
	get_node("/root").add_child(_sound_effect)
	
	
func start_cup_game():
	heart_location = [false,true,false]
	peek_count = 0
	rand.randomize()
	yield(get_tree().create_timer(0.6), "timeout")
	animation_player.play("ShowCenter")
	yield(animation_player,"animation_finished")
	animation_player.playback_speed = speed
	$Heart.visible = false
	for _index in power:
		var shuffle_type = rand.randi_range(0,2)
		play_shuffle_sound()
		match shuffle_type:
			CENTER_LEFT:
				if rand.randi_range(0,1) == 0:
					animation_player.play("CenterLeft")
				else:
					animation_player.play_backwards("CenterLeft")
					
					
				switch_cups(CENTER, LEFT)
				
				
				yield(animation_player,"animation_finished")
				
			CENTER_RIGHT:
				if rand.randi_range(0,1) == 0:
					animation_player.play("CenterRight")
				else:
					animation_player.play_backwards("CenterRight")
					
				switch_cups(CENTER, RIGHT)

				yield(animation_player,"animation_finished")
				
			LEFT_RIGHT:
				if rand.randi_range(0,1) == 0:
					animation_player.play("LeftRight")
				else:
					animation_player.play_backwards("LeftRight")
					
				switch_cups(LEFT, RIGHT)
				
				yield(animation_player,"animation_finished")
				
	reset_cup_locations()
	
		
	input_blocker.visible = false
	
	$Heart.visible = true
	match heart_location.find(true):
		LEFT:
			$Heart.rect_position = Vector2(110,109.5)
		CENTER:
			$Heart.rect_position = Vector2(174,109.5)
		RIGHT:
			$Heart.rect_position = Vector2(238,109.5)
			
	emit_signal("pick_phase_started")


func switch_cups(_first_cup , _second_cup):
	var _first_cup_cache = heart_location[_first_cup]

	heart_location[_first_cup] = heart_location[_second_cup]
	heart_location[_second_cup] = _first_cup_cache



var heart_found:bool
var fool: bool
func _on_cup_selected(_cup):
	fool = false
	$Heart.visible = false
	heart_found = false
	
	if rand_range(0,speed) < min(speed,owner.enemy.DAMAGE) / 3:
		var story = get_tree().get_nodes_in_group("story").front()
		var _current_artifact = story.current_artifact
		if _current_artifact != null and _current_artifact.get("ANTI_FOOL"):
			fool = false
		else:
			fool = true
			
	match _cup:
		"Left":
			if not fool:
				if heart_location[LEFT] == true:
					heart_found = true
			else:
				play_shuffle_sound()
				if rand.randi_range(0,1) == OK:
					animation_player.play("CenterLeft")
				else:
					animation_player.play_backwards("CenterLeft")
					
				switch_cups(CENTER, LEFT)
				if heart_location[LEFT] == true:
					$Heart.rect_position = Vector2(110,109.5)
					heart_found = true
				else:
					heart_found = false
					
				yield(animation_player,"animation_finished")
				reset_cup_locations()
				
			$Heart.visible = heart_found
			animation_player.play("ShowLeft")
		"Center":
			if not fool:
				if heart_location[CENTER] == true:
					heart_found = true
			else:
				play_shuffle_sound()
				if rand.randi_range(0,1) == OK:
					animation_player.play("CenterRight")
				else:
					animation_player.play_backwards("CenterRight")
					
				switch_cups(CENTER, RIGHT)
				if heart_location[CENTER] == true:
					$Heart.rect_position = Vector2(174,109.5)
					heart_found = true
				else:
					heart_found = false
					
				yield(animation_player,"animation_finished")
				reset_cup_locations()
				
			$Heart.visible = heart_found
			animation_player.play("ShowCenter")
		"Right":
			if not fool:
				if heart_location[RIGHT] == true:
					heart_found = true
			else:
				play_shuffle_sound()
				if rand.randi_range(0,1) == OK:
					animation_player.play("LeftRight")
				else:
					animation_player.play_backwards("LeftRight")
					
				switch_cups(LEFT, RIGHT)
				if heart_location[RIGHT] == true:
					$Heart.rect_position = Vector2(238,109.5)
					heart_found = true
				else:
					heart_found = false
					
				yield(animation_player,"animation_finished")
				reset_cup_locations()
			
			$Heart.visible = heart_found
			animation_player.play("ShowRight")
			
	emit_signal("shell_picked")
	input_blocker.visible = true
	load_battle_scene()

func load_battle_scene():
	if not get_parent().auto_lose:
		if pick_countdown_label.time_left > 1:
			yield(animation_player,"animation_finished")
		animation_player.play("Unload")
		yield(animation_player,"animation_finished")
	else:
		owner.show()
		modulate.a = 0
		$Heart.hide()
		
	var battle_scene = preload("res://Scenes/BattleScene/BattleScene.tscn").instance()
	battle_scene.fool = fool
	battle_scene.peek_count = peek_count
	battle_scene.enemy = owner.enemy
	if heart_found:
		battle_scene.heart_found = true
	else:
		battle_scene.heart_found = false
	owner.call_deferred("add_child", battle_scene)

func reset_cup_locations():
	$CupLeft.rect_position = Vector2(93,76)
	$CupCenter.rect_position = Vector2(157,76)
	$CupRight.rect_position = Vector2(221,76)
	

