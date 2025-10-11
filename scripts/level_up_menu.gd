extends Control

@onready var upgrade_1 = $Upgrade1
@onready var upgrade_2 = $Upgrade2
@onready var upgrade_3 = $Upgrade3
@onready var game = $/root/Game
@onready var player = $/root/Game/Player
@onready var ninji_star = $/root/Game/NinjiStar

var slime_scene = preload("res://scenes/slime.tscn")
var slime = slime_scene.instantiate()

var button_pressed: String = ""

var all_skills = ["Speed Boost", "Increase Max Health +10", "Shield", "Normal Attack Damage +2", "Normal Attack Speed +2", "Curse Of Bible"]
# var all_skills = ["Speed Boost", "Curse Of Bible", "Shield"]

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
		
	elif button_pressed == "Normal Attack Damage +2":
		game.increase_ninji_star_damage()
		print(button_pressed)
		
	elif button_pressed == "Normal Attack Speed +2":
		player.decrease_ninji_star_cooldown()
		game.increase_ninji_star_speed()
		print(button_pressed)	
		
	elif button_pressed == "Curse Of Bible":
		player.deploy_curse_of_bible()
		print(button_pressed)
		
		all_skills.erase("Curse Of Bible")
		print(all_skills)
	
