extends CharacterBody2D

@onready var player = $/root/Game/Player
@onready var game = $/root/Game
@onready var all_damage = $/root/Game/CanvasLayer/AllDamage
@onready var flash_animation: AnimationPlayer = $AnimatedSprite2D/FlashAnimation
@onready var skull_animation = $AnimatedSprite2D

var explosion_scene = preload("res://scenes/explosion.tscn")
var blue_gem_scene = preload("res://scenes/blue gems.tscn")

var enemy_health: int = 15
var score: int = 0
const SPEED = 60
const WALK_ANIMATION = "walk"
const FLASH_ANIMATION = "Flash"
const DIRECTION_BOUNDARY = 0
const SKULL_MIN_HEALTH = 0
const EXPLOSION_MIN_LIFE_TIME = 0.2
const EXPLOSION_MAX_LIFE_TIME = 0.4
const SECOND_GEM_DROP_POSITION_X = 20
const SECOND_GEM_DROP_POSITION_Y = 0
const SECOND_GEM_DROP_POSITION = Vector2(20, 0)


func _physics_process(delta: float) -> void:
	# Follow the player at the velocity of 'SPEED'
	velocity = (player.global_position - global_position).normalized() * SPEED
	
	# Play aniamtion of skull
	skull_animation.play(WALK_ANIMATION)
	
	# Face in a direction towards the player
	if (player.position.x - position.x) < DIRECTION_BOUNDARY:
		skull_animation.flip_h = true
	else:
		skull_animation.flip_h = false
	
	move_and_slide()
		
		
func hit():
	flash_animation.play(FLASH_ANIMATION)
	
	# Takes damage from ninji star and curse of bibles
	enemy_health -= int(all_damage.text)
	
	# Increase player's point
	game.increase_score_by_hit()
	
	# Skull dies when health hit 0
	if enemy_health <= SKULL_MIN_HEALTH:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		explosion.emitting = true
		explosion.lifetime = randf_range(EXPLOSION_MIN_LIFE_TIME, EXPLOSION_MAX_LIFE_TIME)
		
		# Drop two gems when the skull enemy is killed
		var blue_gem = blue_gem_scene.instantiate()
		blue_gem.global_position = global_position
		
		var blue_gem_2 = blue_gem_scene.instantiate()
		blue_gem_2.global_position = global_position + SECOND_GEM_DROP_POSITION
		
		game.add_child(explosion)
		game.add_child(blue_gem)
		game.add_child(blue_gem_2)
		queue_free()
