class_name BigSlamma
extends Node3D


enum State {
	NONE,
	IDLE,
	WALK,
	DASH,
	PUNCH,
	SPECIAL
}

signal dash_toggled(value: bool)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_state: State


func is_walking() -> bool:
	return current_state == State.WALK


func is_dashing() -> bool:
	return current_state == State.DASH


func is_attacking() -> bool:
	return current_state == State.PUNCH


func off() -> void:
	if current_state == State.DASH:
		animation_player.speed_scale = 1.0
		dash_toggled.emit(false)
	
	current_state = State.NONE
	animation_player.play("Idle")
	animation_player.stop()


func idle() -> void:
	if current_state == State.DASH:
		animation_player.speed_scale = 1.0
		dash_toggled.emit(false)
	
	current_state = State.IDLE
	animation_player.play("Idle")


func walk() -> void:
	if current_state == State.DASH:
		animation_player.speed_scale = 1.0
		dash_toggled.emit(false)
	
	current_state = State.WALK
	animation_player.play("Walk02")


func dash() -> void:
	if current_state != State.DASH:
		animation_player.speed_scale = 2.0
		dash_toggled.emit(true)
	
	animation_player.play("Walk02")
	current_state = State.DASH


func attack() -> void:
	if current_state == State.DASH:
		animation_player.speed_scale = 1.0
		dash_toggled.emit(false)
	
	current_state = State.PUNCH
	animation_player.play("Punch")


func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "Punch":
		idle()
