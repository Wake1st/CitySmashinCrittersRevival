class_name StartMenu
extends Menu


signal selected()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect: TextureRect = %TextureRect


func display() -> void:
	animation_player.play("display_hint")


func input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		texture_rect.visible = false
		animation_player.play("selected")
		selected.emit()
