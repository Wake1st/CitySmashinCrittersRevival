class_name CinematicFrame
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var special_timer: Timer = $SpecialTimer
@onready var drum_delay: Timer = $DrumDelay

var showing_hint: bool


func special_hint() -> void:
	if not showing_hint:
		showing_hint = true
		animation_player.play("special_hint")


func frame_on() -> void:
	animation_player.stop()
	animation_player.play("ease in")
	special_timer.start()


func show_hint() -> void:
	animation_player.play("special_out")


func frame_off() -> void:
	animation_player.stop()
	animation_player.play_backwards("ease in")


func _on_special_timer_timeout() -> void:
	animation_player.play("show_special")
	drum_delay.start()

func _on_drum_delay_timeout() -> void:
	audio_player.play()

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "special_out":
		animation_player.play("show_hint")
		
		showing_hint = false
