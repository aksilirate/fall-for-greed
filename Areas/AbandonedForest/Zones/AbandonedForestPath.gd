extends Zone
class_name AbandonedForestPath

const NEXT_AREA = Hills

const HISTORY = "A path leading to the unkown"


const TEXTURES = [
	"res://Textures/Areas/Abandoned Forest/Zones/Abandoned Forest Path.png"
]



const WEST_ACTION = FollowPathAction
const LEFT_ACTION = WalkAction
const RIGHT_ACTION = SleepAction
const EAST_ACTION = SearchAction


const RAND_WEIGHT := 0.32
