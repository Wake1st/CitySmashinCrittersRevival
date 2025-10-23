class_name HUD
extends Control


const RELATIVE_RATIO: float = 0.9;
const EDGE_PERCENT: float = 0.05;

@onready var damage_lbl: Label = %DamageLbl
@onready var time_lbl: Label = %TimeLbl
@onready var bar: TextureRect = %Bar


func update_time(value: float) -> void:
	time_lbl.text = "%3.2f" % value


func update_damage(value: float) -> void:
	damage_lbl.text = "%5.0f" % value


func update_power(value: float) -> void:
	# only the middle 90% of the power bar is visible
	var relative_value = EDGE_PERCENT + value * RELATIVE_RATIO
	if value == 0:
		relative_value = 0
	elif relative_value == 1:
		relative_value = 1
	
	bar.set_instance_shader_parameter("weight", relative_value)
