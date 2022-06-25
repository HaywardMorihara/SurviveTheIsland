extends Node2D

var coin_scene = preload("res://src/Objects/Coin.tscn")

func _on_LavaPiece_place_coin(pos):
	var coin = coin_scene.instance()
	coin.set_position(pos)
	self.add_child(coin)
