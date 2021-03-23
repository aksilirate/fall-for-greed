class_name EnderaFinding

const NAME = "an endera"

const ITEM = EnderaItem

# Minimum of 2 textures needed
const TEXTURES = [
	"res://Textures/Areas/Hills/Findings/Endera Finding 0.png",
	"res://Textures/Areas/Hills/Findings/Endera Finding 1.png"
]

const HISTORY := "A plant known as an antidote to any poison."

const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = ChangeDirectionAction
const EAST_ACTION = SearchAction
