extends Control

@onready var upgrade_1 = $Upgrade1
@onready var upgrade_2 = $Upgrade2
@onready var upgrade_3 = $Upgrade3
@onready var game = $/root/Game
@onready var player = $/root/Game/Player

var enemy_scene = preload("res://scenes/enemy.tscn")
var enemy = enemy_scene.instantiate()

var button_pressed: String = ""

var all_skills = ["Speed Boost", "Increase Max Health +10", "Shield", "Normal Attack Damage +1", "Normal Attack Speed +1"]
#var all_skills = ["Speed Boost", "Increase Max Health +10", "Shield"]

func get_three_unique_skills():
	var shuffled = all_skills.duplicate()
	shuffled.shuffle()
	return shuffled.slice(0, 3)


func show_random_skills():
	var selected_skills = get_three_unique_skills()
	
	upgrade_1.text = selected_skills[0]
	upgrade_2.text = selected_skills[1]
	upgrade_3.text = selected_skills[2]
	

func _on_upgrade_1_pressed() -> void:
	button_pressed = upgrade_1.text
	
	level_up()
	game.finish_level_up()

func _on_upgrade_2_pressed() -> void:
	button_pressed = upgrade_2.text
	
	level_up()
	game.finish_level_up()


func _on_upgrade_3_pressed() -> void:
	button_pressed = upgrade_3.text
	
	level_up()
	game.finish_level_up()
	

func level_up():
	if button_pressed == "Speed Boost":
		player.speed_increase()
		print(button_pressed)
		
	elif button_pressed == "Increase Max Health +10":
		player.increase_max_health()
		print(button_pressed)
		
	elif button_pressed == "Shield":
		player.deploy_shield()
		print(button_pressed)
		
	elif button_pressed == "Normal Attack Damage +1":
		game.increase_bullet_damage()
		print(button_pressed)
		
	elif button_pressed == "Normal Attack Speed +1":
		player.increase_bullet_speed()
	
