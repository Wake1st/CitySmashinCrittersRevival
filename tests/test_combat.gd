extends Node


@onready var character: Character = $Character


func _process(delta) -> void:
	character.process(delta)
