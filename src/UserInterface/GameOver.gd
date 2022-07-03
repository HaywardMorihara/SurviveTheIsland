extends Control

func _ready():
	$Play.grab_focus()


func _on_Play_pressed():
	$Transition/Background/AnimationPlayer.play("Fade")


func _on_Credits_pressed():
	$Transition/Background/AnimationPlayer.play("FadeCredits")


func _on_Exit_pressed():
	get_tree().quit()

func _on_Shop_pressed():
	$Transition/Background/AnimationPlayer.play("FadeShop")

func _on_Leaderboard_pressed():
	$Transition/Background/AnimationPlayer.play("FadeLeaderboard")
