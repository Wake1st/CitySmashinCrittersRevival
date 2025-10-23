class_name ShakeCam
extends Node3D


@export var horizontal_limit: float = 0.1
@export var vertical_limit: float = 0.06
@export_range(0,1) var strength: float = 0

@onready var camera: Camera3D = $Camera
@onready var animation: AnimationPlayer = $AnimationPlayer


func shake() -> void:
	animation.play("shake")


func _physics_process(_delta: float) -> void:
	if strength > 0:
		camera.position = Vector3(
			randf_range(-horizontal_limit * strength, horizontal_limit * strength),
			randf_range(-vertical_limit * strength, vertical_limit * strength),
			0.0
		)


func _on_animation_player_animation_finished(_anim_name: String) -> void:
	camera.position = Vector3.ZERO
