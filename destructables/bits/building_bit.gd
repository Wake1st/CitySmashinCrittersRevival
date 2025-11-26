class_name BuildingBit
extends RigidBody3D


const FALLING_RATE: float = 0.8
const FALLING_CUTOFF: float = -4.0

@onready var collision: CollisionShape3D = $CollisionShape3D
@onready var mesh_inst: MeshInstance3D = $MeshInstance3D
@onready var detection: CollisionShape3D = %DetectionShape

var is_sinking: bool = false


func setup(glob_pos: Vector3, geometry: GeometryInstance3D, direction: Vector3) -> void:
	var aabb: AABB = geometry.get_aabb()
	aabb.position += geometry.position
	
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = aabb.size
	collision.shape = shape
	
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = aabb.size
	mesh_inst.mesh = mesh
	
	var detection_shape: BoxShape3D = BoxShape3D.new()
	detection_shape.size = aabb.size
	detection.shape = detection_shape
	
	global_position = glob_pos + aabb.get_center()
	
	apply_impulse(direction + aabb.get_center())


func push(direction: Vector3) -> void:
	apply_impulse(direction)


func _process(_delta) -> void:
	# REVIEW: this might not be worth it
	# sink into the ground
	#if is_sinking:
		#move_and_collide(Vector3(0, -FALLING_RATE * delta,0))
	
	# don't keep around if destroyed
	if position.y < FALLING_CUTOFF:
		queue_free()


func _on_area_3d_body_entered(_body) -> void:
	is_sinking = true


func _on_area_3d_body_exited(_body) -> void:
	is_sinking = false
