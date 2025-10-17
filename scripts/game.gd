extends Node2D

var slime_scene = preload("res://scenes/slime.tscn")
var skull_scene = preload("res://scenes/skull.tscn")

@onready var player = $Player
@onready var level_up_menu = $CanvasLayer/LevelUpMenu
@onready var pause_dark_screen = $CanvasLayer/PauseDarkScreen
@onready var score_label = $CanvasLayer/Score
@onready var enemy_spawn_path = $Player/Path2D/PathFollow2D
@onready var enemy_spawn_position = $Player/Path2D/PathFollow2D/Marker2D
@onready var timer = $Timer
@onready var game_music = $CanvasLayer/GameMusic
@onready var cross_pillar_1 = $CanvasLayer/PauseButton/CrossPillar
@onready var cross_pillar_2 = $CanvasLayer/PauseButton/CrossPillar2
@onready var pause_pillar_1 = $CanvasLayer/PauseButton/PausePillar
@onready var pause_pillar_2 = $CanvasLayer/PauseButton/PausePillar2
@onready var music_button = $CanvasLayer/PauseButton/MusicButton

var game_paused: bool = false

@export var all_damage_ui: Node
@export var ninji_star_speed_ui: Node
var all_damage: int = 2
var ninji_star_speed: int = 5

@export var exp_ui: Node
var exp: int = 0
var score: int = 0
var exp_ascension: int = 1

@export var sprite_scene: PackedScene
const NUMBER_OF_TILES_BOOKSHALF: int = 134 
const HORIZONTAL_SPACING_BOOKSHALF: int = 130  
const X_OFFSET_BOOKSHALF: int = -8291 

@export var area_scene: PackedScene
const NUMBER_OF_TILES_DESK: int = 24 
const HORIZONTAL_SPACING_DESK: int = 700 
const X_OFFSET_DESK: int = -7800 
const Y_OFFSET_DESK: int = 250
const starting_max_ui_value: int = 8
const y_axis: int = 0
const enemies_spawn_prograss_min = 0
const enemies_spawn_prograss_max = 3446
const enemies_spawn_range_max_left = 600
const enemies_spawn_range_min_left = 0
const enemies_spawn_range_min_right = 1800
const enemies_spawn_range_max_right = 2400
const skull_spawn_asension_level = 3
const gem_exp = 2
const score_per_gem = 10
const score_per_hit = 2
const points_label = "PT: "
const exp_asension_per_max = 1
const xp_bar_max_value_multiplier = 8
const exp_base_line = 0
const second_ascension = 2
const fouth_ascension = 4
const sixth_ascension = 6
const seventh_ascension = 7
const second_ascension_spawn_wait_time = 2.5
const fouth_ascension_spawn_wait_time = 2.0
const sixth_ascension_spawn_wait_time = 1.0
const seventh_ascension_spawn_wait_time = 0.5
const increase_all_attack_damage = 2
const ninji_star_speed_upgrade = 2


func _ready():
	# Make sure everything is set up correctly
	randomize()
	
	pause_dark_screen.visible = false
	level_up_menu.visible = false
	exp_ui.max_value = starting_max_ui_value
	
	for i in range(NUMBER_OF_TILES_BOOKSHALF):
		# Set up bookshalfs along the hallway
		var sprite_instance = sprite_scene.instantiate()
		sprite_instance.position = Vector2(X_OFFSET_BOOKSHALF + i * HORIZONTAL_SPACING_BOOKSHALF, 
		y_axis)
		add_child(sprite_instance)
		
	for i in range(NUMBER_OF_TILES_DESK):
		# Set up desks along the hallway
		var area_instance = area_scene.instantiate()
		area_instance.position = Vector2(X_OFFSET_DESK + i * HORIZONTAL_SPACING_DESK, 
		Y_OFFSET_DESK)
		add_child(area_instance)
		
	game_music.play()


