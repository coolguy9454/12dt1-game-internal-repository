extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var player = $Player
@export var sprite_scene: PackedScene
@export var number_of_tiles: int = 100
@export var horizontal_spacing: int = 130  # Change to your sprite width
@export var x_offset: int = -500  # Adjust this for how far left

func _ready():
	for i in range(number_of_tiles):
		var sprite_instance = sprite_scene.instantiate()
		sprite_instance.position = Vector2(x_offset + i * horizontal_spacing, 0)
		add_child(sprite_instance)

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	enemy.global_position = player.global_position
	
	while enemy.global_position.distance_squared_to(player.global_position) < 100000:
		enemy.global_position.x = randi_range(0, get_viewport_rect().size.x)
		enemy.global_position.y = randi_range(0, get_viewport_rect().size.y)
		
	add_child(enemy)
	
