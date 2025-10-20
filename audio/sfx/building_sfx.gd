class_name BuildingSfx
extends SFXManager


const HIT = preload("uid://c4a0nw12lcjg1")
const BUIDLING_CRUMBLE = preload("uid://dmw13r6sjjmkf")


func hit() -> void:
	_play(HIT)


func crumble() -> void:
	_play(BUIDLING_CRUMBLE)
