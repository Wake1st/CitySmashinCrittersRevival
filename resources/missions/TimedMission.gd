class_name TimedMission
extends Mission


func check_completion(score: Score) -> bool:
	return score.time >= level_time


func check_win(_score: Score) -> bool:
	return true
