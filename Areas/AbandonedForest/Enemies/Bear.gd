extends Enemy
class_name Bear

# Used for "you have killed the wolf"
const NAME = "the bear"

const HISTORY = "An aggressive brown bear."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Bear Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Enemies/Bear Enemy.png"
]


var health := 4.8
const DAMAGE := 0.6
const SPEED := 1.5
const POWER := 8


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null



