class_name ImpactSpawner
extends Marker3D


const IMPACT_PATH: String = "res://systems/impact/impact.tscn"


func spawn() -> void:
	var scene: PackedScene = load(IMPACT_PATH)
	var impact: Impact = scene.instantiate()
	
	add_child(impact)
	impact.fire()