func _on_timer_timeout() -> void:
	# Enemies spawn when timer hit 0
	var redo: bool = true
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	while redo:
		# Get random spawn point and only on left and right side of the hallway
		enemy_spawn_path.progress = rng.randi_range(enemies_spawn_prograss_min, 
		enemies_spawn_prograss_max)
		
		if enemy_spawn_path.progress <= enemies_spawn_range_max_left: 
			if enemy_spawn_path.progress >= enemies_spawn_range_min_left:
				redo = false
		
		elif enemy_spawn_path.progress >= enemies_spawn_range_min_right:
			if enemy_spawn_path.progress <= enemies_spawn_range_max_right:
				redo = false
	
	# Spawn enemies
	var slime = slime_scene.instantiate()
	
	slime.global_position = enemy_spawn_position.global_position
	add_child(slime)
		
	if exp_ascension >= skull_spawn_asension_level:
		# Skulls only spawn the player levelled up 2 times or more
		var skull = skull_scene.instantiate()
		
		skull.global_position = enemy_spawn_position.global_position
		add_child(skull)
		

	
func increase_exp():
	# Xp bar gain 2 exp per gems that the player has collected
	exp += gem_exp
	exp_ui.value = exp
	
	# Points gain 10 per gems that the player has collected
	score += score_per_gem
	score_label.text = points_label + str(score)
	
	if exp >= exp_ui.max_value:
		# Game pause as end users is on level- up menu
		get_tree().paused = true
		pause_dark_screen.visible = true
		level_up_menu.visible = true
	
		# Player level up when their Xp bar is at max
		level_up_menu.get_three_unique_skills()
		level_up_menu.show_random_skills()
		

func finish_level_up():
	# Game resume after level up
	get_tree().paused = false
	pause_dark_screen.visible = false
	level_up_menu.visible = false
	
	# Xp bar value reset back to 0 and max value increase
	exp_ascension += exp_asension_per_max
	exp_ui.max_value = exp_ascension * xp_bar_max_value_multiplier
	exp = exp_base_line
	exp_ui.value = exp
	
	# Different ascension has different enemies spawn time
	if exp_ascension == second_ascension:
		timer.wait_time = second_ascension_spawn_wait_time
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
	if exp_ascension == fouth_ascension:
		timer.wait_time = fouth_ascension_spawn_wait_time
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
	if exp_ascension == sixth_ascension:
		timer.wait_time = sixth_ascension_spawn_wait_time 
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
	if exp_ascension == seventh_ascension:
		timer.wait_time = seventh_ascension_spawn_wait_time
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
		
func chest_opened():
	# Get to fastest spawn rate of enemies when player opened the chest
	exp_ascension = seventh_ascension
	timer.wait_time = seventh_ascension_spawn_wait_time
	var timer_wait_time = timer.wait_time
	print(timer_wait_time)


func increase_score_by_hit():
	# Player hit enemies with their skills gain 2 points
	score += score_per_hit
	score_label.text = points_label + str(score)
	

func increase_all_damage():
	# All Attack upgrade
	all_damage += increase_all_attack_damage
	all_damage_ui.text = str(all_damage)
	
	
func increase_ninji_star_speed():
	# Increase ninji star speed
	ninji_star_speed += ninji_star_speed_upgrade
	ninji_star_speed_ui.text = str(ninji_star_speed)


func _on_pause_button_pressed() -> void:
	# Pause the game
	if game_paused:
		get_tree().paused = false
		game_paused = false
		
		pause_dark_screen.hide()
		pause_pillar_1.show()
		pause_pillar_2.show()
		cross_pillar_1.hide()
		cross_pillar_2.hide()
		music_button.hide()
		
	else:
		# resume the game
		get_tree().paused = true
		game_paused = true
		
		pause_dark_screen.show()
		pause_pillar_1.hide()
		pause_pillar_2.hide()
		cross_pillar_1.show()
		cross_pillar_2.show()
		music_button.show()
	


func _on_music_button_toggled(toggled_on: bool) -> void:
	# On or off background music
	if toggled_on == false:
		game_music.stop()
	
	elif toggled_on:
		game_music.play()
