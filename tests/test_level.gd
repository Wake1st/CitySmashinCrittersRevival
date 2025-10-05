extends Node


@export var test_time: float = 30
@export var test_amount: float = 1000

@onready var level: Level = $Level


func _input(_event) -> void:
	if Input.is_key_pressed(KEY_0):
		level.setup(QuotaMission.new(test_time, test_amount))
	elif Input.is_key_pressed(KEY_1):
		level.countdown()
