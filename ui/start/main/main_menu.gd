class_name MainMenu
extends Menu


enum State {
	LEVELS,
	SETTINGS,
	CREDITS
}

signal focus_changed()
signal selection(state: State)

@onready var levels_option: Option3D = $LevelsOption
@onready var settings_option: Option3D = $SettingsOption
@onready var credits_option: Option3D = $CreditsOption

var current_state: State
var options: Array[Option3D]


func input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next") || event.is_action_pressed("ui_down"):
		_update_focus(1)
	elif event.is_action_pressed("ui_focus_prev") || event.is_action_pressed("ui_up"):
		_update_focus(-1)
	elif event.is_action_pressed("ui_accept"):
		options[current_state].select()
		selection.emit(current_state)


func reset_focus() -> void:
	# return all to normal
	levels_option.normal()
	settings_option.normal()
	credits_option.normal()
	
	# ensure last selection is still focused
	options[current_state].focus()


func _ready() -> void:
	# store options
	for child in get_children():
		options.push_back(child)


func _update_focus(direction: int) -> void:
	options[current_state].normal()
	
	var index: int = (current_state + direction) % State.size()
	if index < 0:
		current_state = (index + State.size()) as State
	else:
		current_state = index as State
	
	options[current_state].focus()
	
	focus_changed.emit()
