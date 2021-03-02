class_name WolfEnemy


const HISTORY = "A hostile lone wolf."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Wolf Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Enemies/Wolf Enemy 0.png"
]


var health := 3
const DAMAGE := 0.5
const SPEED := 2
const POWER := 7


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null



