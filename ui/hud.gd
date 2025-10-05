class_name HUD
extends Control


@onready var damage_lbl = %DamageLbl
@onready var time_lbl = %TimeLbl


func update_time(value: float) -> void:
	time_lbl.text = "%3.2f" % value


func update_damage(value: float) -> void:
	damage_lbl.text = "%5.0f" % value
