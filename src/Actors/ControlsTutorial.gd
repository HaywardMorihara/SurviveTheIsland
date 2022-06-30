extends Control


# TODO Only show if playing on a computer? Didn't see a straightforward way to 
# do this, so considering it "Nice to Have"


var has_moved := false
var has_aimed := false
var has_picked_up_block := false
var has_placed_block := false
var has_switched_block_type := false


func _on_Timer_timeout():
	if OS.has_touchscreen_ui_hint():
		return
	$MovementKeys.visible = !has_moved
	if has_moved:
		$MouseAim.visible = !has_aimed
		if has_aimed:
			$MouseRightClick.visible = !has_picked_up_block
			if has_picked_up_block:
				$MouseLeftClick.visible = !has_placed_block
				if has_placed_block:
					$MouseScroll.visible = !has_switched_block_type
