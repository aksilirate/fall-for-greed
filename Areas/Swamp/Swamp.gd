class_name Swamp


const NEXT_AREA = Mist
var total_locations = randomize_total_locations()

const HISTORY = "Not a single human had ever reached this swamp, not a single human had ever seen this swamp."

const TEXTURES = [
	"res://Textures/Areas/Swamp/Swamp 0.png",
	"res://Textures/Areas/Swamp/Swamp 1.png"
]

const FINDINGS = []

const ZONES = []

const ENEMIES = []

const NPCS = []


const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = ChangeDirectionAction
const EAST_ACTION = SearchAction


func randomize_total_locations():
	randomize()
	return round(rand_range(30,60))
