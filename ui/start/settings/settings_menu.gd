class_name SettingsMenu
extends Menu


enum State {
	MASTER,
	MUSIC,
	SFX,
	VOICE
}

signal canceled()

const SLIDER_INCREMENT: float = 1

@onready var master_slider: Slider3D = $MasterSlider
@onready var music_slider: Slider3D = $MusicSlider
@onready var sfx_slider: Slider3D = $SfxSlider
@onready var voice_slider: Slider3D = $VoiceSlider

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_state: State
var sliders: Array[Slider3D]


func setup() -> void:
	# set initial volume values
	master_slider.set_slider(UserData.mainVolume)
	music_slider.set_slider(UserData.musicVolume)
	sfx_slider.set_slider(UserData.sfxVolume)
	voice_slider.set_slider(UserData.voiceVolume)

	# set initial values
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("Master"), 
		UserData.mainVolume
	)
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("Music"), 
		UserData.musicVolume
	)
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("SFX"), 
		UserData.sfxVolume
	)
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("Voice"), 
		UserData.voiceVolume
	)


func display() -> void:
	animation_player.play("display_hint")
	current_state = State.MASTER
	
	# return all to normal
	master_slider.focus()
	music_slider.normal()
	sfx_slider.normal()
	voice_slider.normal()


func input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next") || event.is_action_pressed("ui_down"):
		_update_focus(1)
	elif event.is_action_pressed("ui_focus_prev") || event.is_action_pressed("ui_up"):
		_update_focus(-1)
	elif event.is_action_pressed("ui_right"):
		sliders[current_state].adjust(SLIDER_INCREMENT)
	elif event.is_action_pressed("ui_left"):
		sliders[current_state].adjust(-SLIDER_INCREMENT)
	if event.is_action_pressed("ui_cancel"):
		# dont show the selection play if the hint isn't displayed
		if animation_player.is_playing():
			animation_player.play("selected")
		
		canceled.emit()


func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)

func _on_voice_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Voice"), value)


func _ready() -> void:
	# pull user settings
	DataAccess.load_user_data()
	
	# store sliders
	for child in get_children():
		if child is Slider3D:
			sliders.push_back(child)


func _update_focus(direction: int) -> void:
	sliders[current_state].normal()
	
	var index: int = (current_state + direction) % State.size()
	if index < 0:
		current_state = (index + State.size()) as State
	else:
		current_state = index as State
	
	sliders[current_state].focus()
