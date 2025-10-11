@tool
class_name BuildingProc
extends Building


const BLUE: StandardMaterial3D = preload("uid://d1u0o8swb2f8u")
const GREEN: StandardMaterial3D = preload("uid://dwu62jo183r0q")
const TURQUOISE: StandardMaterial3D = preload("uid://b08tin0j0tdda")
const PALE: StandardMaterial3D = preload("uid://b5v4paayu20r7")
const PURPLE: StandardMaterial3D = preload("uid://048pkofw7esi")
const BROWN: StandardMaterial3D = preload("uid://3fhst2bsgy7h")
const GREY: StandardMaterial3D = preload("uid://dnqdtrfcb63m8")
const RED: StandardMaterial3D = preload("uid://m1n27us0gsql")

@export var min_size: float = 0.4
@export var max_size: float = 1.2
@export_tool_button("Generate", "ReloadSmall") var gen_action: Callable = _generate

@onready var combiner: CSGCombiner3D = $CSGCombiner3D

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
	for child in combiner.get_children():
		combiner.remove_child(child)
	remove_child(get_child(1))
	
	# get the combiner
	if has_node("CSGCombiner3D"):
		combiner = get_node("CSGCombiner3D")
	else:
		return
	
	# spawn a base box
	var base: CSGBox3D = _spawn_box()
	base.material = _random_material()
	
	# spawn a cluster of boxes
	var segments = randi_range(1, 3)
	for i in segments:
		var box: CSGBox3D = _spawn_box()
		box.material = _random_material()
		
		# attach to base
		box.position.x = randf_range(-base.size.x - box.size.x, base.size.x + box.size.x) / 2
		box.position.z = randf_range(-base.size.z - box.size.z, base.size.z + box.size.z) / 2
	
	# create collision based on shapes
	var shape: ConcavePolygonShape3D = combiner.bake_collision_shape()
	var node: CollisionShape3D = CollisionShape3D.new()
	node.shape = shape
	add_child(node)


func _spawn_box() -> CSGBox3D:
	var box: CSGBox3D = CSGBox3D.new()
	box.size = Vector3(
		randf_range(min_size, max_size),
		randf_range(min_size, max_size),
		randf_range(min_size, max_size),
	)
	combiner.add_child(box)
	box.position.y = box.size.y / 2
	return box


func _random_material() -> StandardMaterial3D:
	return materials[randi_range(0, 7)]
