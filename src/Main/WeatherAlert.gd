extends Control

signal alert_finished

func alert() -> void:
	self.visible = true
	$Timer.start()
	$AudioStreamPlayer.play()

func _on_Timer_timeout():
	self.visible = false
	emit_signal("alert_finished")


func _on_AudioStreamPlayer_finished():
	if self.visible:
		$AudioStreamPlayer.play()
