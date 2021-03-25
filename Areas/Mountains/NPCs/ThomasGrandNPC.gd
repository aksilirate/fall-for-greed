class_name ThomasGrandNPC

const NAME = "Thomas Grand"

const CHARACTER_OBJECT = ThomasGrand

const HISTORY = "A knight searching for glory and fame."

const UNIT_TEXTURE := "res://Textures/Battle/Characters/Thomas Grand.png"

const TEXTURES = [
	"res://Textures/Areas/Mountains/NPCs/Thomas Grand NPC 0.png"
]


var health := 10.0
const DAMAGE := 0.777
const SPEED := 2.67
const POWER := 16


const WEST_ACTION = null
const LEFT_ACTION = CommunicateAction
const RIGHT_ACTION = FightAction
const EAST_ACTION = null

