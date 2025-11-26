class_name BitManager
extends Node3D

const BIT_SCENE: PackedScene = preload("uid://cnpox5d32kjo6")

@export_range(0,1) var blast_fraction: float = 0.1

@onready var building_sfx: BuildingSfx = $BuildingSfx


func generate(building: Building, direction: Vector3) -> void:
	var bits: Array[BuildingBit]
	
	for piece in building.geometry_pieces:
		var bit: BuildingBit = BIT_SCENE.instantiate()
		add_child(bit)
		bits.push_back(bit)
		bit.setup(building.global_position, piece, direction*blast_fraction)
	
	# fx
	building_sfx.crumble()
