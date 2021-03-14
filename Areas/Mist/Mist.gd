class_name Mist


const NEXT_AREA = null
var total_locations = randomize_total_locations()

const HISTORY = "A mist filled with fear and anxiety, the death of the human spirit."

const TEXTURES = [
	"res://Textures/Areas/Mist/Mist 0.png",
	"res://Textures/Areas/Mist/Mist 1.png"
]

const FINDINGS = []

const ZONES = []

const ENEMIES = []

const NPCS = []


const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = SleepAction
const EAST_ACTION = SearchAction


func randomize_total_locations():
	randomize()
	return round(rand_range(60,100))
