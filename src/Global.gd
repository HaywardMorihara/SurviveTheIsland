extends Node

var coins_collected := 0


func _ready() -> void:
	var api_key_file = File.new()
	api_key_file.open("res://api_key.env", File.READ)
	var api_key = api_key_file.get_line()
	api_key_file.close()
	
	SilentWolf.configure({
		"api_key": api_key,
		"game_id": "SurviveTheIsland",
		"game_version": "0.0.1",
		"log_level": 2
	})

	
