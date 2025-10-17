extends Control

const game_menu = "res://scenes/game menu.tscn"


func _on_button_pressed() -> void:
	# Change scene to game menu when pressed
	get_tree().change_scene_to_file(game_menu)
