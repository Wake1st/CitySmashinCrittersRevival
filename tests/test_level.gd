class_name TestLevel
extends Node


@export var test_time: float = 30
@export var test_amount: float = 1000

var level: Level


func _ready() -> void:
	# there should only be one
	level = get_child(0) as Level
	
	DataAccess.load_user_data()
	
	level.setup(
		QuotaMission.new(test_time, test_amount), 
		_handle_replay_level, 
		_handle_next_level,
		_handle_exit_level
	)
	level.countdown() 


func _handle_replay_level() -> void:
	print("replay level")

func _handle_next_level() -> void:
	print("next level")

func _handle_exit_level() -> void:
	print("exit level")
