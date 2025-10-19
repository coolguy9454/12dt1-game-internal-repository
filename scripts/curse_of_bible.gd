extends Area2D

@onready var player = $/root/Game/Player
@onready var player_animatedsprite_2d = $/root/Game/Player/AnimatedSprite2D
@onready var curse_of_bible_animation = $AnimatedSprite2D
@onready var hit_box = $CollisionShape2D
@onready var timer = $Timer

const LAYER = 97
const COLLISION_SHAPE_POSITION_FLIP_H_FALSE = 68.0
const COLLISION_SHAPE_POSITION_FLIP_H_TRUE = -68.0
const LAST_ANIMATION_FRAME = 5
const BIG_COLLISION_SHAPE = 1.0
const NO_COLLISION_SHAPE = 0.0

const ATTACK_ANIMATION = "attack"
const ENEMIES = "enemies"


func _physics_process(delta: float) -> void:
	# Go to player
	global_position = player.global_position
	z_index = LAYER
	
	# Face direction of player
	if player_animatedsprite_2d.flip_h == false:
		curse_of_bible_animation.flip_h = true
		hit_box.position.x = COLLISION_SHAPE_POSITION_FLIP_H_FALSE
		
	elif player_animatedsprite_2d.flip_h == true:
		curse_of_bible_animation.flip_h = false
		hit_box.position.x = COLLISION_SHAPE_POSITION_FLIP_H_TRUE
	
	# PLay animation
	curse_of_bible_animation.play(ATTACK_ANIMATION)
	
	# Hit enemies at the right timing
	if curse_of_bible_animation.get_frame() == LAST_ANIMATION_FRAME:
		hit_box.scale.x = BIG_COLLISION_SHAPE
		hit_box.scale.y = BIG_COLLISION_SHAPE
	else:
		hit_box.scale.x = NO_COLLISION_SHAPE
		hit_box.scale.y = NO_COLLISION_SHAPE


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(ENEMIES):
		body.hit()
