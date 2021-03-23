class_name EnderaItem



const NAME := "endera"
const HISTORY := "A plant known as an antidote to any poison."
const TEXTURE := "res://Textures/Items/Endera Item.png"
const TOOLTIP := "endera"

const CALORIES = 0.01
const COOKS_INTO = null
const MAX_COOK_TIME = 0
const MIN_COOK_TIME = 0


const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = null
const EAST_ACTION = DropAction


func on_eat(_character: Character):
	for _child in _character.get_children():
		if _child.active_effect is Poison:
			_child.free()
	
