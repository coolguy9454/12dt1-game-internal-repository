extends Area2D

@onready var arrow_animation = $AnimatedArrow


func _physics_process(delta: float) -> void:
	arrow_animation.play("arrow animation")
