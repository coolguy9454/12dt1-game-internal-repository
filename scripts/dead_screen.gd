extends Control


func _on_button_pressed() -> void:
	# Change scene to game menu when pressed
	get_tree().change_scene_to_file("res://scenes/game menu.tscn")
