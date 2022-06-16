extends CanvasLayer



func _on_AnimationPlayer_animation_finished(_anim_name):
	if _anim_name == "Fade":
		get_tree().change_scene("res://src/Main/Game.tscn")
	if _anim_name == "FadeCredits":
		get_tree().change_scene("res://src/UserInterface/Credits.tscn")
	if _anim_name == "FadeMainMenu":
		get_tree().change_scene("res://src/UserInterface/MainMenu.tscn")
	if _anim_name == "FadeSettings":
		get_tree().change_scene("res://Settings.tscn")
