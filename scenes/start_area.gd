class_name StartArea
extends Node3D


enum State {
	START,
	MAIN,
	LEVELS,
	SETTINGS,
	CREDITS
}

@onready var start_menu: StartMenu = $StartMenu
@onready var main_menu: MainMenu = $MainMenu
@onready var credits_menu: CreditsMenu = $CreditsMenu
@onready var camera_animations: AnimationPlayer = %CameraAnimations

var state: State
var current_menu: Menu


func _ready() -> void:
	state = State.START
	current_menu = start_menu
	start_menu.display()


func _input(event: InputEvent) -> void:
	if current_menu:
		current_menu.input(event)


func _on_start_menu_selected() -> void:
	state = State.MAIN
	current_menu = null
	camera_animations.play("start_to_main")


func _on_main_menu_selection(option: MainMenu.State) -> void:
	match option:
		MainMenu.State.LEVELS:
			state = State.LEVELS
			print("LEVELS")
		MainMenu.State.SETTINGS:
			state = State.SETTINGS
			print("SETTINGS")
		MainMenu.State.CREDITS:
			state = State.CREDITS
			current_menu = credits_menu
			camera_animations.play("main_to_credits")


func _on_credits_menu_selected() -> void:
	state = State.MAIN
	main_menu.reset_focus()
	current_menu = main_menu
	camera_animations.play_backwards("main_to_credits")


func _on_camera_animations_animation_finished(_anim_name: String) -> void:
	match state:
		State.MAIN:
			current_menu = main_menu
		State.CREDITS:
			credits_menu.display()
