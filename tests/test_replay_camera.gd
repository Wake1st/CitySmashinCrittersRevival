extends Node


@export var settings: ReplaySettings

@onready var building: Building = $Building
@onready var replay_camera: ReplayCamera = $ReplayCamera


func _ready() -> void:
	replay_camera.setup(settings, Vector3.ZERO)
	
	replay_camera.recording_finished.connect(_handle_recording_finished)
	replay_camera.playback_finished.connect(_handle_playback_finished)


func _input(_event) -> void:
	if Input.is_key_pressed(KEY_1):
		building.damage(80)
		replay_camera.start_recording()
	elif Input.is_key_pressed(KEY_2):
		replay_camera.start_playback()


func _handle_recording_finished() -> void:
	print("recording finished")


func _handle_playback_finished() -> void:
	print("playback finished")
