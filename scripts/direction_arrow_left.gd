extends Area2D

@onready var arrow_animation = $AnimatedArrow


func _ready() -> void:
	hide()
	

func _process(delta: float) -> void:
	arrow_animation.play("arrow animation")
