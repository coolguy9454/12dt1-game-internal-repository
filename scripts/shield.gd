extends Area2D

@onready var player = $/root/Game/Player


func _physics_process(delta: float) -> void:
	global_position = player.global_position
	
	z_index = 99
	



func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
