class_name AbandonedForest


const NEXT_AREA = Hills
var total_locations: int

const HISTORY = "An abandoned forest filled with dangers."

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 0.png",
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 1.png",
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 2.png"
]

const FINDINGS = [
	"res://Areas/AbandonedForest/Findings/AngelorisFinding.gd",
	"res://Areas/AbandonedForest/Findings/FallenBranchFinding.gd",
	"res://Areas/AbandonedForest/Findings/ShiitakeShroomsFinding.gd",
	"res://Areas/AbandonedForest/Findings/LageFinding.gd"
]

const ZONES = [
	CaveEntrance,
	AbandonedForestRopeHang
]

const ENEMIES = [
	Wolf,
	Gnome,
	Bear
]

const NPCS = [
	RowanSmithNPC
]


const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = ChangeDirectionAction
const EAST_ACTION = SearchAction

func _init():
	total_locations = randomize_total_locations()
	
func randomize_total_locations():
	randomize()
	return round(rand_range(60,100))
