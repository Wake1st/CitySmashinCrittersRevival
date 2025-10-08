extends Node


@onready var special_attack = $SpecialAttack
@onready var instant_replay_system = $InstantReplaySystem


func _ready() -> void:
	instant_replay_system.finished.connect(_handle_instant_replay_finished)


func _input(_event) -> void:
	if Input.is_key_pressed(KEY_1):
		special_attack.attack()
		instant_replay_system.setup(special_attack.destructables)
		instant_replay_system.run()


func _handle_instant_replay_finished() -> void:
	print("finished")
