extends Control

const GAME_SCENE = "res://scenes/game menu.tscn"


func _on_home_button_pressed() -> void:\
	# Go back game menu screen when this button is pressed
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_quit_button_pressed() -> void:
	# Quit game when this button is pressed
	get_tree().quit()
