class_name Character
extends CharacterBody3D


@export var strafe_speed: float = 2
@export var rotate_speed: float = 0.3

@export var attack: float = 15

@onready var pivot: Node3D = %Pivot
@onready var hit_box: HitBox = %HitBox

var is_rotating: bool
var rotation_target: float


func _process(delta) -> void:
	# strafing
	var direction = CharacterController.get_movement()
	if direction != Vector2.ZERO:
		# translate
		var dir_3d: Vector3 = Vector3(direction.x, 0, -direction.y)
		move_and_collide(global_basis * dir_3d * strafe_speed * delta)
		
		# set facing direction
		_set_pivot_face(direction)
	
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
	
	# attack
	if CharacterController.get_attack():
		hit_box.attack(attack)


func _set_pivot_face(direction: Vector2) -> void:
	if direction.x > 0:
		pivot.rotation.y = -PI/2
	elif direction.x < 0:
		pivot.rotation.y = PI/2
	elif direction.y > 0:
		pivot.rotation.y = 0
	elif direction.y < 0:
		pivot.rotation.y = PI
