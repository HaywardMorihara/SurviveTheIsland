extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_block_count(current_block_type : String, count : int) -> void:
	$BlockCount/BlockCountLabel.set_text("x" + str(count))


# TODO Changing Block Type
