extends Control

@onready var animatedsprite_2d = $AnimatedSprite2D
@onready var quit_button = $Quit
@onready var clicktoplay_label = $ClickToPlay
@onready var play_button = $Play


func _on_play_pressed() -> void:
	# Play game menu's animation
	quit_button.queue_free()
	clicktoplay_label.queue_free()
	play_button.queue_free()
	
	animatedsprite_2d.play("door opening")

	
func _on_animated_sprite_2d_animation_finished() -> void:
	# Teleport end users to gameplay
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed() -> void:
	# Quit the game
	get_tree().quit()
