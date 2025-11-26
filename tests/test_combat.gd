extends Node


@onready var character: Character = $Character
@onready var spectator_audio: SpectatorAudio = $SpectatorAudio

@onready var building: Building = $Destructables/Test
@onready var bit_manager = $BitManager


func _ready() -> void:
	character.spectator_audio = spectator_audio
	building.destroyed.connect(_on_building_destroyed)


func _process(delta) -> void:
	character.process(delta)


func _on_building_destroyed(_cost, build, direction) -> void:
	bit_manager.generate(build, direction)
