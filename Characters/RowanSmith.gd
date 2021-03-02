extends Character
class_name RowanSmith

const STORY := "A smith and a woodworker possessed by a hatred for demons."
const SELF_PROFILE_PICTURE := preload("res://Textures/Character Profiles/Rowan Smith.png")
const UNIT_TEXTURE := "res://Textures/Battle/Characters/Rowan Smith Unit.png"
var active_threats: Array


func _init():
	character_name = "Rowan Smith"


func _ready():
	init_character_data(character_name)

