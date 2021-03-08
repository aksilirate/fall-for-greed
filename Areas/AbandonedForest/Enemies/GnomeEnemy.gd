class_name GnomeEnemy

# Used for "you have killed the ---"
const NAME = "the gnome"

const HISTORY = "A small angry gnome searching for something or someone."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Gnome Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Enemies/Gnome Enemy.png"
]


var health := 1.0
const DAMAGE := 0.2
const SPEED := 1.6
const POWER := 3


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null
