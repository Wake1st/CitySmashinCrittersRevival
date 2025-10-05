class_name Level
extends Node3D


enum State {
	SETUP,
	COUNTDOWN,
	PLAY,
	PAUSE,
	SPECIAL,
	FINISHED
}

@onready var character: Character = $Character
@onready var destructables: Node3D = $Destructables
@onready var level_timer: Timer = $LevelTimer

@onready var hud: HUD = %HUD
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var score_menu: ScoreMenu = %ScoreMenu
@onready var countdown_overlay: CountdownOverlay = %CountdownOverlay
@onready var finished_overlay: FinishedOverlay = %FinishedOverlay

var mission: Mission
var state: State = State.SETUP
var score: Score = Score.new()


func setup(miss: Mission, reset_level: Callable, next_level: Callable) -> void:
	state = State.SETUP
	mission = miss
	
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


func pause() -> void:
	state = State.PAUSE
	get_tree().paused = true
	
	# display pause menu
	pause_menu.open()


func special() -> void:
	state = State.SPECIAL
	level_timer.paused = true
	
	# enter special mode


func finish() -> void:
	state = State.FINISHED
	
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


func _process(delta) -> void:
	match state:
		State.PLAY:
			character.process(delta)
			
			# update time display
			hud.update_time(level_timer.time_left)
			
			# check finished condition
			if mission.check_completion(score):
				finish()


func _handle_unpause() -> void:
	play()

func _handle_exit() -> void:
	print("leaving level")

func _handle_destruction(value: float) -> void:
	score.damage += value
	
	# update damage display
	hud.update_damage(score.damage)


func _on_countdown_overlay_finished() -> void:
	start()

func _on_level_timer_timeout() -> void:
	if state != State.FINISHED:
		finish()

func _on_finished_overlay_finished() -> void:
	score_menu.display(score, mission.check_win(score))
