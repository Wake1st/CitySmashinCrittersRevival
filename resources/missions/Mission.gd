class_name Mission


var level_time: float
var destruction_amount: float


func _init(time: float, amount: float) -> void:
	level_time = time
	destruction_amount = amount


func check_completion(_score: Score) -> bool:
	return false


func check_win(_score: Score) -> bool:
	return false
