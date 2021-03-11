class_name AbandonedForest


var total_locations = randomize_total_locations()
var next_area = Hills.new()

const HISTORY = "An abandoned forest filled with dangers."

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 0.png",
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 1.png",
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 2.png"
]

const FINDINGS = [
	"res://Areas/AbandonedForest/Findings/AngelorisFinding.gd",
	"res://Areas/AbandonedForest/Findings/FallenBranchFinding.gd",
	"res://Areas/AbandonedForest/Findings/ShiitakeShroomsFinding.gd"
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
const RIGHT_ACTION = SleepAction
const EAST_ACTION = SearchAction


func randomize_total_locations():
	randomize()
	return round(rand_range(60,100))
