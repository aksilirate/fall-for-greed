extends Node


var AMBIENT_NOTES = [
	"res://Sounds/Ambient Notes/C3.wav",
	"res://Sounds/Ambient Notes/D4.wav",
	"res://Sounds/Ambient Notes/Eb3.wav",
	"res://Sounds/Ambient Notes/F3.wav",
	"res://Sounds/Ambient Notes/G#3.wav"
]

var current_note_index: int
var ambient_notes_cache = []

func _ready():
	current_note_index = randi() % AMBIENT_NOTES.size()
	Sound.emit_ambient_sound_effect(AMBIENT_NOTES[current_note_index])

func _on_NoteTimer_timeout():
	ambient_notes_cache = [] + AMBIENT_NOTES
	var new_index = randi() % AMBIENT_NOTES.size()
	if current_note_index == new_index:
		if new_index == AMBIENT_NOTES.size() - 1:
			new_index -= 1
		else:
			new_index += 1
	current_note_index = new_index
	Sound.emit_ambient_sound_effect(ambient_notes_cache[current_note_index])
