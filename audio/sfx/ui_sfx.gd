class_name UISFX
extends SFXManager


const SELECT_UI: AudioStreamWAV = preload("uid://bjxjhhec6kvx2")
const CANCEL_UI: AudioStreamWAV = preload("uid://bevu05delgwdg")
const FOCUS_UI = preload("uid://bx52mvu0u852g")


func focus() -> void:
	_play(FOCUS_UI)


func select() -> void:
	_play(SELECT_UI)


func cancel() -> void:
	_play(CANCEL_UI)
