extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print('YEA WORKS')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func _on_RigidBody2D_body_entered(body):
	if body.name == 'Player':
		# hurt player (placeholder)
		print('Hurt Player')
	elif body.name == 'TileMap':
		# break block
		print('Break Block')
		body.set_cell(6,12,-1)
