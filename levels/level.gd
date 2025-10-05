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
@onready var countdown_timer: CountdownTimer = $CountdownTimer

@onready var hud: HUD = %HUD
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var score_menu: ScoreMenu = %ScoreMenu

var mission: Mission
var state: State = State.SETUP
var score: Score = Score.new()


func setup(miss: Mission) -> void:
	print("\tEXECUTE: setup")
	state = State.SETUP
	mission = miss
	
	hud.update_time(mission.level_time)
	pause_menu.setup(_handle_unpause, _handle_exit)


func countdown() -> void:
	print("\tEXECUTE: countdown")
	state = State.COUNTDOWN
	
	# display countdown
	countdown_timer.run()


func start() -> void:
	print("\tEXECUTE: start")
	level_timer.start(mission.level_time)
	play()


func play() -> void:
	print("\tEXECUTE: play")
	state = State.PLAY
	get_tree().paused = false


func pause() -> void:
	print("\tEXECUTE: pause")
	state = State.PAUSE
	get_tree().paused = true
	
	# display pause menu
	pause_menu.open()


func special() -> void:
	print("\tEXECUTE: special")
	state = State.SPECIAL
	level_timer.paused = true
	
	# enter special mode


func finish() -> void:
	print("\tEXECUTE: finish")
	state = State.FINISHED
	
	# correct the HUD
	hud.update_time(level_timer.time_left)
	
	# display score menu
	score.time = mission.level_time - level_timer.time_left
	score_menu.display(score)


func _ready() -> void:
	countdown_timer.finished.connect(_handle_countdown_finished)
	
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


func _handle_countdown_finished() -> void:
	start()

func _handle_unpause() -> void:
	play()

func _handle_exit() -> void:
	print("leaving level")

func _handle_destruction(value: float) -> void:
	score.damage += value
	
	# update damage display
	hud.update_damage(score.damage)


func _on_level_timer_timeout() -> void:
	if state != State.FINISHED:
		finish()
