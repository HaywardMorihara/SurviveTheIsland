extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_block_count(current_block_type : String, count : int) -> void:
	$BlockCount/BlockCountLabel.set_text("x" + str(count))


func update_block_type(current_block_type : String) -> void:
	$BlockCount/StoneBlockSprite.visible = false
	$BlockCount/DirtBlockSprite.visible = false
	$BlockCount/SandBlockSprite.visible = false
	match current_block_type:
		BlockPlacement.STONE_BLOCK_TYPE:
			$BlockCount/StoneBlockSprite.visible = true
		BlockPlacement.DIRT_BLOCK_TYPE:
			$BlockCount/DirtBlockSprite.visible = true
		BlockPlacement.SAND_BLOCK_TYPE:
			$BlockCount/SandBlockSprite.visible = true
