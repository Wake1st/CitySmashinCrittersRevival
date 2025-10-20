class_name ScoreMenu
extends Control


enum State {
	NONE,
	OPENING,
	DAMAGE,
	TIME,
	TOTAL,
	RESULT,
	OPTIONS
}

const CYCLE_TIME: float = 0.8

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var ui_sfx: UISFX = $UISFX
@onready var profile_camera: ProfileCamera = %ProfileCamera

@onready var damage_lbl: Label = %DamageLbl
@onready var time_lbl: Label = %TimeLbl
@onready var total_lbl: Label = %TotalLbl
@onready var pass_panel: ColorRect = %PassPanel
@onready var fail_panel: ColorRect = %FailPanel
@onready var buttons: HBoxContainer = %ButtonContainer
@onready var next_btn: Button = %NextBtn

var replay_callable: Callable
var menu_callable: Callable
var next_callable: Callable

var state: State
var passed_level: bool


func setup(reset: Callable, menu: Callable, next: Callable) -> void:
	replay_callable = reset
	menu_callable = menu
	next_callable = next


func display(score: Score, passed: bool, location: Vector3, rotate_y: float) -> void:
	state = State.OPENING
	passed_level = passed
	
	damage_lbl.text = "%6.0f" % score.damage
	time_lbl.text = "%3.2f" % score.time
	total_lbl.text = "%6.2f" % score.total
	
	animation_player.play("open")
	profile_camera.action(passed, location, rotate_y)


func damage() -> void:
	state = State.DAMAGE
	damage_lbl.visible = true

func time() -> void:
	state = State.TIME
	time_lbl.visible = true

func total() -> void:
	state = State.TOTAL
	total_lbl.visible = true

func result() -> void:
	state = State.RESULT
	pass_panel.visible = passed_level
	fail_panel.visible = !passed_level

func options() -> void:
	state = State.OPTIONS
	buttons.visible = true
	
	# user can quickly goto next level
	next_btn.grab_focus()


func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		match state:
			State.DAMAGE, State.TIME, State.TOTAL, State.RESULT:
				damage()
				time()
				total()
				result()


func _handle_focus() -> void:
	ui_sfx.focus()


func _on_replay_btn_pressed() -> void:
	replay_callable.call()
	ui_sfx.select()

func _on_menu_btn_pressed() -> void:
	menu_callable.call()
	ui_sfx.select()

func _on_next_btn_pressed() -> void:
	next_callable.call()
	ui_sfx.select()


func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "open":
		damage()
		timer.start(CYCLE_TIME)

func _on_timer_timeout() -> void:
	match state:
		State.DAMAGE:
			time()
		State.TIME:
			total()
		State.TOTAL:
			result()
		State.RESULT:
			options()
	
	timer.start(CYCLE_TIME)
