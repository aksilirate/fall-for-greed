extends Character
class_name PyryWright

const STORY := "A cursed man that has lost his home, wife and son."
const SELF_PROFILE_PICTURE := preload("res://Textures/Character Profiles/Pyry Wright.png")
const UNIT_TEXTURE := "res://Textures/Battle/Characters/Pyry Wright Unit.png"
var active_threats: Array

const DAMAGE = 0.9

func _init():
	character_name =  "Pyry Wright"

func _ready():
	init_character_data(character_name)
