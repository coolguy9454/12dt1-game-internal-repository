extends AnimatedSprite2D

@onready var player = $/root/Game/Player
@onready var door_opened_label = $/root/Game/CanvasLayer/DoorOpened

const DOOR_OPENED_LABEL_TRUE = "true"


func _physics_process(delta: float) -> void:
	# 'Key' follow player
	global_position = player.global_position
	
	if door_opened_label.text == DOOR_OPENED_LABEL_TRUE:
		# 'Key' disappear if it is used on the 'end door' 
		queue_free()
