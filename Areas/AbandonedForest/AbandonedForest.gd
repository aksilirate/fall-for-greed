class_name AbandonedForest


var locations_before_new_area = randomize_locations_before_new_area()
var next_area = Hills.new()

const HISTORY = "An abandoned forest filled with dangers."

const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 0.png",
	"res://Textures/Areas/Abandoned Forest/Abandoned Forest 1.png"
]

const FINDINGS = [
	"res://Areas/AbandonedForest/Findings/AngelorisFinding.gd"
]

const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = SleepAction
const EAST_ACTION = SearchAction


func randomize_locations_before_new_area():
	randomize()
	return round(rand_range(60,100))
