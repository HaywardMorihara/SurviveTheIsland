extends Control

func _ready():
	$"MainMenu".grab_focus()
	$Menu.play()

func _on_MainMenu_pressed():
	$Transition/Background/AnimationPlayer.play("FadeMainMenu")
