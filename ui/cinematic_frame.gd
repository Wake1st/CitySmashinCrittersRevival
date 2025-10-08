class_name CinematicFrame
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func frame_on() -> void:
	animation_player.play("ease in")


func frame_off() -> void:
	animation_player.play_backwards("ease in")
