class_name Letter
extends CSGCombiner3D


const NORMAL_MATERIAL: StandardMaterial3D = preload("uid://btvpic0je38yy")
const FOCUS_MATERIAL: StandardMaterial3D = preload("uid://c2y3xng7tqed2")
const SELECT_MATERIAL: StandardMaterial3D = preload("uid://b5qx1sgd7vvde")

var meshes: Array[CSGPrimitive3D]


func normal() -> void:
	_highlight(NORMAL_MATERIAL)


func focus() -> void:
	_highlight(FOCUS_MATERIAL)


func select() -> void:
	_highlight(SELECT_MATERIAL)


func _highlight(mat: StandardMaterial3D) -> void:
	for mesh in meshes:
		mesh.material = mat


func _ready() -> void:
	_store_children_material(self)


func _store_children_material(node: Node3D) -> void:
	for child in node.get_children():
		if child is not CSGCombiner3D:
			meshes.push_back(child)
		_store_children_material(child)
