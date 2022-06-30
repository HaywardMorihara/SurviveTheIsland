extends Control

func _ready():
	Global.coins_collected = 500

func _on_Stone_pressed():
	if Global.coins_collected > 50:
		Global.coins_collected -= 50
		Global.upgrades['Stone'] = true


func _on_BiggerIsland_pressed():
	pass # Replace with function body.


func _on_OneFreeHit_pressed():
	pass # Replace with function body.
