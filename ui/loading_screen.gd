class_name LoadingScreen
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func open() -> void:
	visible = true
	animation_player.play("display")


func close() -> void:
	visible = false
	animation_player.stop()
