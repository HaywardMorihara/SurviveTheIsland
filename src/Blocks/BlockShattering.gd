extends Node2D


func _ready():
	$CPUParticles2D.restart()


func _on_SelfDestructTimer_timeout():
	queue_free()
