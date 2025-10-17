extends Node


@onready var pause_menu: PauseMenu = $PauseMenu


func _ready() -> void:
	get_tree().paused = true
	
	pause_menu.setup(_handle_resume, _handle_menu)
	pause_menu.open()


func _handle_resume() -> void:
	print("resumed")


func _handle_menu() -> void:
	print("menu")
