extends Node


@onready var levels_menu: LevelsMenu = $LevelsMenu


func _input(event: InputEvent) -> void:
	levels_menu.input(event)


func _on_levels_menu_level_selected(state: LevelsMenu.State) -> void:
	print("int: %s" % state)
	
	match state:
		LevelsMenu.State.PLAINSVIEW:
			print("PLAINSVIEW")
		LevelsMenu.State.HILLTOP:
			print("HILLTOP")
		LevelsMenu.State.SEACLIFF:
			print("SEACLIFF")
