class_name CountdownOverlay
extends Control


signal finished()

@export var countdown: float = 3.0

@onready var timer: Timer = $Timer
@onready var panel_3: ColorRect = $Panel_3
@onready var panel_2: ColorRect = $Panel_2
@onready var panel_1: ColorRect = $Panel_1
@onready var panel_0: ColorRect = $Panel_0

var tick: float = countdown / 3.0
var remaining: float


func run() -> void:
	panel_3.visible = true
	remaining = countdown
	timer.start(tick)


func _on_timer_timeout():
	remaining -= tick
	if remaining < 0:
		panel_0.visible = false
	elif remaining == countdown - tick:
		panel_3.visible = false
		panel_2.visible = true
		timer.start(tick)
	elif remaining == countdown - tick * 2:
		panel_2.visible = false
		panel_1.visible = true
		timer.start(tick)
	elif remaining == countdown - tick * 3:
		panel_1.visible = false
		panel_0.visible = true
		timer.start(tick)
		finished.emit()
