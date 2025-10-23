class_name QuotaMission
extends Mission


func check_completion(score: Score) -> bool:
	return score.damage >= destruction_amount || score.time >= level_time


func check_win(score: Score) -> bool:
	return score.damage >= destruction_amount
