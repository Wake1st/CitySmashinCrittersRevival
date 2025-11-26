class_name Building
extends StaticBody3D


signal destroyed(value: float, building: Building, direction: Vector3)

const DUST_CLOUD_PATH: String = "uid://dbswl0ewqc8gs"
const BUILDING_SFX: PackedScene = preload("uid://chab3hjvn7l6k")

const RUMBLE_AMPLITUDE: float = 0.0024

@export var health: float = 100
@export var cost: float = 400
@export var rumble_dampen: float = 0.14

@export var geometry_pieces: Array[GeometryInstance3D]

var building_sfx: BuildingSfx
var starting_position: Vector3
var rumble_magnitude: float
var is_collapsing: bool


func damage(value: float, direction: Vector3) -> bool:
	# no more damage if already destroyed
	if is_collapsing:
		return false
	
	health -= value
	building_sfx.hit()
	
	# animate rumble
	rumble_magnitude = value * RUMBLE_AMPLITUDE
	
	# building is dead
	if health <= 0:
		destroyed.emit(cost, self, direction * value)
		queue_free()
	
	# assumes damage
	return true


func _ready() -> void:
	starting_position = position
	
	# too many variants to manually add
	building_sfx = BUILDING_SFX.instantiate()
	add_child(building_sfx)


func _process(delta) -> void:
	# shake n bake
	if rumble_magnitude > 0:
		# set random position in XZ plane
		position.x = starting_position.x + randf_range(-rumble_magnitude, rumble_magnitude)
		position.z = starting_position.z + randf_range(-rumble_magnitude, rumble_magnitude)
		
		# reduce magnitude
		rumble_magnitude -= rumble_dampen * delta


func _emit_dust() -> void:
	var scene: PackedScene = load(DUST_CLOUD_PATH)
	var dust: DustCloud = scene.instantiate()
	add_child(dust)
	dust.activate()
