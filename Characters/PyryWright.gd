extends Character
class_name PyryWright

const NAME := "Pyry Wright"
const STORY := "A cursed man that has lost his home, wife and son."
const SELF_PROFILE_PICTURE := preload("res://Textures/Character Profiles/Pyry Wright.png")

var active_threats: Array


func _ready():
	init_character_data(NAME)
