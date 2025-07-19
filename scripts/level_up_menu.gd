extends Control

@onready var upgrade_1 = $Upgrade1
@onready var upgrade_2 = $Upgrade2
@onready var upgrade_3 = $Upgrade3
@onready var game = $/root/Game

var all_skills = ["Speed Boost", "Health Regen", "Shield", "Normla Attack Damage +1", "Normal Attack Speed +1"]


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
	print(upgrade_1.text)
	game.finish_level_up()


func _on_upgrade_2_pressed() -> void:
	print(upgrade_2.text)
	game.finish_level_up()


func _on_upgrade_3_pressed() -> void:
	print(upgrade_3.text)
	game.finish_level_up()
