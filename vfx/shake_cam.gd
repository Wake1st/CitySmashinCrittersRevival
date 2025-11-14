class_name ShakeCam
extends Node3D


signal special_focus_finished()
signal special_buildup_finished()

@export var home_position: Vector3
@export var horizontal_limit: float = 0.1
@export var vertical_limit: float = 0.06
@export_range(0,1) var strength: float = 0

@onready var camera_animations: AnimationPlayer = %CameraAnimations
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var camera: Camera3D = $Camera


func animate(animation_name: String) -> void:
	camera_animations.play(animation_name)


func animate_backwards(animation_name: String) -> void:
	camera_animations.play_backwards(animation_name)


func shake() -> void:
	animation.play("shake")


func _physics_process(_delta: float) -> void:
	if strength > 0:
		camera.position = home_position + Vector3(
			randf_range(-horizontal_limit * strength, horizontal_limit * strength),
			randf_range(-vertical_limit * strength, vertical_limit * strength),
			0.0
		)

 
func _on_animation_player_animation_finished(_anim_name: String) -> void:
	camera.position = home_position
	strength = 0


func _on_camera_animations_animation_finished(anim_name: String) -> void:
	if anim_name == "special_focus":
		special_focus_finished.emit()
	elif anim_name == "special_buildup":
		special_buildup_finished.emit()
