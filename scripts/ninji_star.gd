extends Area2D

@export var ninji_star_animation: AnimatedSprite2D
@onready var ninji_star_speed = $/root/Game/CanvasLayer/NinjiStarSpeed

var direction: Vector2

const NINJI_STAR_SPIN_ANIMATION = "spin"
const ENEMIES_GROUP = "enemies"


func _physics_process(delta: float) -> void:
	# Play the animation of ninji star spinning
	ninji_star_animation.play(NINJI_STAR_SPIN_ANIMATION)
	
	# Shoot at the direction of where the player is aiming and at a certain speed
	global_position += direction * int(ninji_star_speed.text)


func _on_body_entered(body: Node2D) -> void:
	# If ninji star hit enemies, ninji star will disappear
	if body.is_in_group(ENEMIES_GROUP):
		body.hit()
		queue_free()
		
