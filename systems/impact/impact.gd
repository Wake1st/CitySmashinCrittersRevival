class_name Impact
extends Node3D


@onready var debris_emitter: CPUParticles3D = $DebrisEmitter
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wave_mesh: MeshInstance3D = $WaveMesh


func fire() -> void:
	debris_emitter.emitting = true
	animation_player.play("pulse")


func _on_animation_player_animation_finished(_anim_name) -> void:
	wave_mesh.visible = false
	if not debris_emitter.emitting:
		queue_free()


func _on_debris_emitter_finished() -> void:
	if not animation_player.is_playing():
		queue_free()
