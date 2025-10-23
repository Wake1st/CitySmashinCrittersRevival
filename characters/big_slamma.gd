class_name BigSlamma
extends Node3D


enum State {
	NONE,
	IDLE,
	WALK,
	PUNCH,
	SPECIAL
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_state: State


func is_attacking() -> bool:
	return current_state == State.PUNCH


func off() -> void:
	current_state = State.NONE
	animation_player.play("Idle")
	animation_player.stop()


func idle() -> void:
	current_state = State.IDLE
	animation_player.play("Idle")


func walk() -> void:
	current_state = State.WALK
	animation_player.play("Walk02")


func attack() -> void:
	current_state = State.PUNCH
	animation_player.play("Punch")


func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "Punch":
		idle()
