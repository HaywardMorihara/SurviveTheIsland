class_name LavaPiece
extends RigidBody2D

signal place_coin(pos)
signal hit_player()

export var coin_probability_denominator := 3

onready var animation_player = get_node('../Transition/Background/AnimationPlayer')


func _on_RigidBody2D_body_entered(body):
	if body.name == 'Player':
		emit_signal("hit_player")
		self.queue_free()
	elif body.name == 'TileMap':
		# break block
		var body_position = body.world_to_map(position)
		body.set_cell(body_position.x,body_position.y+1,-1)
		body.set_cell(body_position.x-1,body_position.y+1,-1)
		body.set_cell(body_position.x+1,body_position.y+1,-1)
		if randi() % coin_probability_denominator == 0:
			emit_signal("place_coin", position)
		self.queue_free()
	else:
		# breaking player placed blocks
		body.queue_free()
		if randi() % coin_probability_denominator == 0:
			emit_signal("place_coin", position)
		self.queue_free()
