extends Area2D

@export var animated_sprite_2d: AnimatedSprite2D
@onready var ninji_star_speed = $/root/Game/CanvasLayer/NinjiStarSpeed

var direction: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	animated_sprite_2d.play("spin")
	
	global_position += direction * int(ninji_star_speed.text)


func _on_timer_timeout() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.hit()
		queue_free()
		
