extends Node



var magnitude := 1

func start(tileMap, blocks) -> Array:
	var pos_list := []
	var destruction_probability_denominator := 40 - (magnitude * 2)
	for block in blocks:
		if randi() % destruction_probability_denominator == 0:
			block.queue_free()
			pos_list.append(block.position)
	# https://docs.godotengine.org/en/stable/classes/class_tilemap.html
	for cell_pos in tileMap.get_used_cells():
		if randi() % destruction_probability_denominator == 0:
			tileMap.set_cellv(cell_pos, -1)
			pos_list.append(tileMap.map_to_world(cell_pos) + Vector2(16,16))
	magnitude += 1
	return pos_list
