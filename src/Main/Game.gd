extends Node
# This class contains controls that should always be accessible, like pausing
# the game or toggling the window full-screen.


# The "_" prefix is a convention to indicate that variables are private,
# that is to say, another node or script should not access them.
onready var _pause_menu = $InterfaceLayer/PauseMenu
onready var animation_player = $Transition/Background/AnimationPlayer

var eruption = load("res://src/Weather/Eruption.gd").new()
var earthquake = load("res://src/Weather/Earthquake.gd").new()

enum Storm {
	ERUPTION = 0,
	EARTHQUAKE = 1,
}
var incoming_storm : int

var coins_collected := 0

var lava_rise_counter := 0


func _ready():
	Global.coins_collected = 0
	Global.upgrades['FreeHitUsed'] = false


func _init():
	OS.min_window_size = OS.window_size
	OS.max_window_size = OS.get_screen_size()

func _process(delta):
	if lava_rise_counter > 31:
		lava_rise_counter = 0
	$Level/FallDeath.position.y -= 0.1
	if lava_rise_counter == 0:
		for i in range(-38, 37):
			$Level/TileMap2.set_cell(i,($Level/FallDeath.position.y-1550)/32,0)
		print($Level/FallDeath.position.y)
	lava_rise_counter += 1

func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		# We need to clean up a little bit first to avoid Viewport errors.
		if name == "Splitscreen":
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()
	if what == NOTIFICATION_PARENTED:
		# Have to wait until the child is instanced before setting this
		eruption.set_level_bounds($Level.LIMIT_LEFT, $Level.LIMIT_TOP, $Level.LIMIT_RIGHT, $Level.LIMIT_BOTTOM)
		

func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("toggle_pause"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_tree().set_input_as_handled()

	elif event.is_action_pressed("splitscreen"):
		if name == "Splitscreen":
			# We need to clean up a little bit first to avoid Viewport errors.
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Game.tscn")
		else:
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://src/Main/Splitscreen.tscn")


func _on_WeatherTimer_timeout():
	$CanvasModulate.visible = true
	# https://gdscript.com/solutions/random-numbers/
	incoming_storm = randi() % 2
	match incoming_storm:
		Storm.ERUPTION:
			$InterfaceLayer/WeatherAlert.alert(eruption.magnitude)
		Storm.EARTHQUAKE:
			$InterfaceLayer/WeatherAlert.alert(earthquake.magnitude)	


func _on_WeatherAlert_alert_finished():
	$CanvasModulate.visible = false
	
	match incoming_storm:
		Storm.ERUPTION:
			var lava_pieces = eruption.start()
			for lp in lava_pieces:
				self.add_child(lp)
				lp.connect("place_coin", $Level/Coins, "_on_LavaPiece_place_coin")
				lp.connect("hit_player", self, "_on_LavaPiece_hit_player")
			$Level/Player/Camera.add_trauma(0.3)
		Storm.EARTHQUAKE:
			$Level/Player/Camera.add_trauma(0.5 + (float(earthquake.magnitude) * 0.05))
			$SFX/Rumble.play()
			earthquake.start($Level/TileMap, get_tree().get_nodes_in_group("blocks"))
	
	$WeatherTimer.start()


func _on_Level_player_out_of_bounds():
	animation_player.play("FadeGameOver")


func _on_LavaPiece_hit_player():
	if Global.upgrades['FreeHit'] and not Global.upgrades['FreeHitUsed']:
		Global.upgrades['FreeHitUsed'] = true
	else:
		animation_player.play("FadeGameOver")
