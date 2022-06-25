extends Node
# This class contains controls that should always be accessible, like pausing
# the game or toggling the window full-screen.


# The "_" prefix is a convention to indicate that variables are private,
# that is to say, another node or script should not access them.
onready var _pause_menu = $InterfaceLayer/PauseMenu

var eruption = load("res://src/Weather/Eruption.gd").new()


func _init():
	OS.min_window_size = OS.window_size
	OS.max_window_size = OS.get_screen_size()


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
	# The GlobalControls node, in the Stage scene, is set to process even
	# when the game is paused, so this code keeps running.
	# To see that, select GlobalControls, and scroll down to the Pause category
	# in the inspector.
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
	# https://gdscript.com/solutions/random-numbers/
	var random_weather := randi() % 1
	
	match random_weather:
		0:
			var lava_pieces = eruption.start()
			for lp in lava_pieces:
				self.add_child(lp)
				lp.connect("place_coin", $Level/Coins, "_on_LavaPiece_place_coin")
	
