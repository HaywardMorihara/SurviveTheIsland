extends Control

func _ready():
	$Menu.play()
	$Play.grab_focus()

func _on_Play_pressed():
	$Transition/Background/AnimationPlayer.play("Fade")



func _on_Leaderboard_pressed():
	$Transition/Background/AnimationPlayer.play("FadeLeaderboard")



func _on_Credits_pressed():
	$Transition/Background/AnimationPlayer.play("FadeCredits")



func _on_Exit_pressed():
	get_tree().quit()
