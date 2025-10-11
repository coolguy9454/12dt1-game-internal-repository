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

@export var ninji_star_damage_ui: Node
@export var ninji_star_speed_ui: Node
var ninji_star_damage: int = 2
var ninji_star_speed: int = 5

@export var exp_ui: Node
var exp: int = 0
var score: int = 0
var exp_ascension: int = 1

@export var sprite_scene: PackedScene
var number_of_tiles_bookshalf: int = 134
var horizontal_spacing_bookshalf: int = 130  
var x_offset_bookshalf: int = -8291

@export var area_scene: PackedScene
var number_of_tiles_desk: int = 26
var horizontal_spacing_desk: int = 700 
var x_offset_desk: int = -9000  
var y_offset_desk: int = 250

func _ready():
	
	randomize()
	
	pause_dark_screen.visible = false
	level_up_menu.visible = false
	exp_ui.max_value = 8
	
	for i in range(number_of_tiles_bookshalf):
		var sprite_instance = sprite_scene.instantiate()
		sprite_instance.position = Vector2(x_offset_bookshalf + i * horizontal_spacing_bookshalf, 0)
		add_child(sprite_instance)
		
	for i in range(number_of_tiles_desk):
		var area_instance = area_scene.instantiate()
		area_instance.position = Vector2(x_offset_desk + i * horizontal_spacing_desk, y_offset_desk)
		add_child(area_instance)
		
	game_music.play()


func _on_timer_timeout() -> void:
	var redo: bool = true
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	while redo:
		enemy_spawn_path.progress = rng.randi_range(0, 3446)
		
		if enemy_spawn_path.progress <= 600 and enemy_spawn_path.progress >= 0:
			redo = false
		
		elif enemy_spawn_path.progress >= 1800 and enemy_spawn_path.progress <= 2400:
			redo = false
		
	var slime = slime_scene.instantiate()
	
	slime.global_position = enemy_spawn_position.global_position
	add_child(slime)
		
	if exp_ascension >= 3:
		var skull = skull_scene.instantiate()
		
		skull.global_position = enemy_spawn_position.global_position
		add_child(skull)
		

	
func increase_exp():
	exp += 2
	exp_ui.value = exp
	
	score += 10
	score_label.text = 'PT: ' + str(score)
	
	if exp >= exp_ui.max_value:
		
		get_tree().paused = true
		pause_dark_screen.visible = true
		level_up_menu.visible = true
	
		level_up_menu.get_three_unique_skills()
		level_up_menu.show_random_skills()


func finish_level_up():
	print("finish")
	
	get_tree().paused = false
	pause_dark_screen.visible = false
	level_up_menu.visible = false
	
	exp_ascension += 1
	exp_ui.max_value = exp_ascension * 8
	
	exp = 0
	exp_ui.value = exp
	
	if exp_ascension == 2:
		timer.wait_time = 2.5
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
	if exp_ascension == 4:
		timer.wait_time = 2.0
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
	if exp_ascension == 6:
		timer.wait_time = 1.0
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
	if exp_ascension == 7:
		timer.wait_time = 0.5
		var timer_wait_time = timer.wait_time
		print(timer_wait_time)
		
func chest_opened():
	exp_ascension = 7
	timer.wait_time = 0.5
	var timer_wait_time = timer.wait_time
	print(timer_wait_time)

func increase_score_by_hit():
	score += 2
	score_label.text = 'PT: ' + str(score)
	

func increase_ninji_star_damage():
	ninji_star_damage += 2
	ninji_star_damage_ui.text = str(ninji_star_damage)
	
func increase_ninji_star_speed():
	ninji_star_speed += 2
	ninji_star_speed_ui.text = str(ninji_star_speed)
