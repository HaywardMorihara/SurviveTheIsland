extends Node

const NUMBER_OF_LAVA_PIECES := 30

var lava_piece_scene = preload("res://src/Weather/LavaPiece.tscn")

var limit_left : int
var limit_top : int
var limit_right : int
var limit_bottom : int


func set_level_bounds(left, top, right, bottom) -> void:
	limit_left = left
	limit_top = top
	limit_right = right
	limit_bottom = bottom	 


func start() -> Array:
	var lava_pieces := []
	for i in range(0, NUMBER_OF_LAVA_PIECES):
		var lava_piece = lava_piece_scene.instance()
		lava_piece.position = Vector2(rand_range(limit_left, limit_right), rand_range(limit_top, limit_top-500))
		lava_pieces.append(lava_piece)
	return lava_pieces
