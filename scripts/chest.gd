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


func _process(delta):
	if near_chest:
		if Input.is_action_just_pressed("interact"):
			chest_animation.play("open")
			
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
	if body.is_in_group("player"):
		label_animation.show()
		label_animation.play("float")
		label_animation.z_index = 100
		
		near_chest = true
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		label_animation.hide()
		label_animation.stop()
		
		near_chest = false
		

func _on_within_seen_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		direction_arrow_right.hide()


func _on_within_seen_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		direction_arrow_right.show()
		
	
