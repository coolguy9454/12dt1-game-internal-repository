extends CharacterBody2D

@onready var player = $/root/Game/Player
@onready var game = $/root/Game
@onready var all_damage = $/root/Game/CanvasLayer/AllDamage
@onready var flash_animation: AnimationPlayer = $AnimatedSprite2D/FlashAnimation
@onready var animated_sprite_2d = $AnimatedSprite2D

var explosion_scene = preload("res://scenes/explosion.tscn")
var blue_gem_scene = preload("res://scenes/blue gems.tscn")

var enemy_health: int = 10
var score: int = 0
const SPEED = 60


func _physics_process(delta: float) -> void:
	# Follow the player at the velocity of 'SPEED'
	velocity = (player.global_position - global_position).normalized() * SPEED
	
	# Play aniamtion of skull
	animated_sprite_2d.play("walk")
	
	# Face in a direction towards the player
	if (player.position.x - position.x) < 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	
	move_and_slide()
		
		
func hit():
	flash_animation.play("Flash")
	
	# Takes damage from ninji star and curse of bibles
	enemy_health -= int(all_damage.text)
	
	# Increase player's point
	game.increase_score_by_hit()
	
	# Slime dies when health hit 0
	if enemy_health <= 0:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		explosion.emitting = true
		explosion.lifetime = randf_range(0.2, 0.4)
		
		# Drop a gem when the slime enemy is killed
		var blue_gem = blue_gem_scene.instantiate()
		blue_gem.global_position = global_position
		
		game.add_child(explosion)
		game.add_child(blue_gem)
		queue_free()
		
