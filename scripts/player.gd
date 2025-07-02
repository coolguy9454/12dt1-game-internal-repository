extends CharacterBody2D

var bullet_scene = preload("res://scenes/bullet.tscn")
const SPEED = 300
var can_shoot: bool = true
var player_health: int = 5
var score: int = 0

@onready var shooting_part = $ShootingPart
@onready var is_reloading = false

@export var ui: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	velocity.x = Input.get_axis("left", "right") * SPEED
	velocity.y = Input.get_axis("up", "down") * SPEED
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	if can_shoot:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = shooting_part.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		can_shoot = false
		$Timer.start()
		
		$/root/Game.add_child(bullet)
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("enemies"):
			player_health -= 1
			
			if player_health <= 0 and not is_reloading:
				is_reloading = true
				get_tree().reload_current_scene()


func _bullet_cooldown() -> void:
	can_shoot = true
	

func increase_score():
	score += 1
	ui.value = score
