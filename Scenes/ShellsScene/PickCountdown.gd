extends Label

export(NodePath) onready var shell_game = get_node(shell_game) as Node
var time_left = 9

func _init():
	modulate.a = 0


func _ready():
	shell_game.connect("pick_phase_started", self, "_on_pick_phase_started")
	shell_game.connect("shell_picked", self, "_on_shell_picked")


func _on_pick_phase_started():
	
	text = str(time_left)
	blink_label()
	$PickCountdownTimer.start()
	
func _on_shell_picked():
	$PickCountdownTimer.stop()
	time_left = 9

func _on_PickCountdownTimer_timeout():
	if time_left > 1:
		time_left -= 1
		text = str(time_left)
		blink_label()
	else:
		shell_game.heart_found = false
		shell_game.load_battle_scene()
		$PickCountdownTimer.stop()
		time_left = 9


func blink_label():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
