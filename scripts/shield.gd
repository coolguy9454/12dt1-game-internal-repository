extends Area2D

@onready var player = $/root/Game/Player

const SHIELD_LAYER = 99


func _physics_process(delta: float) -> void:
	# Follow player
	global_position = player.global_position
	
	# Higher layer than enemies, player, bookshalf, desk, and more
	z_index = SHIELD_LAYER
