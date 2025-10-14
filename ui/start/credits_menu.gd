class_name CreditsMenu
extends Menu


signal selected()

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func display() -> void:
	animation_player.play("display_hint")


func input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# dont show the selection play if the hint isn't displayed
		if animation_player.is_playing():
			animation_player.play("selected")
		
		selected.emit()
