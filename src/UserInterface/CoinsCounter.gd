extends Panel

onready var coins_label = $Label

func _ready():
	coins_label.set_text(str(Global.coins_collected))
	# Static types are necessary here to avoid warnings.
	var anim_sprite: AnimatedSprite = $AnimatedSprite
	anim_sprite.play()


func _process(delta):
	coins_label.set_text(str(Global.coins_collected))
