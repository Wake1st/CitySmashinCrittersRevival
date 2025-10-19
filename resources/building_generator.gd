@tool
class_name BuildingGenerator
extends Node


const BLUE: StandardMaterial3D = preload("uid://d1u0o8swb2f8u")
const GREEN: StandardMaterial3D = preload("uid://dwu62jo183r0q")
const TURQUOISE: StandardMaterial3D = preload("uid://b08tin0j0tdda")
const PALE: StandardMaterial3D = preload("uid://b5v4paayu20r7")
const PURPLE: StandardMaterial3D = preload("uid://048pkofw7esi")
const BROWN: StandardMaterial3D = preload("uid://3fhst2bsgy7h")
const GREY: StandardMaterial3D = preload("uid://dnqdtrfcb63m8")
const RED: StandardMaterial3D = preload("uid://m1n27us0gsql")

const BUILDING = preload("uid://cuxp1tk3ucica")

@export var min_size: float = 0.8
@export var max_size: float = 2.2

@export_tool_button("Generate", "ReloadSmall") var gen_action: Callable = _generate
@export_tool_button("Save", "Save") var save: Callable = _save

var materials: Array[StandardMaterial3D] = [
	BLUE,
	GREEN,
	TURQUOISE,
	PALE,
	PURPLE,
	BROWN,
	GREY,
	RED
]

func _generate() -> void:
	# clear previous results
	remove_child(get_child(0))
	
	# generate building class
	var building: Building = BUILDING.instantiate()
	add_child(building)
	building.owner = self
	
	# add a combiner
	var combiner: CSGCombiner3D = CSGCombiner3D.new()
	building.add_child(combiner)
	combiner.owner = self
	
	# spawn a base box
	var base: CSGBox3D = _spawn_box(combiner)
	base.material = _get_random_material()
	
	# spawn a cluster of boxes
	var segments = randi_range(1, 3)
	for i in segments:
		var box: CSGBox3D = _spawn_box(combiner)
		box.material = _get_random_material()
		
		# attach to base
		box.position.x = randf_range(-base.size.x - box.size.x, base.size.x + box.size.x) / 2
		box.position.z = randf_range(-base.size.z - box.size.z, base.size.z + box.size.z) / 2
	
	# create collision based on shapes
	var shape: ConcavePolygonShape3D = combiner.bake_collision_shape()
	var node: CollisionShape3D = CollisionShape3D.new()
	node.shape = shape
	building.add_child(node)
	node.owner = self


func _spawn_box(combiner: CSGCombiner3D) -> CSGBox3D:
	var box: CSGBox3D = CSGBox3D.new()
	box.size = Vector3(
		randf_range(min_size, max_size),
		randf_range(min_size, max_size),
		randf_range(min_size, max_size),
	)
	combiner.add_child(box)
	box.owner = self
	box.position.y = box.size.y / 2
	return box


func _get_random_material() -> StandardMaterial3D:
	return materials[randi_range(0, 7)]


func _save() -> void:
	var fileDialog := EditorFileDialog.new()
	fileDialog.current_path = "res://destructables/buildings/common/"
	fileDialog.add_filter("*.tscn")
	fileDialog.file_selected.connect(_on_file_selected)
	EditorInterface.popup_dialog_centered(fileDialog, Vector2i(1000, 1000))


func _on_file_selected(path: String) -> void:
	# reset owner
	var currentScene: Node = get_node("Building")
	_recursive_set_owner(currentScene, currentScene)
	
	# set name to file name
	currentScene.name = _generate_root_name(path)
	
	# pack up and save
	var scene: Resource = PackedScene.new()
	var result = scene.pack(currentScene)
	if result == OK:
		var error = ResourceSaver.save(scene, path)
		if error != OK:
			push_error("An error occurred while attempting to save this scene.")


func _recursive_set_owner(node: Node, own: Node) -> void:
	for child in node.get_children():
		child.owner = own
		_recursive_set_owner(child, own)


func _generate_root_name(path: String) -> String:
	# get the file name
	var path_parts: PackedStringArray = path.split("/")
	var file_name = path_parts.get(path_parts.size() - 1).split(".").get(0)
	
	# reformat and remove the spaces
	return file_name.capitalize().remove_char(32)
