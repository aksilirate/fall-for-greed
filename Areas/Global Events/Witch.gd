extends Enemy
class_name Witch

# Used for "you have killed the wolf"
const NAME = "the witch"

const HISTORY = "The witch, is the casuse of darkness in the lives of many."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Witch Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Global/Witch Enemy.png"
]


var health := 12.0
const DAMAGE := 6.0
const SPEED := 6
const POWER := 30


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null

const INESCAPABLE := true
const UNPEEKABLE := true
const FOOL_UNAVOIDABLE := true
