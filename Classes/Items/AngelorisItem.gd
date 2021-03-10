class_name AngelorisItem



const NAME := "angeloris"
const HISTORY := "A white mushroom."
const TEXTURE := "res://Textures/Items/Angeloris Item.png"
const TOOLTIP := "angeloris"

const CALORIES = 0.1
const COOKS_INTO = CookedAngelorisItem
const MAX_COOK_TIME = 3
const MIN_COOK_TIME = 1

var effect = Nausea.new()

const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = null
const EAST_ACTION = null

func _init():
	effect.activation_minute = round(rand_range(60,90))
	effect.deactivation_minute = round(rand_range(2880,4320))
