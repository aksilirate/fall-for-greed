extends Enemy
class_name Wolf

# Used for "you have killed the wolf"
const NAME = "the wolf"

const HISTORY = "A lone hostile wolf."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Wolf Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Enemies/Wolf Enemy.png"
]


var health := 3.0
const DAMAGE := 0.5
const SPEED := 2
const POWER := 7


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null


const RAND_WEIGHT := 0.5
