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

const HEALTH_BAR_LAYER = 99
const PLAYER_LAYER = 98
const CONTROL_UP = "up"
const CONTROL_DOWN = "down"
const CONTROL_LEFT = "left"
const CONTROL_RIGHT = "right"
const PLAYER_WALKING_ANIMATION = "walk"
const PLAYER_IDLE_ANIMATION = "idle"
const PLAYER_VELOCITY_BOUNDARY = 0
const ENEMIES_GROUP = "enemies"
const PLAYER_MIN_HEALTH = 0
const DEAD_SCREEN_SCENE = "res://scenes/dead screen.tscn"
const INCREASE_MOVEMENT_SPEED = 50
const INCREASE_MAX_HP = 10
const INCREASE_HP = 10
const NINJI_STAR_COOL_DOWN_DECREASE = 0.1
const REDUCE_DAMAGE_FROM_ENEMIES = 0.5


func _ready() -> void:
	# Set up player's health
	health_ui.z_index = HEALTH_BAR_LAYER
	player_animation.z_index = PLAYER_LAYER
	

func _physics_process(delta: float) -> void:
	# Player's aim is controlled by mouse pointer
	shooting_part.look_at(get_global_mouse_position())
	
	# Player's movement is controlled by 'w, a, s, d'
	var v_direction: float = Input.get_axis(CONTROL_UP, CONTROL_DOWN)
	var h_direction: float = Input.get_axis(CONTROL_LEFT, CONTROL_RIGHT)
	
	var direction: Vector2 = Vector2(h_direction, v_direction).normalized()
	
	velocity = direction * speed
	
	# Animation of the player
	if velocity.x < PLAYER_VELOCITY_BOUNDARY:
		player_animation.flip_h = true
		player_animation.play(PLAYER_WALKING_ANIMATION)
	elif velocity.x > PLAYER_VELOCITY_BOUNDARY:
		player_animation.flip_h = false
		player_animation.play(PLAYER_WALKING_ANIMATION)
	else:
		player_animation.play(PLAYER_IDLE_ANIMATION)
	
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
		if collision.get_collider().is_in_group(ENEMIES_GROUP):
			player_health -= enemy_damage
			health_ui.value = player_health
			
			# Detect if player's health is 0
			if player_health <= PLAYER_MIN_HEALTH and not is_reloading:
				is_reloading = true
				# Navigate end users to dead screen
				get_tree().change_scene_to_file(DEAD_SCREEN_SCENE)


func _bullet_cooldown() -> void:
	# If timer hit 0, then player can shoot
	can_shoot = true
	
	
func speed_increase():
	# Increase player's movement speed
	speed += INCREASE_MOVEMENT_SPEED
	print(speed)
	
	
func increase_max_health():
	# Increase player's max health
	health_ui.max_value += INCREASE_MAX_HP
	health_ui.value += INCREASE_HP
	print(health_ui.max_value)
	
	
func decrease_ninji_star_cooldown():
	# shoot ninji star faster
	timer.wait_time -= NINJI_STAR_COOL_DOWN_DECREASE
	print(timer.wait_time)
	
	
func deploy_shield():
	# Get player a shield
	var shield = shield_scene.instantiate()
	game.add_child(shield)
	enemy_damage -= REDUCE_DAMAGE_FROM_ENEMIES
	
	
func deploy_curse_of_bible():
	# Get player a curse of bible as an attacking skill
	var curse_of_bible = curse_of_bible_scene.instantiate()
	game.add_child(curse_of_bible)
