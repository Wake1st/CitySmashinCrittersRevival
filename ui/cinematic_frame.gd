class_name CinematicFrame
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func frame_on() -> void:
	animation_player.play("ease in")


func show_hint() -> void:
	animation_player.play("show_hint")


func frame_off() -> void:
	animation_player.stop()
	animation_player.play_backwards("ease in")
