class_name NilonItem



const NAME := "nilon"
const HISTORY := "A flower with a stingy smell, filled with strength and rage."
const TEXTURE := "res://Textures/Items/Nilon Item.png"
const TOOLTIP := "nilon"

const CALORIES = 0.028
const COOKS_INTO =  null
const MAX_COOK_TIME = 0
const MIN_COOK_TIME = 0

var effects = [
	Rage.new()
	]

const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = null
const EAST_ACTION = DropAction

func _init():
	effects[0].activation_minute = round(rand_range(0,0))
	effects[0].deactivation_minute = round(rand_range(480,540))
