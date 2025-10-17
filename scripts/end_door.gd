extends StaticBody2D

@onready var door_animation = $DoorAnimation
@onready var label_animation = $LabelAnimation
@onready var chest = $/root/Game/Chest
@onready var door_opened_label = $/root/Game/CanvasLayer/DoorOpened

var near_by_door: bool = false
var obtained_key: bool = false
var door_opened: bool = false
var door_animation_finished: bool = false
var game_finished: bool = false


func _ready() -> void:
	label_animation.hide()
	label_animation.play("float")
	
	
func _process(delta: float) -> void:
	# If player is near by the door and pressed 'e', the door open.
	if near_by_door:
		if Input.is_action_just_pressed("interact"):
			door_animation.play("open")
			
			door_opened = true
			door_opened_label.text = "true"
			
			if is_instance_valid(label_animation):
				label_animation.queue_free()
		
		if door_animation_finished:
			# Only if player is still near by the door
			get_tree().change_scene_to_file("res://scenes/the end.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Show label 'e' animation if player is nearby and has the key		
	if body.is_in_group("player") and obtained_key:
		if not door_opened:
			label_animation.show()
		
		near_by_door = true
		
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	# Hide label 'e' animation if player is not near by the door
	if body.is_in_group("player") and obtained_key:
		if not door_opened:
			label_animation.hide()
		
		near_by_door = false
		
		
func has_key():
	obtained_key = true


func _on_door_animation_animation_finished() -> void:
	door_animation_finished = true
	
