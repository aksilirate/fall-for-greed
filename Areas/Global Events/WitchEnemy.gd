extends Enemy
class_name Witch

# Used for "you have killed the wolf"
const NAME = "the witch"

const HISTORY = "She is the cause of suffering to many, including you..."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Witch Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Global/Witch Enemy.png"
]


var health := 6.0
const DAMAGE := 6.0
const SPEED := 6
const POWER := 30


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = null
const EAST_ACTION = null


