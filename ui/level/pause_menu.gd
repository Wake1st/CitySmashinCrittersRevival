class_name PauseMenu
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var main_volume: HSlider = %MainVolume
@onready var music_volume: HSlider = %MusicVolume
@onready var sfx_volume: HSlider = %SfxVolume
@onready var voice_volume: HSlider = %VoiceVolume

var resume_callable: Callable
var menu_callable: Callable

var is_closing: bool


func setup(resume: Callable, menu: Callable) -> void:
	resume_callable = resume
	menu_callable = menu
	
	# set initial volume values
	main_volume.value = UserData.mainVolume
	music_volume.value = UserData.musicVolume
	sfx_volume.value = UserData.sfxVolume
	voice_volume.value = UserData.voiceVolume


func open() -> void:
	animation_player.play("open_pause")
	is_closing = false


func close() -> void:
	animation_player.play_backwards("open_pause")
	is_closing = true


func _input(event) -> void:
	# toggle pause
	if event.is_action_pressed("pause"):
		close()


func _on_animation_player_animation_finished(_anim_name) -> void:
	if is_closing:
		resume_callable.call()


func _on_resume_btn_pressed() -> void:
	close()

func _on_settings_btn_pressed() -> void:
	animation_player.play("open_settings")

func _on_return_btn_pressed():
	animation_player.play_backwards("open_settings")

func _on_menu_btn_pressed() -> void:
	menu_callable.call()


#region VolumeSliders
func _on_main_volume_value_changed(value) -> void:
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("Master"), 
		value
	)

func _on_music_volume_value_changed(value) -> void:
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("Music"), 
		value
	)

func _on_sfx_volume_value_changed(value) -> void:
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("SFX"), 
		value
	)

func _on_voice_volume_value_changed(value) -> void:
	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index("Voice"), 
		value
	)


func _on_main_volume_drag_ended(value_changed):
	if value_changed:
		UserData.mainVolume = main_volume.value
		DataAccess.save_user_data()

func _on_music_volume_drag_ended(value_changed):
	if value_changed:
		UserData.musicVolume = music_volume.value
		DataAccess.save_user_data()

func _on_sfx_volume_drag_ended(value_changed):
	if value_changed:
		UserData.sfxVolume = sfx_volume.value
		DataAccess.save_user_data()

func _on_voice_volume_drag_ended(value_changed):
	if value_changed:
		UserData.voiceVolume = voice_volume.value
		DataAccess.save_user_data()
#endregion
