class_name Character
extends CharacterBody3D


signal power_updated(value: float)
signal special_activated(destructables: Array[Building])
signal special_fired() #TODO: animate event

@export var strafe_speed: float = 2
@export var rotate_speed: float = 0.3

@export var attack: float = 15
@export var special_cost: float = 100
@export var drain_time: float = 4.0

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var pivot: Node3D = %Pivot
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
		special_ready = true
		special_attack.visible = true
		animation_player.play("special_angle")
		drain_timer.start(drain_time)
	
	if special_ready && CharacterController.get_special():
		special_attack.attack()
		special_activated.emit(special_attack.destructables)
		_reset_special()


func get_drain_ratio() -> float:
	return drain_timer.time_left / drain_time


func _set_pivot_face(direction: Vector2) -> void:
	if direction.x > 0:
		pivot.rotation.y = -PI/2
	elif direction.x < 0:
		pivot.rotation.y = PI/2
	elif direction.y > 0:
		pivot.rotation.y = 0
	elif direction.y < 0:
		pivot.rotation.y = PI


func _reset_special() -> void:
	drain_timer.stop()
	animation_player.play_backwards("special_angle")
	special_attack.visible = false
	special_ready = false
	special_power = 0.0
	power_updated.emit(0.0)


func _on_drain_timer_timeout() -> void:
	_reset_special()
