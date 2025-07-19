extends CharacterBody2D

var bullet_scene = preload("res://scenes/bullet.tscn")
const SPEED = 300
var can_shoot: bool = true
var player_health: int = 98
var score: int = 0

@onready var shooting_part = $ShootingPart
@onready var game = $/root/Game
@onready var is_reloading = false

@export var health_ui: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	velocity.x = Input.get_axis("left", "right") * SPEED
	velocity.y = Input.get_axis("up", "down") * SPEED
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	health_ui.rotation = -rotation
	
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
			player_health -= 2
			health_ui.value = player_health
			
			if player_health <= 0 and not is_reloading:
				is_reloading = true
				get_tree().change_scene_to_file("res://scenes/dead screen.tscn")


func _bullet_cooldown() -> void:
	can_shoot = true
	
