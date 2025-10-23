extends Node


@onready var building: Building = $Building


func _ready() -> void:
	building.destroyed.connect(handle_building_destroyed)


func _input(_event) -> void:
	if Input.is_key_pressed(KEY_A):
		# attack
		building.damage(15)
	elif Input.is_key_pressed(KEY_C):
		# collapse
		building.damage(100)


func handle_building_destroyed(value: float) -> void:
	print("building destroyed for %s points" % value)
