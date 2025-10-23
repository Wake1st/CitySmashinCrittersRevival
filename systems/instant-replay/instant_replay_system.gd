class_name InstantReplaySystem
extends Node3D


signal playing_back()
signal finished()

const REPLAY_CAMERA = preload("uid://bjeqskns26av4")
const LOW_REPLAY_SETTINGS = preload("uid://dxj56pg3x63ev")
const MID_REPLAY_SETTINGS = preload("uid://chsyi1do6gslh")
const HIGH_REPLAY_SETTINGS = preload("uid://dpiwpgnm2hfik")

var camara_count: int
var recorded_counter: int
var playback_index: int


func setup(destructables: Array[Building]) -> void:
	# get the total cameras for replay
	camara_count = destructables.size()
	
	# setup an instant replay cameras
	for destructable in destructables:
		var camera: ReplayCamera = REPLAY_CAMERA.instantiate()
		camera.recording_finished.connect(_handle_camera_recording_finished)
		camera.playback_finished.connect(_handle_camera_playback_finished)
		add_child(camera)
		
		# get the settings randomly
		var settings_index: int = randi_range(0, 2)
		match settings_index:
			0:
				camera.setup(LOW_REPLAY_SETTINGS, destructable.global_position)
			1:
				camera.setup(MID_REPLAY_SETTINGS, destructable.global_position)
			2:
				camera.setup(HIGH_REPLAY_SETTINGS, destructable.global_position)


func run() -> void:
	for camera: ReplayCamera in get_children():
		camera.start_recording()


func _playback() -> void:
	(get_child(playback_index) as ReplayCamera).start_playback()


func _teardown() -> void:
	for camera: ReplayCamera in get_children():
		camera.queue_free()
	camara_count = 0
	recorded_counter = 0
	playback_index = 0


func _handle_camera_recording_finished() -> void:
	recorded_counter += 1
	if recorded_counter == camara_count:
		_playback()
		playing_back.emit()


func _handle_camera_playback_finished() -> void:
	playback_index += 1
	if playback_index == camara_count:
		finished.emit()
		_teardown()
	else:
		(get_child(playback_index) as ReplayCamera).start_playback()
