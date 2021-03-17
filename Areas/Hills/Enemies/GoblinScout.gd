extends Enemy
class_name GoblinScout

# Used for "you have killed the wolf"
const NAME = "the goblin scout"

const HISTORY = "A scouting goblim."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Goblin Scout Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Hills/Enemies/Goblin Scout Enemy.png"
]


var health := 3.0
const DAMAGE := 0.8
const SPEED := 2.89
const POWER := 9


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null


