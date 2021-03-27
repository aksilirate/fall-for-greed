extends Enemy
class_name Leshy

# Used for "you have killed the wolf"
const NAME = "the leshy"

const HISTORY = "Born in the forest and filled with hatred for humans."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Leshy Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Enemies/Leshy Enemy.png"
]


var health := 4.9
const DAMAGE := 0.721
const SPEED := 2.3
const POWER := 13


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null

var RAND_WEIGHT := 0.01


