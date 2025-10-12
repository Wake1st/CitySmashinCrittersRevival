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

@onready var hud: HUD = %HUD
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var score_menu: ScoreMenu = %ScoreMenu
@onready var countdown_overlay: CountdownOverlay = %CountdownOverlay
@onready var finished_overlay: FinishedOverlay = %FinishedOverlay
@onready var cinematic_frame: CinematicFrame = %CinematicFrame

var mission: Mission
var state: State = State.SETUP
var score: Score = Score.new()


func setup(miss: Mission, reset_level: Callable, next_level: Callable) -> void:
	state = State.SETUP
	mission = miss
	
	character.power_updated.connect(hud.update_power)
	character.special_activated.connect(_handle_special_activated)
	character.special_fired.connect(_handle_special_fired)
	instant_replay_system.playing_back.connect(_handle_replay_playback)
	instant_replay_system.finished.connect(_handle_replay_finished)
	
	hud.update_time(mission.level_time)
	pause_menu.setup(_handle_unpause, _handle_exit)
	score_menu.setup(reset_level, _handle_exit, next_level)


func countdown() -> void:
	state = State.COUNTDOWN
	
	# display countdown
	countdown_overlay.run()


func start() -> void:
	level_timer.start(mission.level_time)
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
	
	# enter special mode
	cinematic_frame.frame_on()


func finish() -> void:
	state = State.FINISHED
	
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
	# toggle pause
	if event.is_action_pressed("pause") && state != State.FINISHED:
		pause()
	elif event.is_action_pressed("attack") && state == State.POST_SPECIAL:
		_end_post_special()


func _physics_process(delta) -> void:
	match state:
		State.PLAY:
			# first - check finished condition
			if mission.check_completion(score):
				finish()
			
			# allow user input on character
			character.process(delta)
			
			# update time display
			hud.update_time(level_timer.time_left)
			
			# check power updates when draining
			if character.special_ready:
				hud.update_power(character.get_drain_ratio())


func _handle_unpause() -> void:
	play()

func _handle_exit() -> void:
	print("leaving level")

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

func _end_post_special() -> void:
	# disable special stuff
	character.resume_normal()
	cinematic_frame.frame_off()
	
	# lets first see if we won
	if mission.check_completion(score):
		finish()
	else:
		play()


func _on_countdown_overlay_finished() -> void:
	start()

func _on_level_timer_timeout() -> void:
	if state != State.FINISHED:
		finish()

func _on_finished_overlay_finished() -> void:
	score_menu.display(
		score, 
		mission.check_win(score), 
		character.global_position,
		character.rotation.y
	)
