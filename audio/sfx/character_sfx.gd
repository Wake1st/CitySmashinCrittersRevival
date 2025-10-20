class_name CharacterSFX
extends SFXManager


const STOMP: AudioStreamWAV = preload("uid://bgnhw275vsldw")


func stomp() -> void:
	_play(STOMP)
