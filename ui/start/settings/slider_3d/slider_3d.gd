class_name Slider3D
extends Node3D


signal value_changed(value: float)

const RAY_LENGTH := 1000
const UI_COLLISION_LAYER: int = 0b00000000_00000000_00000000_00000111
const PROGRESS_SIZE: float = 2.0
const SHIFT_AMOUNT: float = 0.1

@export var value_name: String
@export_range(0,1) var initialValue = 0.5

@onready var shader: Shader = preload("uid://dp7ppqyc3w448")
@onready var progressMesh: MeshInstance3D = $ProgressMesh
@onready var knob: SliderKnob3D = $SliderKnob3D
@onready var label_mesh: MeshInstance3D = $LabelMesh

@onready var sub_viewport: SubViewport = %SubViewport
@onready var label: Label = %Label


var progressStart: Vector3
var progressEnd: Vector3


func normal() -> void:
	knob.highlight(true)


func focus() -> void:
	knob.highlight(false)


func adjust(value: float) -> void:
	var adjustment = knob.position.x + value * SHIFT_AMOUNT
	set_slider(adjustment)


func _ready() -> void:
	# store the slider values
	progressStart = -Vector3(PROGRESS_SIZE/2, 0, 0)
	progressEnd = +Vector3(PROGRESS_SIZE/2, 0, 0)
	
	# set the initial position
	knob.position.x = (initialValue - 0.5) * PROGRESS_SIZE
	progressMesh.set_instance_shader_parameter("weight", initialValue)
	
	# set the label based on the name
	label.text = value_name.to_upper()
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = Color(1,1,1,1)
	material.albedo_texture = sub_viewport.get_texture()
	label_mesh.material_override = material


func set_slider(value: float) -> void:
	# calculate visual information
	var clamped = clamp(value, progressStart.x, progressEnd.x)
	var weight = inverse_lerp(progressStart.x, progressEnd.x, clamped)
	
	# display changes
	progressMesh.set_instance_shader_parameter("weight", weight)
	knob.position.x = (weight - 0.5) * PROGRESS_SIZE
	
	# notify listener
	emit_signal("value_changed", weight)
