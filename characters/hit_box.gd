class_name HitBox
extends Area3D


var destructables: Array[Building]


func attack(value: float) -> bool:
	# attack any destructable
	var any_damage: bool
	for destructable in destructables:
		any_damage = any_damage || destructable.damage(value)
	return any_damage


func _on_body_entered(body: Building) -> void:
	destructables.push_back(body)

func _on_body_exited(body: Building) -> void:
	destructables.erase(body)
