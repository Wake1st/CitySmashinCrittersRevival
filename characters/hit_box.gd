class_name HitBox
extends Area3D


var destructables: Array[Building]


func attack(value: float) -> void:
	for destructable in destructables:
		destructable.damage(value)


func _on_body_entered(body: Building) -> void:
	destructables.push_back(body)

func _on_body_exited(body: Building) -> void:
	destructables.erase(body)
