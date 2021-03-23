class_name Hills


const NEXT_AREA = Mountains
var total_locations = randomize_total_locations()

const HISTORY = "A land once filled with life, is covered with hills."

const TEXTURES = [
	"res://Textures/Areas/Hills/Hills 0.png",
	"res://Textures/Areas/Hills/Hills 1.png"
]

const FINDINGS = [
	LageFinding,
	NilonFinding,
	EnderaFinding
]

const ZONES = [
	Ruins0,
	Ruins1
	]

const ENEMIES = [
	GoblinScout,
	Snake
	]

const NPCS = []


const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = ChangeDirectionAction
const EAST_ACTION = SearchAction


func randomize_total_locations():
	randomize()
	return round(rand_range(60,100))
