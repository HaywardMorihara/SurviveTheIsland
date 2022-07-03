extends Node

const NUMBER_OF_LAVA_PIECES_PER_WAVE := 30
const STAGGER_BETWEEN_WAVES := 500

var lava_piece_scene = preload("res://src/Weather/LavaPiece.tscn")

var limit_left : int
var limit_top : int
var limit_right : int
var limit_bottom : int

var magnitude := 1

func set_level_bounds(left, top, right, bottom) -> void:
	limit_left = left
	limit_top = top
	limit_right = right
	limit_bottom = bottom	 


func start() -> Array:
	var lava_pieces := []
	for wave_number in range (0, magnitude):
		for j in range(0, NUMBER_OF_LAVA_PIECES_PER_WAVE):
			var lava_piece = lava_piece_scene.instance()
			lava_piece.position = Vector2(rand_range(limit_left, limit_right), rand_range(limit_top, limit_top - (STAGGER_BETWEEN_WAVES * wave_number)))
			lava_pieces.append(lava_piece)
	# Trying consistent magnitude and less destructive
#	magnitude += 1 # Next time, the intensity will be greater
	return lava_pieces
