extends CharacterBody2D

@onready var player = $/root/Game/Player
@onready var game = $/root/Game
@onready var all_damage = $/root/Game/CanvasLayer/AllDamage
@onready var flash_animation: AnimationPlayer = $AnimatedSprite2D/FlashAnimation
@onready var slime_animation = $AnimatedSprite2D

var explosion_scene = preload("res://scenes/explosion.tscn")
var blue_gem_scene = preload("res://scenes/blue gems.tscn")

var enemy_health: int = 10
var score: int = 0
const SPEED = 60
const slime_walking_animation = "walk"
const direction_boundary = 0
const slime_flash = "Flash"
const min_slime_health = 0
const min_explosion_life_time = 0.2
const max_explosion_life_time = 0.4


func _physics_process(delta: float) -> void:
	# Follow the player at the velocity of 'SPEED'
	velocity = (player.global_position - global_position).normalized() * SPEED
	
	# Play aniamtion of skull
	slime_animation.play(slime_walking_animation)
	
	# Face in a direction towards the player
	if (player.position.x - position.x) < direction_boundary:
		slime_animation.flip_h = false
	else:
		slime_animation.flip_h = true
	
	move_and_slide()
		
		
func hit():
	flash_animation.play(slime_flash)
	
	# Takes damage from ninji star and curse of bibles
	enemy_health -= int(all_damage.text)
	
	# Increase player's point
	game.increase_score_by_hit()
	
	# Slime dies when health hit 0
	if enemy_health <= min_slime_health:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		explosion.emitting = true
		explosion.lifetime = randf_range(min_explosion_life_time, max_explosion_life_time)
		
		# Drop a gem when the slime enemy is killed
		var blue_gem = blue_gem_scene.instantiate()
		blue_gem.global_position = global_position
		
		game.add_child(explosion)
		game.add_child(blue_gem)
		queue_free()
		
