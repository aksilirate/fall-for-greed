class_name SemeryItem



const NAME := "semery"
const HISTORY := "A plant known to boost focus."
const TEXTURE := "res://Textures/Items/Semery Item.png"
const TOOLTIP := "semery"

const CALORIES = 0.012
const COOKS_INTO = null
const MAX_COOK_TIME = 0
const MIN_COOK_TIME = 0

var effects = [
	FocusBoost.new()
	]

const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = null
const EAST_ACTION = DropAction

func _init():
	effects[0].deactivation_minute = round(rand_range(480,520))
