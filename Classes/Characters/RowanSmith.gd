extends Character
class_name RowanSmith

const STORY := "A smith and a woodworker possessed by a hatred for demons."
const SELF_PROFILE_PICTURE := preload("res://Textures/Character Profiles/Rowan Smith.png")
const UNIT_TEXTURE := "res://Textures/Battle/Characters/Rowan Smith Unit.png"

const DAMAGE = 1.3

var active_threats: Array


func _init():
	character_name = "Rowan Smith"



