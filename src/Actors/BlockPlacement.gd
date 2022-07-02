class_name BlockPlacement
extends Area2D

signal block_placed(block)

const StoneBlock = preload("res://src/Blocks/StoneBlock.tscn")
const DirtBlock = preload("res://src/Blocks/DirtBlock.tscn")
const SandBlock = preload("res://src/Blocks/SandBlock.tscn")

const BlockSize = 32.0
const STONE_BLOCK_TYPE := "stone_block"
const DIRT_BLOCK_TYPE := "dirt_block"
const SAND_BLOCK_TYPE := "sand_block"

onready var sound_shoot = $Shoot
onready var timer = $Cooldown

var block_inventory := {
	STONE_BLOCK_TYPE: 0,
	DIRT_BLOCK_TYPE: 0,
	SAND_BLOCK_TYPE: 0,
}
var current_block_type := SAND_BLOCK_TYPE

# This method is only called by Player.gd.
func place():
	if not timer.is_stopped():
		return false
	
	var overlapping_bodies := get_overlapping_bodies()
	if !overlapping_bodies && block_inventory[current_block_type] > 0:
		block_inventory[current_block_type] -= 1
		var block
		match current_block_type:
			STONE_BLOCK_TYPE:
				block = StoneBlock.instance()
			DIRT_BLOCK_TYPE:
				block = DirtBlock.instance()
			SAND_BLOCK_TYPE:
				block = SandBlock.instance()
		block.global_position = global_position
		block.set_as_toplevel(true) # TBH, not sure why to call this, but the demo had it so...
		sound_shoot.play()
		emit_signal("block_placed", block)
	
		timer.start()
		return true
	
	return false

# This method is only called by Player.gd.
func remove():
	if not timer.is_stopped():
		return false
	
	var overlapping_bodies := get_overlapping_bodies()
	for overlapping_body in overlapping_bodies:
		if overlapping_body is TileMap:
			var tile_map = overlapping_bodies[0]
			var tile_pos = tile_map.world_to_map(global_position)
			var cell_id = tile_map.get_cellv(tile_pos)
			if cell_id == -1:
				return false
			var tile_name = tile_map.tile_set.tile_get_name(cell_id)
			if tile_name:
				block_inventory[tile_name] += 1
				tile_map.set_cell(tile_pos.x, tile_pos.y, -1)
				timer.start()
				return true
		elif overlapping_body.is_in_group("blocks"):
			var block = overlapping_body
			var groups = block.get_groups()
			for group in groups:
				if group.match("*_block"):
					block_inventory[group] += 1
					block.queue_free()
					timer.start()
					return true
		
	return false


func cycle_block_type_down() -> void:
	match current_block_type:
		STONE_BLOCK_TYPE:
			current_block_type = DIRT_BLOCK_TYPE
		DIRT_BLOCK_TYPE:
			current_block_type = SAND_BLOCK_TYPE
		SAND_BLOCK_TYPE:
			current_block_type = STONE_BLOCK_TYPE


func cycle_block_type_up() -> void:
	match current_block_type:
		STONE_BLOCK_TYPE:
			current_block_type = SAND_BLOCK_TYPE
		DIRT_BLOCK_TYPE:
			current_block_type = STONE_BLOCK_TYPE
		SAND_BLOCK_TYPE:
			current_block_type = DIRT_BLOCK_TYPE


func get_current_block_count() -> int:
	return block_inventory[current_block_type]
	

func snap_to_grid(vec):
	global_position = _snap_vector_to_grid(vec) + Vector2(BlockSize/2, BlockSize/2)


func _snap_vector_to_grid(vec) -> Vector2:
	return Vector2(_snap_float_to_grid(vec.x), _snap_float_to_grid(vec.y))
	

func _snap_float_to_grid(value) -> float:
	var remainder := fmod(value, BlockSize)
	if value >= 0.0:
		return value - remainder
	else:
		return value - (BlockSize + remainder)
