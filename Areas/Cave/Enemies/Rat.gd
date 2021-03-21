extends Enemy
class_name Rat

# Used for "you have killed the wolf"
const NAME = "the rat"

const HISTORY = "A giant rat"

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Rat Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Cave/Enemies/Rat Enemy.png"
]


var health := 3.7
const DAMAGE := 0.43
const SPEED := 2.1
const POWER := 7


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null


