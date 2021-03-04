extends Control

export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var InputBlocker = get_node(InputBlocker) as ColorRect

const left_position := Vector2(93,76)
const center_position := Vector2(157,76)
const right_position := Vector2(221,76)

enum {CENTER_LEFT, CENTER_RIGHT, LEFT_RIGHT}
enum {LEFT, CENTER, RIGHT}

var heart_location = [false,true,false]
var rand = RandomNumberGenerator.new()

var speed = 5
var power := 30

	
func _ready():
	
	if owner.enemy == null:
		owner.enemy = WolfEnemy.new()
		
	speed = owner.enemy.SPEED
	power = owner.enemy.POWER
	
	animation_player.play("Load")
	yield(animation_player,"animation_finished")
	start_cup_game()
	
func start_cup_game():
	heart_location = [false,true,false]
	rand.randomize()
	yield(get_tree().create_timer(0.6), "timeout")
	animation_player.play("ShowCenter")
	yield(animation_player,"animation_finished")
	animation_player.playback_speed = speed
	$Heart.visible = false
	for _index in power:
		var shuffle_type = rand.randi_range(0,2)
		match shuffle_type:
			CENTER_LEFT:
				if rand.randi_range(0,1) == 0:
					animation_player.play("CenterLeft")
				else:
					animation_player.play_backwards("CenterLeft")
					
				var _center = heart_location[CENTER]
				var _left = heart_location[LEFT]
				heart_location[CENTER] = _left
				heart_location[LEFT] = _center
				
				yield(animation_player,"animation_finished")
				
			CENTER_RIGHT:
				if rand.randi_range(0,1) == 0:
					animation_player.play("CenterRight")
				else:
					animation_player.play_backwards("CenterRight")
					
				var _center = heart_location[CENTER]
				var _right = heart_location[RIGHT]
				heart_location[CENTER] = _right
				heart_location[RIGHT] = _center
				
				yield(animation_player,"animation_finished")
				
			LEFT_RIGHT:
				if rand.randi_range(0,1) == 0:
					animation_player.play("LeftRight")
				else:
					animation_player.play_backwards("LeftRight")
					
				var _left = heart_location[LEFT]
				var _right = heart_location[RIGHT]
				heart_location[LEFT] = _right
				heart_location[RIGHT] = _left
				
				yield(animation_player,"animation_finished")

	$CupLeft.rect_position = Vector2(93,76)
	$CupCenter.rect_position = Vector2(157,76)
	$CupRight.rect_position = Vector2(221,76)
	

	InputBlocker.visible = false
	
var heart_found:bool
func _on_cup_selected(_cup):
	$Heart.visible = false
	heart_found = false
	match _cup:
		"Left":
			if heart_location[LEFT] == true:
				$Heart.rect_position = Vector2(110,109.5)
				$Heart.visible = true
				heart_found = true
			animation_player.play("ShowLeft")
		"Center":
			if heart_location[CENTER] == true:
				$Heart.rect_position = Vector2(174,109.5)
				$Heart.visible = true
				heart_found = true
			animation_player.play("ShowCenter")
		"Right":
			if heart_location[RIGHT] == true:
				$Heart.rect_position = Vector2(238,109.5)
				$Heart.visible = true
				heart_found = true
			animation_player.play("ShowRight")
			
	InputBlocker.visible = true
	load_battle_scene()

func load_battle_scene():
	yield(animation_player,"animation_finished")
	animation_player.play("Unload")
	yield(animation_player,"animation_finished")
	var battle_scene = preload("res://Scenes/BattleScene/BattleScene.tscn").instance()
	battle_scene.enemy = owner.enemy
	if heart_found:
		battle_scene.heart_found = true
	else:
		battle_scene.heart_found = false
	owner.add_child(battle_scene)
