extends Character
class_name RowanSmith

const NAME := "Rowan Smith"
const STORY := "A smith and a woodworker possessed by a hatred for demons."
const SELF_PROFILE_PICTURE := preload("res://Textures/Character Profiles/Rowan Smith.png")

var active_threats: Array


func _ready():
	init_character_data(NAME)

