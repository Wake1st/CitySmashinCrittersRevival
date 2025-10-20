class_name SFXManager
extends Node


func _play(stream: AudioStreamWAV) -> void:
	var player: SfxPlayer = SfxPlayer.new()
	player.stream = stream
	player.volume_db = -4.0
	add_child(player)
	player.play()
