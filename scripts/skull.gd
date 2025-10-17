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
const walk_animation = "walk"
const flash_animaiton = "Flash"
const direction_boundary = 0
const skull_min_health = 0
const explosion_min_life_time = 0.2
const explosion_max_life_time = 0.4
const second_gem_drop_position_x = 20
const second_gem_drop_position_y = 0
const second_gem_drop_position = Vector2(20, 0)


func _physics_process(delta: float) -> void:
	# Follow the player at the velocity of 'SPEED'
	velocity = (player.global_position - global_position).normalized() * SPEED
	
	# Play aniamtion of skull
	skull_animation.play(walk_animation)
	
	# Face in a direction towards the player
	if (player.position.x - position.x) < direction_boundary:
		skull_animation.flip_h = true
	else:
		skull_animation.flip_h = false
	
	move_and_slide()
		
		
func hit():
	flash_animation.play(flash_animaiton)
	
	# Takes damage from ninji star and curse of bibles
	enemy_health -= int(all_damage.text)
	
	# Increase player's point
	game.increase_score_by_hit()
	
	# Skull dies when health hit 0
	if enemy_health <= skull_min_health:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		explosion.emitting = true
		explosion.lifetime = randf_range(explosion_min_life_time, explosion_max_life_time)
		
		# Drop two gems when the skull enemy is killed
		var blue_gem = blue_gem_scene.instantiate()
		blue_gem.global_position = global_position
		
		var blue_gem_2 = blue_gem_scene.instantiate()
		blue_gem_2.global_position = global_position + second_gem_drop_position
		
		game.add_child(explosion)
		game.add_child(blue_gem)
		game.add_child(blue_gem_2)
		queue_free()
