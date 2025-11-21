class_name Level
extends Node3D


enum State {
	SETUP,
	COUNTDOWN,
	PLAY,
	PAUSE,
	SPECIAL,
	POST_SPECIAL,
	FINISHED
}

@onready var character: Character = $Character
@onready var destructables: Node3D = $Destructables
@onready var level_timer: Timer = $LevelTimer
@onready var instant_replay_system: InstantReplaySystem = $InstantReplaySystem
@onready var spectator_audio: SpectatorAudio = $SpectatorAudio
@onready var level_music: LevelMusic = $LevelMusic
@onready var post_special_sfx: AudioStreamPlayer = $PostSpecialSFX

@onready var hud: HUD = %HUD
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var score_menu: ScoreMenu = %ScoreMenu
@onready var countdown_overlay: CountdownOverlay = %CountdownOverlay
@onready var finished_overlay: FinishedOverlay = %FinishedOverlay
@onready var cinematic_frame: CinematicFrame = %CinematicFrame
@onready var instructions: Instructions = %Instructions

var mission: Mission
var state: State = State.SETUP
var score: Score = Score.new()


func setup(miss: Mission, reset_level: Callable, next_level: Callable, exit_level: Callable) -> void:
	state = State.SETUP
	mission = miss
	character.setup(spectator_audio)
	
	character.stamina_updated.connect(hud.update_stamina)
	character.power_updated.connect(hud.update_power)
	character.special_activated.connect(_handle_special_activated)
	character.special_fired.connect(_handle_special_fired)
	instant_replay_system.playing_back.connect(_handle_replay_playback)
	instant_replay_system.finished.connect(_handle_replay_finished)
	
	hud.update_time(mission.level_time)
	pause_menu.setup(_handle_unpause, exit_level)
	score_menu.setup(reset_level, exit_level, next_level)


func run() -> void:
	if UserData.first_playthrough:
		instructions.open()
		
		UserData.first_playthrough = false
		DataAccess.save_user_data()
	else:
		SpectatorState.current_flags |= SpectatorState.Flags.INTRO
		SpectatorState.current_announcer = SpectatorState.Announcers.PAT
		spectator_audio.play_next_audio_segment()
		
		countdown()


func countdown() -> void:
	state = State.COUNTDOWN
	
	# display countdown
	countdown_overlay.run()


func start() -> void:
	level_timer.start(mission.level_time)
	SpectatorState.current_flags |= SpectatorState.Flags.LEVEL_TIME_FULL
	level_music.start(3)
	
	play()


func play() -> void:
	state = State.PLAY
	get_tree().paused = false
	level_timer.paused = false


func pause() -> void:
	state = State.PAUSE
	get_tree().paused = true
	
	# display pause menu
	pause_menu.open()


func special() -> void:
	state = State.SPECIAL
	level_timer.paused = true
	
	# spectators
	SpectatorState.current_flags |= SpectatorState.Flags.SPECIAL_ACTIVATED
	spectator_audio.interupt_segment()
	spectator_audio.pause_when_done()
	
	# music
	level_music.pause()
	
	# enter special mode
	cinematic_frame.frame_on()


func finish() -> void:
	state = State.FINISHED
	
	# stop the music
	level_music.pause()
	
	# face the player
	character.end_level_pose()
	
	# calculate correct time
	var final_time = level_timer.time_left
	score.time = mission.level_time - final_time
	
	# correct the HUD
	hud.update_time(final_time)
	finished_overlay.reveal()


func _ready() -> void:
	for destructable: Building in destructables.get_children():
		destructable.destroyed.connect(_handle_destruction)


func _input(event) -> void:
	if instructions.is_open && event.is_action_pressed("pause"):
		instructions.close()
		
		SpectatorState.current_flags |= SpectatorState.Flags.INTRO
		spectator_audio.play_next_audio_segment()
		
		countdown()
	elif event.is_action_pressed("pause") && state != State.FINISHED:
		pause()
	elif event.is_action_pressed("attack") && state == State.POST_SPECIAL:
		_end_post_special()


func _physics_process(delta) -> void:
	# update when in play
	match state:
		State.PLAY:
			# first - check finished condition
			if mission.check_completion(score):
				finish()
			
			# allow user input on character
			character.process(delta)
			
			# update time display
			hud.update_time(level_timer.time_left)
			
			# music check
			level_music.check_crescendo(level_timer.time_left)
			
			# check power updates when draining
			if character.special_ready:
				hud.update_power(character.get_drain_ratio())
				cinematic_frame.special_hint()
			else:
				spectator_audio.check_level_time(level_timer.time_left, mission.level_time)


func _handle_unpause() -> void:
	play()

func _handle_destruction(value: float) -> void:
	score.damage += value
	
	# update damage display
	hud.update_damage(score.damage)

func _handle_special_activated() -> void:
	special()

func _handle_special_fired(destroyed: Array[Building]) -> void:
	instant_replay_system.setup(destroyed)
	instant_replay_system.run()

func _handle_replay_playback() -> void:
	character.setup_post_special()

func _handle_replay_finished() -> void:
	state = State.POST_SPECIAL
	character.post_special()
	cinematic_frame.show_hint()
	post_special_sfx.play()

func _end_post_special() -> void:
	# disable special stuff
	character.resume_normal()
	cinematic_frame.frame_off()
	
	# lets first see if we won
	if mission.check_completion(score):
		finish()
	else:
		SpectatorState.clear_all_flags()
		spectator_audio.clear_special_flags()
		spectator_audio.unpause()
		spectator_audio.play_next_audio_segment()
		
		level_music.unpause()
		
		play()


func _on_countdown_overlay_finished() -> void:
	start()

func _on_level_timer_timeout() -> void:
	if state != State.FINISHED:
		finish()

func _on_finished_overlay_finished() -> void:
	var did_win: bool = mission.check_win(score)
	
	spectator_audio.set_win_state(did_win)
	
	score_menu.display(
		score, 
		did_win, 
		character.global_position,
		character.rotation.y
	)
