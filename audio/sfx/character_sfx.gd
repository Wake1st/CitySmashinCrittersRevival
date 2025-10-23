class_name CharacterSFX
extends SFXManager


const ACTIVATE: AudioStreamWAV = preload("uid://c2mtfs7n5n1jj")
const STOMP: AudioStreamWAV = preload("uid://bgnhw275vsldw")
const FAIL: AudioStreamWAV = preload("uid://cah07q3hgli8e")


func activate() -> void:
	pass
	# TODO: get a better activation sound
	#_play(ACTIVATE)


func stomp() -> void:
	_play(STOMP)


func fail() -> void:
	_play(FAIL)
