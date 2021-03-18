extends Enemy
class_name StoneGolem

# Used for "you have killed the wolf"
const NAME = "the stone golem"

const HISTORY = "An awaken stone golem."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Stone Golem Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Mountains/Enemies/Stone Golem Enemy.png"
]


var health := 8.0
const DAMAGE := 0.87
const SPEED := 1.7
const POWER := 9


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null



