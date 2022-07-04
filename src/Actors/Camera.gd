extends Camera2D

# Done following https://kidscancode.org/godot_recipes/2d/screen_shake/

export var decay = 0.25 # How quickly the shaking stops [0, 1].

export var max_offset = Vector2(40, 80)  # Maximum hor/ver shake in pixels

export var max_roll = 0.1 # Maximum rotation in radians (use sparingly)

var trauma = 0.0 # Current shake strength

var trauma_power = 2 # Trauma exponent. Use [2, 3]

# trauma_power is the relationship between `trauma` and the actual movement of the camera. 
# Square or cube is usually the best


onready var noise = OpenSimplexNoise.new()
var noise_y = 0


func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
		

# Call to start or increase shaking. Pass it a value from [0,1]
func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		_shake()
		

func _shake():
	var amount = pow(trauma, trauma_power)
	
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

