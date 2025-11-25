class_name BuildingBit
extends RigidBody3D


@onready var collision: CollisionShape3D = $CollisionShape3D
@onready var mesh_inst: MeshInstance3D = $MeshInstance3D


func setup(glob_pos: Vector3, geometry: GeometryInstance3D, direction: Vector3) -> void:
	var aabb: AABB = geometry.get_aabb()
	aabb.position += geometry.position
	
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = aabb.size
	collision.shape = shape
	
	var mesh: BoxMesh = BoxMesh.new()
	mesh.size = aabb.size
	mesh_inst.mesh = mesh
	
	global_position = glob_pos + aabb.get_center()
	
	apply_impulse(direction + aabb.get_center())
