extends Node


@onready var special_attack: SpecialAttack = $SpecialAttack


func _input(_event) -> void:
	if Input.is_key_pressed(KEY_1):
		special_attack.visible = true
	elif Input.is_key_pressed(KEY_2):
		special_attack.attack()
		special_attack.visible = false
