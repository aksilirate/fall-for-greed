extends Node


var AMBIENT_NOTES = [
	preload("res://Sounds/Ambient Notes/C3.wav"),
	preload("res://Sounds/Ambient Notes/D4.wav"),
	preload("res://Sounds/Ambient Notes/Eb3.wav"),
	preload("res://Sounds/Ambient Notes/F3.wav"),
	preload("res://Sounds/Ambient Notes/G#3.wav")
]

var current_note_index: int
var ambient_notes_cache = []

func _ready():
	current_note_index = randi() % AMBIENT_NOTES.size()
	emit_Sound_Effect(AMBIENT_NOTES[current_note_index])

func _on_NoteTimer_timeout():
	ambient_notes_cache = [] + AMBIENT_NOTES
	var new_index = randi() % AMBIENT_NOTES.size()
	if current_note_index == new_index:
		if new_index == AMBIENT_NOTES.size() - 1:
			new_index -= 1
		else:
			new_index += 1
	current_note_index = new_index
	emit_Sound_Effect(ambient_notes_cache[current_note_index])


func emit_Sound_Effect(sound):
	var _sound_effect = preload("res://Scenes/SoundEffect/SoundEffect.tscn").instance()
	_sound_effect.stream = sound
	_sound_effect.volume_db = 21.666
	_sound_effect.bus = "Ambient"
	get_node("/root").call_deferred("add_child", _sound_effect)
