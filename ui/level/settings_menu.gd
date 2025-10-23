class_name SettingsMenu
extends MarginContainer


signal closed()

@onready var main_volume: HSlider = %MainVolume
@onready var music_volume: HSlider = %MusicVolume
@onready var sfx_volume: HSlider = %SfxVolume
@onready var voice_volume: HSlider = %VoiceVolume


func open() -> void:
	main_volume.grab_focus()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		closed.emit()


func _ready() -> void:
	# set initial volume values
	main_volume.value = UserData.mainVolume 
	music_volume.value = UserData.musicVolume
	sfx_volume.value = UserData.sfxVolume
	voice_volume.value = UserData.voiceVolume


func _process(_delta: float) -> void:
	# we want the user to hold to adjust
	if Input.is_action_pressed("ui_right"):
		var node: Node = get_viewport().gui_get_focus_owner()
		if node is HSlider:
			var slider: HSlider = node as HSlider
			slider.value += slider.step
	elif Input.is_action_pressed("ui_left"):
		var node: Node = get_viewport().gui_get_focus_owner()
		if node is HSlider:
			var slider: HSlider = node as HSlider
			slider.value -= slider.step


func _on_return_btn_pressed() -> void:
	closed.emit()


func _on_main_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)
	UserData.mainVolume = value
	DataAccess.save_user_data()

func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)
	UserData.musicVolume = value
	DataAccess.save_user_data()

func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)
	UserData.sfxVolume = value
	DataAccess.save_user_data()

func _on_voice_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Voice"), value)
	UserData.voiceVolume = value
	DataAccess.save_user_data()
