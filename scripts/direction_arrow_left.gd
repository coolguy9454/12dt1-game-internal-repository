extends Area2D

@onready var arrow_animation = $AnimatedArrow

const ARROW_ANIMATION_NAME = "arrow animation"


func _ready() -> void:
	hide()
	

func _process(delta: float) -> void:
	# Play animation of direction arrow
	arrow_animation.play(ARROW_ANIMATION_NAME)
