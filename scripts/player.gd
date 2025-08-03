extends CharacterBody2D


var bullet_scene = preload("res://scenes/bullet.tscn")
var shield_scene = preload("res://scenes/shield.tscn")


var speed = 300
var can_shoot: bool = true
var player_health: int = 1950
var score: int = 0
var is_reloading = false
var enemy_damage: float = 1.0

@onready var shooting_part = $ShootingPart
@onready var game = $/root/Game
@onready var player = $Polygon2D
@onready var path_2d = $Path2D
@onready var timer = $Timer

@export var health_ui: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.z_index = 100
	player.z_index = 98


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	velocity.x = Input.get_axis("left", "right") * speed
	velocity.y = Input.get_axis("up", "down") * speed
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	health_ui.rotation = -rotation
	path_2d.rotation = -rotation


	if can_shoot:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = shooting_part.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		can_shoot = false
		$Timer.start()
		
		game.add_child(bullet)
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("enemies"):
			player_health -= enemy_damage
			health_ui.value = player_health
			
			if player_health <= 0 and not is_reloading:
				is_reloading = true
				get_tree().change_scene_to_file("res://scenes/dead screen.tscn")


func _bullet_cooldown() -> void:
	can_shoot = true
	
	
func speed_increase():
	speed += 50
	print(speed)
	
func increase_max_health():
	health_ui.max_value += 10
	health_ui.value += 10
	print(health_ui.max_value)
	
func increase_bullet_speed():
	timer.wait_time -= 0.05
	print(timer.wait_time)
	
func deploy_shield():
	var shield = shield_scene.instantiate()
	game.add_child(shield)
	$CollisionShape2D.shape.radius = 40
	enemy_damage -= 0.2
	
