class_name Character
extends CharacterBody3D


@export var strafe_speed: float = 2
@export var rotate_speed: float = 0.3

var is_rotating: bool
var rotation_target: float


func _process(delta) -> void:
	# strafing
	var direction = CharacterController.get_movement()
	if direction != Vector2.ZERO:
		var dir_3d: Vector3 = Vector3(direction.x, 0, -direction.y)
		move_and_collide(global_basis * dir_3d * strafe_speed * delta)
	
	# rotation
	var rotation_direction = CharacterController.get_rotation()
	if !is_rotating && rotation_direction != 0.0:
		rotation_target = rotation.y + rotation_direction * PI/2
		is_rotating = true
	
	if is_rotating:
		rotation.y = lerp_angle(rotation.y, rotation_target, rotate_speed)
		if is_equal_approx(rotation.y, rotation_target):
			rotation.y = rotation_target
			is_rotating = false
