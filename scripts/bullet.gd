extends Area2D

var direction: Vector2
const SPEED = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += direction * SPEED


func _on_timer_timeout() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.hit()
		queue_free()
		
