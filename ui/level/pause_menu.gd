class_name PauseMenu
extends Control


enum Options {
	RESUME,
	SETTINGS,
	MENU
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ui_sfx: UISFX = $UISFX

@onready var resume_btn: Button = %ResumeBtn
@onready var settings_btn: Button = %SettingsBtn
@onready var menu_btn: Button = %MenuBtn
@onready var settings_menu: SettingsMenu = %SettingsMenu

var resume_callable: Callable
var menu_callable: Callable

var is_closing: bool
var current_option: Options
var options: Array[Options]


func setup(resume: Callable, menu: Callable) -> void:
	resume_callable = resume
	menu_callable = menu


func open() -> void:
	animation_player.play("open_pause")
	is_closing = false
	resume_btn.grab_focus()


func close() -> void:
	animation_player.play_backwards("open_pause")
	is_closing = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		close()


func _handle_element_focused() -> void:
	ui_sfx.focus()


func _on_animation_player_animation_finished(_anim_name) -> void:
	if is_closing:
		resume_callable.call()


func _on_resume_btn_pressed() -> void:
	close()
	ui_sfx.select()


func _on_settings_btn_pressed() -> void:
	animation_player.play("open_settings")
	settings_menu.open()
	ui_sfx.select()


func _on_menu_btn_pressed() -> void:
	get_tree().paused = false
	menu_callable.call()
	ui_sfx.select()


func _on_settings_menu_closed() -> void:
	animation_player.play_backwards("open_settings")
	settings_btn.grab_focus()
	ui_sfx.cancel()
