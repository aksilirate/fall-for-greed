class_name RabbitsMeatItem



const NAME := "rabbits meat"
const HISTORY := "A rabbits meat that died far away from here, thus it's safe to eat."
const TEXTURE := "res://Textures/Items/Rabbits Meat Item.png"
const TOOLTIP := "rabbits meat"

const CALORIES = 0.4
const COOKS_INTO = CookedRabbitsMeatItem
const MAX_COOK_TIME = 33
const MIN_COOK_TIME = 28

var effect = Nausea.new()

const WEST_ACTION = HoldAction
const LEFT_ACTION = EatAction
const RIGHT_ACTION = null
const EAST_ACTION = DropAction


func _init():
	effect.activation_minute = round(rand_range(0,3))
	effect.deactivation_minute = round(rand_range(3,9))
