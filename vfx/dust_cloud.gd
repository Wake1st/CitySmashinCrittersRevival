class_name DustCloud
extends FogVolume


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func activate() -> void:
	animation_player.play("puff")
