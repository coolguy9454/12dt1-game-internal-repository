extends Area2D

@export var animated_sprite_2d: AnimatedSprite2D
@onready var ninji_star_speed = $/root/Game/CanvasLayer/NinjiStarSpeed

var direction: Vector2


func _physics_process(delta: float) -> void:
	# Play the animation of ninji star spinning
	animated_sprite_2d.play("spin")
	
	# Shoot at the direction of where the player is aiming and at a certain speed
	global_position += direction * int(ninji_star_speed.text)


func _on_body_entered(body: Node2D) -> void:
	# If ninji star hit enemies, ninji star will disappear
	if body.is_in_group("enemies"):
		body.hit()
		queue_free()
		
