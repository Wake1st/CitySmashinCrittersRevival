@tool
class_name ProfileCamera
extends Node3D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var focal_point: Node3D = $FocalPoint
@onready var camera: Camera3D = $Camera3D


func action(passed: bool, location: Vector3, rot_y: float) -> void:
	# go to player and 
	global_position = location
	rotation.y = rot_y
	
	if passed:
		animation_player.play("passed_shot")
	else:
		animation_player.play("failed_shot")


func _process(_delta) -> void:
	camera.look_at(focal_point.global_position)
