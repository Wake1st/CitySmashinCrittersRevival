class_name ReplayCamera
extends Node3D


signal recording_finished()
signal playback_finished()

@export var frames_per_second: int = 48
@export var recording_length: float = 0.4

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var viewpath: SubViewport = %SubViewport
@onready var arm: Node3D = %Arm
@onready var camera: Camera3D = %Camera3D
@onready var texture_rect: TextureRect = %TextureRect

var frame_time: float = 1.0 / frames_per_second
var max_frame_count: int = floor(recording_length * frames_per_second)

var is_recording: bool
var recording_elapsed: float
var recorded_frames: Array[Image]

var is_playing: bool
var current_frame: int
var screen_material: Material


func setup(settings: ReplaySettings) -> void:
	# the Y angle should always be random
	arm.rotation.y = randf_range(0, 2*PI)
	
	# the recording length needs a bit of variety
	recording_length = randf_range(0.4, 0.6)
	max_frame_count = floor(recording_length * frames_per_second)
	
	# camera arm settings
	arm.rotation.x = randf_range(
		settings.min_sitting_angle * PI/180, 
		settings.max_sitting_angle * PI/180
	)
	
	# camera settings
	camera.position.z = randf_range(settings.min_distance, settings.max_distance)
	camera.rotation.x = randf_range(
		settings.min_facing_angle * PI/180, 
		settings.max_facing_angle * PI/180
	)
	camera.fov = randf_range(settings.min_pov, settings.max_pov)


func start_recording() -> void:
	recorded_frames.clear()
	recording_elapsed = 0.0
	is_recording = true


func stop_recording() -> void:
	is_recording = false
	recording_finished.emit()


func start_playback() -> void:
	# ensure there's anything to play
	if recorded_frames.size() == 0:
		stop_playback()
	
	canvas_layer.visible = true
	current_frame = 0
	is_playing = true
	
	viewpath.render_target_update_mode = SubViewport.UPDATE_DISABLED


func stop_playback() -> void:
	is_playing = false
	canvas_layer.visible = false
	playback_finished.emit()


func _ready() -> void:
	frame_time = 1.0 / frames_per_second
	max_frame_count = floor(recording_length * frames_per_second)
	
	viewpath.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	
	screen_material = StandardMaterial3D.new()
	screen_material.albedo_color = Color(1,1,1,1)
	
	var viewport_texture: ViewportTexture = viewpath.get_texture()
	screen_material.albedo_texture = viewport_texture
	
	texture_rect.material = screen_material


func _process(delta) -> void:
	if is_recording:
		# capture at frame rate
		recording_elapsed += delta
		if recording_elapsed >= frame_time:
			recording_elapsed = 0.0
			_capture_frame()
		
		# stop when full
		if recorded_frames.size() >= max_frame_count:
			stop_recording()
	
	if is_playing:
		# play at frame rate
		recording_elapsed += delta
		if recording_elapsed >= frame_time:
			recording_elapsed = 0.0
			current_frame += 1
			
			# stop when done
			if current_frame >= recorded_frames.size():
				stop_playback()
			else:
				_display_frame(current_frame)


func _capture_frame() -> void:
	var frame: Image = viewpath.get_texture().get_image()
	recorded_frames.push_back(frame)


func _display_frame(index: int) -> void:
	var texture: ImageTexture = ImageTexture.create_from_image(recorded_frames[index])
	texture_rect.texture = texture
