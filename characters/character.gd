class_name Character
extends CharacterBody3D


@export var speed: float = 2


func _process(delta) -> void:
	var direction = CharacterController.get_movement()
	
	if direction != Vector2.ZERO:
		var dir_3d: Vector3 = Vector3(direction.x, 0, -direction.y)
		move_and_collide(dir_3d * speed * delta)
