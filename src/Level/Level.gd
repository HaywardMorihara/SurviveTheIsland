extends Node2D

signal player_out_of_bounds


const LIMIT_LEFT = -315
const LIMIT_TOP = -250
const LIMIT_RIGHT = 955
const LIMIT_BOTTOM = 990

func _ready():
	for child in get_children():
		if child is Player:
			var camera = child.get_node("Camera")
			camera.limit_left = LIMIT_LEFT
			camera.limit_top = LIMIT_TOP
			camera.limit_right = LIMIT_RIGHT
			camera.limit_bottom = LIMIT_BOTTOM


func _on_Player_block_placed(block):
	$Blocks.add_child(block)


func _on_FallDeath_body_entered(body):
	if body.name == 'Player':
		emit_signal("player_out_of_bounds")
