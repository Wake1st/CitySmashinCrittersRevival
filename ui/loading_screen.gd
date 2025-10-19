class_name LoadingScreen
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_loading: bool


func open() -> void:
	is_loading = true
	animation_player.play("open")


func close() -> void:
	is_loading = false
	animation_player.play_backwards("open")


func _on_animation_player_animation_finished(_anim_name: String) -> void:
	if is_loading:
		animation_player.play("display")
