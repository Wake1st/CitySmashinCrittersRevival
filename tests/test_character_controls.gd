extends Node


@onready var spectator_audio: SpectatorAudio = $SpectatorAudio
@onready var character: Character = $Character


func _ready() -> void:
	character.setup(spectator_audio)


func _process(delta) -> void:
	character.process(delta)
