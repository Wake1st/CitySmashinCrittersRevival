class_name Instructions
extends Control


@onready var animation: AnimationPlayer = $AnimationPlayer

var is_open: bool


func open() -> void:
	is_open = true
	animation.play("pop_up")


func close() -> void:
	is_open = false
	animation.play_backwards("pop_up")


func _on_animation_player_animation_finished(anim_name: String) -> void:
	if is_open && anim_name == "pop_up":
		animation.play("display_hint")
