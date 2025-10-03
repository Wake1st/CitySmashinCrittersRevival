class_name CharacterController


static func get_movement() -> Vector2:
	return Input.get_vector("strafe-left", "strafe-right", "backward", "forward")


static func get_rotation() -> float:
	return Input.get_action_strength("turn-left") - Input.get_action_strength("turn-right")


static func get_attack() -> bool:
	return Input.is_action_just_pressed("attack")


static func get_special() -> bool:
	return Input.is_action_just_pressed("special")
