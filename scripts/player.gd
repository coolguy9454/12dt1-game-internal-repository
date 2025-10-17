extends CharacterBody2D


var ninji_star_scene = preload("res://scenes/ninji star.tscn")
var shield_scene = preload("res://scenes/shield.tscn")
var curse_of_bible_scene = preload("res://scenes/curse of bible.tscn")


var speed = 200
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
@onready var player_animation = $AnimatedSprite2D

@export var health_ui: Node

const health_bar_layer = 99
const player_layer = 98
const control_up = "up"
const control_down = "down"
const control_left = "left"
const control_right = "right"
const player_walking_animation = "walk"
const player_idle_animation = "idle"
const player_velocity_boundary = 0
const enemies_group = "enemies"
const player_min_health = 0
const dead_screen_scene = "res://scenes/dead screen.tscn"
const increase_movement_speed = 50
const increase_max_hp = 10
const increase_hp = 10
const ninji_star_cool_down_decrease = 0.1
const reduce_damage_from_enemies = 0.5


func _ready() -> void:
	# Set up player's health
	health_ui.z_index = health_bar_layer
	player_animation.z_index = player_layer
	

func _physics_process(delta: float) -> void:
	# Player's aim is controlled by mouse pointer
	shooting_part.look_at(get_global_mouse_position())
	
	# Player's movement is controlled by 'w, a, s, d'
	var v_direction: float = Input.get_axis(control_up, control_down)
	var h_direction: float = Input.get_axis(control_left, control_right)
	
	var direction: Vector2 = Vector2(h_direction, v_direction).normalized()
	
	velocity = direction * speed
	
	# Animation of the player
	if velocity.x < player_velocity_boundary:
		player_animation.flip_h = true
		player_animation.play(player_walking_animation)
	elif velocity.x > player_velocity_boundary:
		player_animation.flip_h = false
		player_animation.play(player_walking_animation)
	else:
		player_animation.play(player_idle_animation)
	
	# Ninji star shoot out
	if can_shoot:
		var ninji_star = ninji_star_scene.instantiate()
		ninji_star.global_position = shooting_part.global_position
		ninji_star.direction = (get_global_mouse_position() - global_position).normalized()
		can_shoot = false
		timer.start()
		
		game.add_child(ninji_star)
	
	move_and_slide()
	
	# Detect collision with the enemies
	for colide in range(get_slide_collision_count()):
		var collision = get_slide_collision(colide)
		
		# Take away player's health
		if collision.get_collider().is_in_group(enemies_group):
			player_health -= enemy_damage
			health_ui.value = player_health
			
			# Detect if player's health is 0
			if player_health <= player_min_health and not is_reloading:
				is_reloading = true
				# Navigate end users to dead screen
				get_tree().change_scene_to_file(dead_screen_scene)


func _bullet_cooldown() -> void:
	# If timer hit 0, then player can shoot
	can_shoot = true
	
	
func speed_increase():
	# Increase player's movement speed
	speed += increase_movement_speed
	print(speed)
	
	
func increase_max_health():
	# Increase player's max health
	health_ui.max_value += increase_max_hp
	health_ui.value += increase_hp
	print(health_ui.max_value)
	
	
func decrease_ninji_star_cooldown():
	# shoot ninji star faster
	timer.wait_time -= ninji_star_cool_down_decrease
	print(timer.wait_time)
	
	
func deploy_shield():
	# Get player a shield
	var shield = shield_scene.instantiate()
	game.add_child(shield)
	enemy_damage -= reduce_damage_from_enemies
	
	
func deploy_curse_of_bible():
	# Get player a curse of bible as an attacking skill
	var curse_of_bible = curse_of_bible_scene.instantiate()
	game.add_child(curse_of_bible)
