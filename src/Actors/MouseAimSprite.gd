extends Sprite

var positions := [Vector2(0.0, 0.0), Vector2(16.0, 16.0), Vector2(0.0, 32.0), Vector2(-16.0, 16.0)]
var current_position_index := 1
var relative_position : Vector2

func _ready():
	relative_position = get_position()
	_animate()


func _on_Tween_tween_completed(object, key):
	_increment_position_index()
	_animate()


func _animate() -> void:
	$Tween.interpolate_property(
		self, 
		"position", 
		get_position(), 
		relative_position + positions[current_position_index], 
		0.3, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN)
	$Tween.start()
	
	
func _increment_position_index() -> void:
	current_position_index += 1
	if current_position_index == positions.size():
		current_position_index = 0.0
