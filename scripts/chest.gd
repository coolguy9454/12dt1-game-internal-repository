extends StaticBody2D

@onready var label_animation = $LabelAnimation
@onready var chest_animation = $ChestAnimation
@onready var player_detection = $PlayerDetection
@onready var within_seen_area = $WithinSeenArea
@onready var direction_arrow_right = $/root/Game/CanvasLayer/DirectionArrowRight
@onready var direction_arrow_left = $/root/Game/CanvasLayer/DirectionArrowLeft
@onready var key_achievement_banner = $/root/Game/CanvasLayer/KeyAchievementBanner
@onready var end_door = $/root/Game/EndDoor
@onready var game = $/root/Game

var key_scene = preload("res://scenes/key.tscn")

var near_chest: bool = false

const TOP_LAYER = 100
const PLAYER = "player"
const CHEST_ANIMATION_NAME = "open"
const LABEL_ANMATION_NAME = "float"
const INTERACT_BUTOON = "interact"


func _process(delta):
	# Detect is player near chest
	if near_chest:
		# Open chest when player pressed'e'
		if Input.is_action_just_pressed(INTERACT_BUTOON):
			chest_animation.play(CHEST_ANIMATION_NAME)
			
			player_detection.queue_free()
			within_seen_area.queue_free()
			direction_arrow_right.queue_free()
			direction_arrow_left.show()
			key_achievement_banner.play_animation()
			game.chest_opened()
			
			var key = key_scene.instantiate()
			game.add_child(key)
			
			end_door.has_key()
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Show 'e' label animation
	if body.is_in_group(PLAYER):
		label_animation.show()
		label_animation.play(LABEL_ANMATION_NAME)
		label_animation.z_index = TOP_LAYER
		
		near_chest = true
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	# Hide 'e' label animation
	if body.is_in_group(PLAYER):
		label_animation.hide()
		label_animation.stop()
		
		near_chest = false
		

func _on_within_seen_area_body_entered(body: Node2D) -> void:
	# Hide animaton arrow when chest are beng seen
	if body.is_in_group(PLAYER):
		direction_arrow_right.hide()


func _on_within_seen_area_body_exited(body: Node2D) -> void:
	# Show animaton arrow when chest are not beng seen
	if body.is_in_group(PLAYER):
		direction_arrow_right.show()
		
	
