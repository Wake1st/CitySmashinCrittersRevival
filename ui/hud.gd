class_name HUD
extends Control


@onready var damage_lbl: Label = %DamageLbl
@onready var time_lbl: Label = %TimeLbl
@onready var bar: ColorRect = %Bar


func update_time(value: float) -> void:
	time_lbl.text = "%3.2f" % value


func update_damage(value: float) -> void:
	damage_lbl.text = "%5.0f" % value


func update_power(value: float) -> void:
	bar.set_instance_shader_parameter("weight", value)
