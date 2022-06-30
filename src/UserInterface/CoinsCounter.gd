extends Panel

onready var coins_label = $Label

func _ready():
	if self.name == 'StoneCost':
		coins_label.set_text(str(100))
	else:
		coins_label.set_text(str(10))
	var anim_sprite: AnimatedSprite = $AnimatedSprite
	anim_sprite.play()
