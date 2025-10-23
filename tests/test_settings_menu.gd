extends Node


@onready var settings_menu: SettingsMenu = $SettingsMenu


func _ready() -> void:
	settings_menu.setup()
	settings_menu.display()
	settings_menu.reset_focus()


func _input(event: InputEvent) -> void:
	settings_menu.input(event)
