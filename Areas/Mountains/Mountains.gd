class_name Mountains


const NEXT_AREA = DeadForest
var total_locations = randomize_total_locations()

const HISTORY = "An area filled with rocks and mountains."

const TEXTURES = [
"res://Textures/Areas/Mountains/Mountains 0.png",
"res://Textures/Areas/Mountains/Mountains 1.png"
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
