extends Zone
class_name AbandonedShovel

const NAME = "a shovel"
const ITEM = ShovelItem

const HISTORY = "An abandoned shovel."


const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Zones/Abandoned Shovel.png"
]



const WEST_ACTION = WaitAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = SleepAction
const EAST_ACTION = SearchAction



const RAND_WEIGHT := 0.1
