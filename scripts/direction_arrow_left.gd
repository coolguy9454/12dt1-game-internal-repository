extends Area2D

@onready var arrow_animation = $AnimatedArrow


func _ready() -> void:
	hide()
	

func _process(delta: float) -> void:
	# Play animation of direction arrow
	arrow_animation.play("arrow animation")
