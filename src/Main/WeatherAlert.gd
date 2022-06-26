extends Control

signal alert_finished

var msg := "WARNING: INCOMING STORM\nMagnitude: "

func alert(magnitude) -> void:
	self.visible = true
	$Timer.start()
	$AudioStreamPlayer.play()
	$RichTextLabel.text = msg + str(magnitude)


func _on_Timer_timeout():
	self.visible = false
	emit_signal("alert_finished")


func _on_AudioStreamPlayer_finished():
	if self.visible:
		$AudioStreamPlayer.play()
