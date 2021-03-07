class_name AngelorisItem

const NAME := "angeloris"
const HISTORY := "A white mushroom."
const TEXTURE := "res://Textures/Items/Angeloris Item.png"

const CALORIES = 0.1
var effect = Nausea.new()

const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = WaitAction
const EAST_ACTION = WaitAction

func _init():
	effect.activation_minute = round(rand_range(60,90))
