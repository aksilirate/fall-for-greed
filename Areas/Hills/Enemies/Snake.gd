extends Enemy
class_name Snake

# Used for "you have killed the wolf"
const NAME = "the snake"

const HISTORY = "A snake."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Snake Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Hills/Enemies/Snake Enemy.png"
]


var health := 1.34
const DAMAGE := 0.3
const SPEED := 2.48
const POWER := 11


const WEST_ACTION = null
const LEFT_ACTION = FightAction
const RIGHT_ACTION = RunAction
const EAST_ACTION = null


func hit_effect(_character):
	var effect = Effect.new()
	var poison = Poison.new()
	poison.deactivation_minute = 10080
	effect.active_effect = poison
	_character.add_child(effect)
