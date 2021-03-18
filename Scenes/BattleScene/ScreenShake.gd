extends Node

onready var camera = get_parent()
onready var noise = OpenSimplexNoise.new()

var decay = 3.0
var max_offset = Vector2(30, 30) 
var max_rotation = 0.3  

var trauma = 0.0
var trauma_power = 3



func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2



func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()



var noise_y = 0
func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	camera.rotation = max_rotation * amount * noise.get_noise_2d(noise.seed, noise_y)
	camera.offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	camera.offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)



func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
