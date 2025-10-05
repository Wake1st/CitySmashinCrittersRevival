extends Node


@export var test_time: float = 30
@export var test_amount: float = 1000

@onready var level: Level = $Level


func _ready() -> void:
	level.setup(
		QuotaMission.new(test_time, test_amount), 
		_handle_replay_level, 
		_handle_next_level
	)
	level.countdown()


func _handle_replay_level() -> void:
	print("replay level")

func _handle_next_level() -> void:
	print("next level")
