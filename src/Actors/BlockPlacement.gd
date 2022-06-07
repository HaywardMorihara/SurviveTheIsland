class_name BlockPlacement
extends Area2D

signal block_placed(block)


# The Cooldown timer controls the cooldown duration block placements.

const StaticBlock = preload("res://src/Blocks/StaticBlock.tscn")

onready var sound_shoot = $Shoot
onready var timer = $Cooldown


# This method is only called by Player.gd.
func place():
	if not timer.is_stopped():
		return false
	
	var overlapping_bodies := get_overlapping_bodies()
	if !overlapping_bodies:
		# TODO Could be different types of Blocks
		var block = StaticBlock.instance()
		block.global_position = global_position
		block.set_as_toplevel(true) # TBH, not sure why to call this, but the demo had it so...
		sound_shoot.play()
		emit_signal("block_placed", block)
	
	timer.start()
	return true

# This method is only called by Player.gd.
func remove():
	print("here")
	if not timer.is_stopped():
		return false
	
	var overlapping_bodies := get_overlapping_bodies()
	if overlapping_bodies:
		# TODO Could there be > 1 overlapping_bodies?
		if overlapping_bodies[0] is TileMap:
			var tile_map = overlapping_bodies[0]
			var tile_pos = tile_map.world_to_map(global_position)
			tile_map.set_cell(tile_pos.x, tile_pos.y, -1)
		elif overlapping_bodies[0] is StaticBody2D:
			 overlapping_bodies[0].queue_free()
	
	timer.start()
	return true
