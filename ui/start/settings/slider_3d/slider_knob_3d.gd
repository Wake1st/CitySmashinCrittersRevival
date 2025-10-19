class_name SliderKnob3D
extends StaticBody3D


const LIGHT_BLUE = preload("uid://d1u0o8swb2f8u")
const HEAVY = preload("uid://btvpic0je38yy")

@onready var mesh: MeshInstance3D = $MeshInstance3D


func highlight(value: bool = true) -> void:
	if value:
		mesh.set_surface_override_material(0, HEAVY.duplicate())
	else:
		mesh.set_surface_override_material(0, LIGHT_BLUE.duplicate())
