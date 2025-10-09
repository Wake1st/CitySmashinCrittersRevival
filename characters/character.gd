class_name Character
extends CharacterBody3D


signal power_updated(value: float)
signal special_activated()
signal special_fired(destructables: Array[Building])

@export var strafe_speed: float = 2
@export var rotate_speed: float = 0.3

@export var attack: float = 15
@export var special_cost: float = 100
@export var drain_time: float = 4.0

@onready var camera_animations: AnimationPlayer = %CameraAnimations
@onready var character_animations: AnimationPlayer = %CharacterAnimations
@onready var camera: Camera3D = %Camera3D

@onready var pivot: Node3D = %Pivot
@onready var character_mesh: MeshInstance3D = %CharacterMesh
@onready var hit_box: HitBox = %HitBox

@onready var special_attack: SpecialAttack = %SpecialAttack
@onready var drain_timer: Timer = %DrainTimer

var is_rotating: bool
var rotation_target: float

var special_power: float = 0
var special_ready: bool


func process(delta) -> void:
	# strafing
	var direction = CharacterController.get_movement()
	if direction != Vector2.ZERO:
		# translate
		var dir_3d: Vector3 = Vector3(direction.x, 0, -direction.y)
		move_and_collide(global_basis * dir_3d * strafe_speed * delta)
		
		# set facing direction
		_set_pivot_face(direction)
	
	# rotation
	var rotation_direction = CharacterController.get_rotation()
	if !is_rotating && rotation_direction != 0.0:
		rotation_target = rotation.y + rotation_direction * PI/2
		is_rotating = true
	
	if is_rotating:
		rotation.y = lerp_angle(rotation.y, rotation_target, rotate_speed)
		if is_equal_approx(rotation.y, rotation_target):
			rotation.y = rotation_target
			is_rotating = false
	
	# attack
	if CharacterController.get_attack():
		var did_damage = hit_box.attack(attack)
		if did_damage:
			special_power += 10
			power_updated.emit(special_power / special_cost)
	
	# special
	if not special_ready && special_power >= special_cost:
		_special_ready()
	
	if special_ready && CharacterController.get_special():
		_special_activated()


func get_drain_ratio() -> float:
	return drain_timer.time_left / drain_time


func setup_post_special() -> void:
	camera_animations.play("setup_post_special")

func post_special() -> void:
	camera_animations.play("post_special_zoom")

func resume_normal() -> void:
	_reset_special()
	camera_animations.play("return_to_normal")


func _set_pivot_face(direction: Vector2) -> void:
	if direction.x > 0:
		pivot.rotation.y = -PI/2
	elif direction.x < 0:
		pivot.rotation.y = PI/2
	elif direction.y > 0:
		pivot.rotation.y = 0
	elif direction.y < 0:
		pivot.rotation.y = PI


func _special_ready() -> void:
	special_ready = true
	special_attack.visible = true
	camera_animations.play("special_ready")
	drain_timer.start(drain_time)


func _special_activated() -> void:
	# reset special states
	drain_timer.stop()
	
	# attack
	special_activated.emit()
	
	# start chain of animations
	camera_animations.play("special_focus")
	
	# face character forward
	pivot.rotation.y = 0


func _special_charge() -> void:
	character_animations.play("slamma_stomp")
	camera_animations.play("special_charging")


func _special_fire() -> void:
	special_attack.attack()
	special_fired.emit(special_attack.destructables)


func _reset_special() -> void:
	special_attack.visible = false
	special_ready = false
	special_power = 0.0
	power_updated.emit(0.0)


func _on_drain_timer_timeout() -> void:
	# failed to activate
	_reset_special()
	camera_animations.play_backwards("special_ready")


func _on_camera_animations_animation_finished(anim_name):
	if anim_name == "special_focus":
		_special_charge()
	elif anim_name == "special_charging":
		_special_fire()
