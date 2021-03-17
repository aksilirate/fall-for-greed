extends Enemy
class_name Wanderer


const NAME = "the wanderer"

const HISTORY = "The wanderer offers you an artifact in exchange of half of your health."

const UNIT_TEXTURE := "res://Textures/Battle/Enemies/Wanderer Unit.png"

const TEXTURES = [
	"res://Textures/Areas/Global/Wanderer Enemy.png"
]


var health := 20.0
const DAMAGE := 20.0
const SPEED := 20
const POWER := 20


const WEST_ACTION = FightAction
const LEFT_ACTION = AcceptOfferAction
const RIGHT_ACTION = DeclineOfferAction
const EAST_ACTION = null
