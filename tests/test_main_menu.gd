extends Node


@onready var main_menu: MainMenu = $MainMenu


func _input(event: InputEvent) -> void:
	main_menu.input(event)


func _on_main_menu_selection(state: MainMenu.State):
	print("int: %s" % state)
	
	match state:
		MainMenu.State.LEVELS:
			print("LEVELS")
		MainMenu.State.SETTINGS:
			print("SETTINGS")
		MainMenu.State.CREDITS:
			print("CREDITS")
