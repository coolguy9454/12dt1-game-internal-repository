extends CharacterBody2D

@onready var player = $/root/Game/Player
@onready var game = $/root/Game
@onready var flash_animation: AnimationPlayer = $AnimatedSprite2D/FlashAnimation

var explosion_scene = preload("res://scenes/explosion.tscn")
var enemy_health: int = 5
var score: int = 0
const SPEED = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = (player.global_position - global_position).normalized() * SPEED
	
	$AnimatedSprite2D.play("walk")
	
	if (player.position.x - position.x) < 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	
	move_and_slide()
		
func hit():
	flash_animation.play("Flash")
	
	enemy_health -= 1
	
	if enemy_health <= 0:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		explosion.emitting = true
		explosion.lifetime = randf_range(0.2, 0.4)
		
		$/root/Game.add_child(explosion)
		queue_free()
		
		player.increase_score()
		
