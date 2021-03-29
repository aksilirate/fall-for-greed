class_name AngelorisItem



const NAME := "angeloris"
const HISTORY := "A white mushroom."
const TEXTURE := "res://Textures/Items/Angeloris Item.png"
const TOOLTIP := "angeloris"

const CALORIES = 0.09
const COOKS_INTO = CookedAngelorisItem
const MAX_COOK_TIME = 3
const MIN_COOK_TIME = 1

var effects = [
	Nausea.new()
	]

const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = null
const EAST_ACTION = DropAction

func _init():
	effects[0].activation_minute = round(rand_range(60,90))
	effects[0].deactivation_minute = round(rand_range(2880,4320))
