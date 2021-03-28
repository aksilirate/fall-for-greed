class_name BerriesFinding

const NAME = "berries"

const ITEM = BerriesItem

# Minimum of 2 textures needed
const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Findings/Berries Finding 0.png",
	"res://Textures/Areas/Abandoned Forest/Findings/Berries Finding 1.png"
]

const HISTORY = "Sweet smelling berries."

const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = ChangeDirectionAction
const EAST_ACTION = SearchAction



const RAND_WEIGHT := 0.3
