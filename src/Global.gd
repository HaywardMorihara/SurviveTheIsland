extends Node

var coins_collected := 0

var upgrades := {
	"Stone": false,
	"BiggerIsland": false,
	"FreeHit": false,
	"FreeHitUsed": false
}


func _ready() -> void:
	var api_key_file = File.new()
	api_key_file.open("res://api_key.env", File.READ)
	var api_key = api_key_file.get_line()
	api_key_file.close()
	
	SilentWolf.configure({
		"api_key": api_key,
		"game_id": "SurviveTheIsland",
		"game_version": "1.0.0",
		"log_level": 2
	})

	
