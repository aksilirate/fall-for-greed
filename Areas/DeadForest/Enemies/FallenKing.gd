extends Enemy
class_name FallenKing

# Used for "you have killed the wolf"
const NAME = "the fallen king"

const HISTORY = "A strange creature begging for your forgivness."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Fallen King Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Dead Forest/Enemies/Fallen King Enemy.png"
]


var health := 13
const DAMAGE := 0.1676767
const SPEED := 3.676767
const POWER := 21


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null

const RAND_WEIGHT := 0.1676767


