class_name CountdownTimer
extends Timer


signal finished()

@export var countdown: float
@export var tick: float

var remaining: float


func run() -> void:
	remaining = countdown
	start(tick)


func _on_timeout() -> void:
	remaining -= tick
	if remaining <= 0:
		finished.emit()
	else:
		start(tick)
