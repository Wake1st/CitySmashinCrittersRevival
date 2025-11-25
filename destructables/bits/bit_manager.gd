class_name BitManager
extends Node3D

const BIT_SCENE: PackedScene = preload("uid://cnpox5d32kjo6")

@onready var building_sfx: BuildingSfx = $BuildingSfx


func generate(building: Building, direction: Vector3) -> void:
	var bits: Array[BuildingBit]
	
	for piece in building.geometry_pieces:
		var bit: BuildingBit = BIT_SCENE.instantiate()
		add_child(bit)
		bits.push_back(bit)
		bit.setup(building.global_position, piece, direction/20)
	
	# fx
	building_sfx.crumble()
