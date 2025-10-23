class_name TiltShiftLens
extends MeshInstance3D


func update(pos: Vector3) -> void:
	mesh.material.set_shader_parameter(&"focal_point", pos)
