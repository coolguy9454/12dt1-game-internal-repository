extends CharacterBody2D

@onready var player = $/root/Game/Player
@onready var game = $/root/Game
@onready var ninji_star_damage = $/root/Game/CanvasLayer/NinjiStarDamage
@onready var flash_animation: AnimationPlayer = $AnimatedSprite2D/FlashAnimation
@onready var animated_sprite_2d = $AnimatedSprite2D

var explosion_scene = preload("res://scenes/explosion.tscn")
var blue_gem_scene = preload("res://scenes/blue gems.tscn")

var enemy_health: int = 10
var score: int = 0
const SPEED = 60


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = (player.global_position - global_position).normalized() * SPEED
	
	animated_sprite_2d.play("walk")
	
	if (player.position.x - position.x) < 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	
	move_and_slide()
		
		
func hit():
	flash_animation.play("Flash")
	
	enemy_health -= int(ninji_star_damage.text)
	
	game.increase_score_by_hit()
	
	if enemy_health <= 0:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		explosion.emitting = true
		explosion.lifetime = randf_range(0.2, 0.4)
		
		var blue_gem = blue_gem_scene.instantiate()
		blue_gem.global_position = global_position
		
		game.add_child(explosion)
		game.add_child(blue_gem)
		queue_free()
		
