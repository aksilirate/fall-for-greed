extends Zone
class_name CaveEntrance

const NEXT_AREA = Cave

const HISTORY = "An entrance to a dark cave."


const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Zones/Cave Entrance.png"
]



const WEST_ACTION = EnterAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = SleepAction
const EAST_ACTION = SearchAction


const RAND_WEIGHT := 0.5
