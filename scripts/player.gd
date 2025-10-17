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
@onready var animatedsprite_2d = $AnimatedSprite2D

@export var health_ui: Node


func _ready() -> void:
	# Set up player's health
	health_ui.z_index = 99
	animatedsprite_2d.z_index = 98
	

func _physics_process(delta: float) -> void:
	# Player's aim is controlled by mouse pointer
	shooting_part.look_at(get_global_mouse_position())
	
	# Player's movement is controlled by 'w, a, s, d'
	var v_direction: float = Input.get_axis("up", "down")
	var h_direction: float = Input.get_axis("left", "right")
	
	var direction: Vector2 = Vector2(h_direction, v_direction).normalized()
	
	velocity = direction * speed
	
	# Animation of the player
	if velocity.x < 0:
		animatedsprite_2d.flip_h = true
		animatedsprite_2d.play("walk")
	elif velocity.x > 0:
		animatedsprite_2d.flip_h = false
		animatedsprite_2d.play("walk")
	else:
		animatedsprite_2d.play("idle")
	
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
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		
		# Take away player's health
		if collision.get_collider().is_in_group("enemies"):
			player_health -= enemy_damage
			health_ui.value = player_health
			
			# Detect if player's health is 0
			if player_health <= 0 and not is_reloading:
				is_reloading = true
				# Navigate end users to dead screen
				get_tree().change_scene_to_file("res://scenes/dead screen.tscn")


func _bullet_cooldown() -> void:
	# If timer hit 0, then player can shoot
	can_shoot = true
	
	
func speed_increase():
	# Increase player's movement speed
	speed += 50
	print(speed)
	
	
func increase_max_health():
	# Increase player's max health
	health_ui.max_value += 10
	health_ui.value += 10
	print(health_ui.max_value)
	
	
func decrease_ninji_star_cooldown():
	# shoot ninji star faster
	timer.wait_time -= 0.1
	print(timer.wait_time)
	
	
func deploy_shield():
	# Get player a shield
	var shield = shield_scene.instantiate()
	game.add_child(shield)
	enemy_damage -= 0.5
	
	
func deploy_curse_of_bible():
	# Get player a curse of bible as an attacking skill
	var curse_of_bible = curse_of_bible_scene.instantiate()
	game.add_child(curse_of_bible)
