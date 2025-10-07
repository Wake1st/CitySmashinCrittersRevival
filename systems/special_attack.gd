class_name SpecialAttack
extends Area3D


const MAX_ATTACK: float = 100

var destructables: Array[Building]


func attack() -> void:
	for destructable in destructables:
		destructable.damage(MAX_ATTACK)


func _on_body_entered(body: Building) -> void:
	destructables.push_back(body)

func _on_body_exited(body: Building) -> void:
	destructables.erase(body)
