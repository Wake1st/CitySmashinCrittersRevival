class_name SpeedLines
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func toggle(value: bool) -> void:
	if value:
		animation_player.play("speed")
	else:
		animation_player.play_backwards("speed")
