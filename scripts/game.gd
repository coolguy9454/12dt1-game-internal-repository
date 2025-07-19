extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var player = $Player
@onready var level_up_menu = $CanvasLayer/LevelUpMenu
@onready var pause_dark_screen = $CanvasLayer/PauseDarkScreen

@export var exp_ui: Node
var score: int = 0

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
	
	pause_dark_screen.visible = false
	level_up_menu.visible = false
	
	for i in range(number_of_tiles_bookshalf):
		var sprite_instance = sprite_scene.instantiate()
		sprite_instance.position = Vector2(x_offset_bookshalf + i * horizontal_spacing_bookshalf, 0)
		add_child(sprite_instance)
		
	for i in range(number_of_tiles_desk):
		var area_instance = area_scene.instantiate()
		area_instance.position = Vector2(x_offset_desk + i * horizontal_spacing_desk, y_offset_desk)
		add_child(area_instance)


func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	enemy.global_position = player.global_position
	
	while enemy.global_position.distance_squared_to(player.global_position) < 100000:
		enemy.global_position.x = randi_range(0, get_viewport_rect().size.x)
		enemy.global_position.y = randi_range(0, get_viewport_rect().size.y)
		
	add_child(enemy)
	

func increase_score():
	score += 50
	exp_ui.value = score
	
	if score >= 100:
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
	
	score = 0
	exp_ui.value = score
	
