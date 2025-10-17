extends Area2D

@onready var player = $/root/Game/Player
@onready var player_animatedsprite_2d = $/root/Game/Player/AnimatedSprite2D
@onready var curse_of_bible_animation = $AnimatedSprite2D
@onready var hit_box = $CollisionShape2D
@onready var timer = $Timer

const layer = 97
const collision_shape_position_flip_h_false = 68.0
const collision_shape_position_flip_h_true = -68.0
const last_animation_frame = 5
const big_collision_shape = 1.0
const no_collision_shape = 0.0

const attack_animation = "attack"
const enemies = "enemies"


func _physics_process(delta: float) -> void:
	
	global_position = player.global_position
	z_index = layer
	
	if player_animatedsprite_2d.flip_h == false:
		curse_of_bible_animation.flip_h = true
		hit_box.position.x = collision_shape_position_flip_h_false
		
	elif player_animatedsprite_2d.flip_h == true:
		curse_of_bible_animation.flip_h = false
		hit_box.position.x = collision_shape_position_flip_h_true
	
	curse_of_bible_animation.play(attack_animation)
	
	
	if curse_of_bible_animation.get_frame() == last_animation_frame:
		hit_box.scale.x = big_collision_shape
		hit_box.scale.y = big_collision_shape
		
	elif curse_of_bible_animation.get_frame() != last_animation_frame:
		hit_box.scale.x = no_collision_shape
		hit_box.scale.y = no_collision_shape

	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(enemies):
		body.hit()
