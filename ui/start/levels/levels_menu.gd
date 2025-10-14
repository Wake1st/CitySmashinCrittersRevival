class_name LevelsMenu
extends Menu


enum State {
	PLAINSVIEW,
	HILLTOP,
	SEACLIFF
}

signal level_selected(state: State)
signal cancel_selected()

@onready var plainsview_option: LevelOption = $PlainsviewOption
@onready var hilltop_option: LevelOption = $HilltopOption
@onready var seacliff_option: LevelOption = $SeacliffOption

var current_state: State
var options: Array[LevelOption]


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func display() -> void:
	animation_player.play("display_hint")


func input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next") || event.is_action_pressed("ui_right"):
		_update_focus(1)
	elif event.is_action_pressed("ui_focus_prev") || event.is_action_pressed("ui_left"):
		_update_focus(-1)
	elif event.is_action_pressed("ui_accept"):
		options[current_state].select()
		level_selected.emit(current_state)
	elif event.is_action_pressed("ui_cancel"):
		# dont show the selection play if the hint isn't displayed
		if animation_player.is_playing():
			animation_player.play("selected")
		
		cancel_selected.emit()


func reset_focus() -> void:
	options[current_state].focus()


func _ready() -> void:
	# store options
	for child in get_children():
		if child is LevelOption:
			options.push_back(child)
	
	# manually set the initial focus
	plainsview_option.focus()
	hilltop_option.normal()
	seacliff_option.normal()


func _update_focus(direction: int) -> void:
	options[current_state].normal()
	
	var index: int = (current_state + direction) % State.size()
	if index < 0:
		current_state = (index + State.size()) as State
	else:
		current_state = index as State
	
	options[current_state].focus()
