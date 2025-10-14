class_name LevelOption
extends Node3D



const NORMAL_MATERIAL: StandardMaterial3D = preload("uid://bb1k5b3ve34cv")
const FOCUS_MATERIAL: StandardMaterial3D = preload("uid://jqyjkmfoe5t2")
const SELECT_MATERIAL: StandardMaterial3D = preload("uid://cs5er0jkakasj")

@onready var mesh: MeshInstance3D = $HighlightMesh


func normal() -> void:
	_highlight(NORMAL_MATERIAL)


func focus() -> void:
	_highlight(FOCUS_MATERIAL)


func select() -> void:
	_highlight(SELECT_MATERIAL)


func _highlight(mat: StandardMaterial3D) -> void:
	mesh.material_override = null
	mesh.set_surface_override_material(0, mat)
