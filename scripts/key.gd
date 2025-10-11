extends AnimatedSprite2D

@onready var player = $/root/Game/Player


func _physics_process(delta: float) -> void:
	global_position = player.global_position
