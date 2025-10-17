extends Area2D

@onready var arrow_animation = $AnimatedArrow

const arrow_animation_name = "arrow animation"


func _ready() -> void:
	hide()
	

func _process(delta: float) -> void:
	# Play animation of direction arrow
	arrow_animation.play(arrow_animation_name)
