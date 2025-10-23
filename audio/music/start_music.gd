class_name StartMusic
extends AudioStreamPlayer


const HEARTBEAT: AudioStreamMP3 = preload("uid://birolhrorxdqu")
const LATTE_NIGHT_GROOVE: AudioStreamMP3 = preload("uid://cg5ux76w1a8nf")

@onready var animation: AnimationPlayer = $AnimationPlayer

var swap_to_music: bool


func start_beat() -> void:
	stream = HEARTBEAT
	play()


func start_melody() -> void:
	swap_to_music = true


func fade_out() -> void:
	animation.play("fade_out")


func fade_in() -> void:
	animation.play("fade_in")


func _on_finished() -> void:
	if swap_to_music:
		stop()
		stream = LATTE_NIGHT_GROOVE
	
	play()
