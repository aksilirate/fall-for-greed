class_name Cave


const NEXT_AREA = null
var total_locations: int


const NAME = "the cave"

const HISTORY = "A silent cave."

const LAST_EVENT = CaveExit

const TEXTURES = [
	"res://Textures/Areas/Cave/Cave 0.png",
	"res://Textures/Areas/Cave/Cave 1.png"
]

const FINDINGS = []

const ZONES = []

const ENEMIES = [
	CaveSpider,
	Rat
]

const NPCS = []


 
const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = ChangeDirectionAction
const EAST_ACTION = SearchAction

func _init():
	total_locations = randomize_total_locations()
	
func randomize_total_locations():
	randomize()
	return round(rand_range(30,60))
