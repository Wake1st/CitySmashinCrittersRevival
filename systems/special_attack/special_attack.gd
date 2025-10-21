class_name SpecialAttack
extends Area3D


const MAX_ATTACK: float = 100

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var targetting_mesh: MeshInstance3D = $TargettingMesh
@onready var wave_mesh: MeshInstance3D = $WaveMesh

var destructables: Array[Building]


func ready() -> void:
	targetting_mesh.visible = true


func attack() -> void:
	# destroy buildings
	for destructable in destructables:
		# we cant attack a destroyed building
		if not destructable.is_collapsing:
			destructable.damage(MAX_ATTACK)
	
	# vfx
	targetting_mesh.visible = false
	wave_mesh.visible = true
	animation.play("pulse")


func reset() -> void:
	animation.play("RESET")
	wave_mesh.visible = false
	


func _on_body_entered(body: Building) -> void:
	destructables.push_back(body)

func _on_body_exited(body: Building) -> void:
	destructables.erase(body)
