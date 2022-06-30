extends Panel

onready var coins_label = $Label

func _ready():
	coins_label.set_text(str(Global.coins_collected))


func _process(delta):
	coins_label.set_text(str(Global.coins_collected))
