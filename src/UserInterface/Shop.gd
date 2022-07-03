extends Control

func _ready():
	Global.coins_collected = 1000

func _on_Stone_pressed():
	if Global.coins_collected >= 25 and not Global.upgrades['Stone']:
		Global.coins_collected -= 25
		Global.upgrades['Stone'] = true


func _on_BiggerIsland_pressed():
	if Global.coins_collected >= 50 and not Global.upgrades['BiggerIsland']:
		Global.coins_collected -= 50
		Global.upgrades['BiggerIsland'] = true


func _on_OneFreeHit_pressed():
	if Global.coins_collected >= 100 and not Global.upgrades['FreeHit']:
		Global.coins_collected -= 100
		Global.upgrades['FreeHit'] = true


func _on_Back_pressed():
	$Transition/Background/AnimationPlayer.play("FadeGameOver")
