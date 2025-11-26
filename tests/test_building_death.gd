extends Node

@onready var building: Building = $Test
@onready var bit_manager = $BitManager


func _ready() -> void:
	building.destroyed.connect(_on_building_destroyed)


func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		building.damage(30, Vector3.FORWARD + Vector3.UP/4)


func _on_building_destroyed(_cost, build, direction) -> void:
	bit_manager.generate(build, direction)
