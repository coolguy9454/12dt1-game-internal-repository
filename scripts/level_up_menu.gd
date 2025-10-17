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

var all_skills = ["Speed Boost", "Increase Max Health +10", "Shield", 
"All Attack Damage +2", "Normal Attack Speed +2", "Curse Of Bible"]

const min_index_list = 0
const max_index_list = 3
const upgrade_1_option = 0
const upgrade_2_option = 1
const upgrade_3_option = 2
const speed_boost_upgrade = "Speed Boost"
const increase_max_health_10_upgrade = "Increase Max Health +10"
const shield_upgrade = "Shield"
const all_attack_damage_2_upgrade = "All Attack Damage +2"
const normal_attack_speed_2_upgrade = "Normal Attack Speed +2"
const curse_of_bible_upgrade = "Curse Of Bible"


func get_three_unique_skills(): 
	# Shuffle the list to random and get the first three options of upgrade to show it in level-up menu
	var shuffled = all_skills.duplicate()
	shuffled.shuffle()
	return shuffled.slice(min_index_list, max_index_list)


func show_random_skills():
	# Placing the first three upgrade of the list into the level-up menu
	var selected_skills = get_three_unique_skills()
	
	upgrade_1.text = selected_skills[upgrade_1_option]
	upgrade_2.text = selected_skills[upgrade_2_option]
	upgrade_3.text = selected_skills[upgrade_3_option]
	

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
	# Take action when a button in level-up menu is pressed
	if button_pressed == speed_boost_upgrade:
		player.speed_increase()
		print(button_pressed)
		
	elif button_pressed == increase_max_health_10_upgrade:
		player.increase_max_health()
		print(button_pressed)
		
	elif button_pressed == shield_upgrade:
		player.deploy_shield()
		print(button_pressed)
		
		all_skills.erase(shield_upgrade)
		print(all_skills)
		
	elif button_pressed == all_attack_damage_2_upgrade:
		game.increase_all_damage()
		print(button_pressed)
		
	elif button_pressed == normal_attack_speed_2_upgrade:
		player.decrease_ninji_star_cooldown()
		game.increase_ninji_star_speed()
		print(button_pressed)	
		
	elif button_pressed == curse_of_bible_upgrade:
		player.deploy_curse_of_bible()
		print(button_pressed)
		
		all_skills.erase(curse_of_bible_upgrade)
		print(all_skills)
	
