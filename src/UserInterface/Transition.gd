extends CanvasLayer


func _on_AnimationPlayer_animation_finished(_anim_name):
	if _anim_name == "Fade":
		get_tree().change_scene("res://src/Main/Game.tscn")
	if _anim_name == "FadeCredits":
		get_tree().change_scene("res://src/UserInterface/Credits.tscn")
	if _anim_name == "FadeMainMenu":
		get_tree().change_scene("res://src/UserInterface/MainMenu.tscn")
	if _anim_name == "FadeLeaderboard":
		get_tree().change_scene("res://src/UserInterface/LeaderboardMenu.tscn")
	if _anim_name == "FadeGameOver":
		get_tree().change_scene("res://src/UserInterface/GameOver.tscn")
	if _anim_name == "FadeShop":
		get_tree().change_scene("res://src/UserInterface/Shop.tscn")
