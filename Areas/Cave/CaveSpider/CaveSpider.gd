extends Enemy
class_name CaveSpider

# Used for "you have killed the wolf"
const NAME = "the cave spider"

const HISTORY = "A giant spider"

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Cave Spider Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Cave/Enemies/Spider Enemy.png"
]


var health := 6.0
const DAMAGE := 0.76
const SPEED := 2.5
const POWER := 9


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null


