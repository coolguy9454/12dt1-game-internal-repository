extends Area2D

@onready var player = $/root/Game/Player
@onready var game = $/root/Game

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		game.increase_exp()
		
		queue_free()
