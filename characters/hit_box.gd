class_name HitBox
extends Area3D


var destructables: Array[Building]
var bits: Array[BuildingBit]


func attack(value: float, direction: Vector3) -> bool:
	# push the bits
	for bit in bits:
		bit.push(direction * value/2)
	
	# attack any destructable
	var any_damage: bool
	for destructable in destructables:
		any_damage = any_damage || destructable.damage(value, direction)
	
	return any_damage


func _on_body_entered(body: Node3D) -> void:
	if body is Building:
		destructables.push_back(body)
	elif body is BuildingBit:
		bits.push_back(body)


func _on_body_exited(body: Node3D) -> void:
	if body is Building:
		destructables.erase(body)
	elif body is BuildingBit:
		bits.erase(body)
