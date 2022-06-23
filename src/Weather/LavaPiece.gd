class_name LavaPiece
extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation_player = get_node('../Transition/Background/AnimationPlayer')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_RigidBody2D_body_entered(body):
	if body.name == 'Player':
		animation_player.play("FadeGameOver")
		self.queue_free()
	elif body.name == 'TileMap':
		# break block
		var body_position = body.world_to_map(position)
		body.set_cell(body_position.x,body_position.y+1,-1)
		body.set_cell(body_position.x-1,body_position.y+1,-1)
		body.set_cell(body_position.x+1,body_position.y+1,-1)
		self.queue_free()
	else:
		# breaking player placed blocks
		body.queue_free()
		self.queue_free()
