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

const MIN_INDEX_LIST = 0
const MAX_INDEX_LIST = 3
const UPGRADE_1_OPTION = 0
const UPGRADE_2_OPTION = 1
const UPGRADE_3_OPTION = 2
const SPEED_BOOST_UPGRADE = "Speed Boost"
const INCREASE_MAX_HEALTH_10_UPGRADE = "Increase Max Health +10"
const SHIELD_UPGRADE = "Shield"
const ALL_ATTACK_DAMAGE_2_UPGRADE = "All Attack Damage +2"
const NORMAL_ATTACK_SPEED_2_UPGRADE = "Normal Attack Speed +2"
const CURSE_OF_BIBLE_UPGRADE = "Curse Of Bible"


func get_three_unique_skills(): 
	# Shuffle the list to random and get the first three options of upgrade to show it in level-up menu
	var shuffled = all_skills.duplicate()
	shuffled.shuffle()
	return shuffled.slice(MIN_INDEX_LIST, MAX_INDEX_LIST)


func show_random_skills():
	# Placing the first three upgrade of the list into the level-up menu
	var selected_skills = get_three_unique_skills()
	
	upgrade_1.text = selected_skills[UPGRADE_1_OPTION]
	upgrade_2.text = selected_skills[UPGRADE_2_OPTION]
	upgrade_3.text = selected_skills[UPGRADE_3_OPTION]
	

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
	if button_pressed == SPEED_BOOST_UPGRADE:
		player.speed_increase()
		print(button_pressed)
		
	elif button_pressed == INCREASE_MAX_HEALTH_10_UPGRADE:
		player.increase_max_health()
		print(button_pressed)
		
	elif button_pressed == SHIELD_UPGRADE:
		player.deploy_shield()
		print(button_pressed)
		
		all_skills.erase(SHIELD_UPGRADE)
		print(all_skills)
		
	elif button_pressed == ALL_ATTACK_DAMAGE_2_UPGRADE:
		game.increase_all_damage()
		print(button_pressed)
		
	elif button_pressed == NORMAL_ATTACK_SPEED_2_UPGRADE:
		player.decrease_ninji_star_cooldown()
		game.increase_ninji_star_speed()
		print(button_pressed)   
		
	elif button_pressed == CURSE_OF_BIBLE_UPGRADE:
		player.deploy_curse_of_bible()
		print(button_pressed)
		
		all_skills.erase(CURSE_OF_BIBLE_UPGRADE)
		print(all_skills)
