class_name BlockPlacement
extends Position2D

# TODO Thinking that, instead of shooting a bullet, we can reuse this logic for placing blocks

# The Cooldown timer controls the cooldown duration block placements.


# TODO Replace this with "Blocks"
#const Bullet = preload("res://src/Objects/Bullet.tscn")

onready var sound_shoot = $Shoot
onready var timer = $Cooldown


# This method is only called by Player.gd.
func place(direction = 1):
	if not timer.is_stopped():
		return false
#	var bullet = Bullet.instance()
#	bullet.global_position = global_position
#	bullet.linear_velocity = Vector2(direction * BULLET_VELOCITY, 0)
#
#	bullet.set_as_toplevel(true)
#	add_child(bullet)
#	sound_shoot.play()
	timer.start()
	return true
