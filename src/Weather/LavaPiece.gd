extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_RigidBody2D_body_entered(body):
	if body.name == 'Player':
		# hurt player (placeholder, we don't have health yet)
		print('Hurt Player')
		self.queue_free()
	elif body.name == 'TileMap':
		# break block
		var body_position = body.world_to_map(position)
		body.set_cell(body_position.x,body_position.y+1,-1)
		self.queue_free()
	else:
		# breaking player placed blocks
		body.queue_free()
		self.queue_free()
