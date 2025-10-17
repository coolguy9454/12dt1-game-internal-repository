extends Area2D

@onready var player = $/root/Game/Player
@onready var player_animatedsprite_2d = $/root/Game/Player/AnimatedSprite2D
@onready var animatedsprite_2d = $AnimatedSprite2D
@onready var collisionshape_2d = $CollisionShape2D
@onready var timer = $Timer


func _physics_process(delta: float) -> void:
	
	global_position = player.global_position
	z_index = 97
	
	if player_animatedsprite_2d.flip_h == false:
		animatedsprite_2d.flip_h = true
		collisionshape_2d.position.x = 68.0
		
	elif player_animatedsprite_2d.flip_h == true:
		animatedsprite_2d.flip_h = false
		collisionshape_2d.position.x = -68.0
	
	animatedsprite_2d.play("attack")
	
	
	if animatedsprite_2d.get_frame() == 5:
		collisionshape_2d.scale.x = 1.0
		collisionshape_2d.scale.y = 1.0
		
	elif animatedsprite_2d.get_frame() != 5:
		collisionshape_2d.scale.x = 0.0
		collisionshape_2d.scale.y = 0.0

	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.hit()
