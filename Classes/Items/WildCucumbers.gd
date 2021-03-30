class_name WildCucumbersItem



const NAME := "wild cucumbers"
const HISTORY := "Wild cucumbers."
const TEXTURE := "res://Textures/Items/Wild Cucumbers Item.png"
const TOOLTIP := "wild cucumbers"

const MISSING_MESSAGE := "wild cucumbers are missing"

const CALORIES = 0.017
const COOKS_INTO = null
const MAX_COOK_TIME = 0
const MIN_COOK_TIME = 0

var effects = [
	Nausea.new()
	]

const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = null
const EAST_ACTION = DropAction

func _init():
	effects[0].activation_minute = round(rand_range(90,178))
	effects[0].deactivation_minute = round(rand_range(2880,4320))
