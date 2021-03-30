class_name DeadForest


const NEXT_AREA = Swamp
var total_locations = randomize_total_locations()

const HISTORY = "Once ruled by a greedy king, became the forest of the dead."

const TEXTURES = [
	"res://Textures/Areas/Dead Forest/Dead Forest 0.png",
	"res://Textures/Areas/Dead Forest/Dead Forest 1.png"
]

const FINDINGS = []

const ZONES = [QueensGrave]

const ENEMIES = [FallenKing]

const NPCS = []


const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = ChangeDirectionAction
const EAST_ACTION = SearchAction


func randomize_total_locations():
	randomize()
	return round(rand_range(30,60))
