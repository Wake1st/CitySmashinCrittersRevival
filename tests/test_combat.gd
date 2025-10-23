extends Node


@onready var character: Character = $Character
@onready var spectator_audio: SpectatorAudio = $SpectatorAudio


func _ready() -> void:
	character.spectator_audio = spectator_audio


func _process(delta) -> void:
	character.process(delta)
