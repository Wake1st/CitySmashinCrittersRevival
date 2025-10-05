class_name FinishedOverlay
extends Control


signal finished()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer


func reveal() -> void:
	animation_player.play("slideIn")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "slideIn":
		timer.start()
	else:
		finished.emit()

func _on_timer_timeout():
	animation_player.play("slideOut")
