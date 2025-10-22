class_name Character
extends CharacterBody3D


signal power_updated(value: float)
signal special_activated()
signal special_fired(destructables: Array[Building])

const GRAVITY: float = 0.06
const TARGET_CUTOFF: float = 0.0000001

@export var strafe_speed: float = 80
@export var rotate_speed: float = 0.3

@export var attack: float = 5
@export var attack_speed: float = 0.4
@export var special_cost: float = 300
@export var drain_time: float = 8.0

@onready var camera_animations: AnimationPlayer = %CameraAnimations
@onready var character_animations: AnimationPlayer = %CharacterAnimations
@onready var camera: Camera3D = %Camera3D

@onready var pivot: Node3D = %Pivot
@onready var hit_box: HitBox = %HitBox
@onready var big_slamma: BigSlamma = %BigSlamma

@onready var special_attack: SpecialAttack = %SpecialAttack
@onready var character_sfx: CharacterSFX = $CharacterSFX
@onready var drain_timer: Timer = %DrainTimer

var is_rotating: bool
var rotation_target: float

var special_power: float = 0
var special_ready: bool

var spectator_audio: SpectatorAudio


func setup(audio: SpectatorAudio) -> void:
	spectator_audio = audio


func process(delta) -> void:
	# special
	if not special_ready && special_power >= special_cost:
		SpectatorState.current_flags |= SpectatorState.Flags.SPECIAL_READY
		spectator_audio.interupt_segment()
		_special_ready()
	
	if special_ready && CharacterController.get_special():
		_special_activated()
	
	if special_ready:
		spectator_audio.check_special_time(drain_timer.time_left, drain_time)
	else:
		spectator_audio.check_special_charge(special_power, special_cost)
	
	# attack
	if CharacterController.get_attack():
		# cant attack when already attacking
		if not big_slamma.is_attacking():
			big_slamma.attack()
			var did_damage = hit_box.attack(attack)
			if did_damage:
				special_power += 10
				power_updated.emit(special_power / special_cost)
				
				SpectatorState.current_flags |= SpectatorState.Flags.ATTACK
	
	# always have gravity
	velocity.x = 0.0
	velocity.z = 0.0
	velocity.y -= GRAVITY
	
	# strafing
	var direction = CharacterController.get_movement()
	if not big_slamma.is_attacking():
		if direction != Vector2.ZERO:
			# translate
			var dir_3d: Vector3 = Vector3(direction.x, 0, -direction.y)
			velocity += global_basis * dir_3d * strafe_speed * delta
			
			# set facing direction
			_set_pivot_face(direction)
			
			# animate
			big_slamma.walk()
		else:
			big_slamma.idle()
	
	# translate with physics engine
	move_and_slide()
	
	# rotation
	var rotation_direction = CharacterController.get_rotation()
	if not big_slamma.is_attacking() && !is_rotating && rotation_direction != 0.0:
		is_rotating = true
		
		# shift in 90 degree angles
		rotation_target = rotation_target + rotation_direction * PI/2
		
		# get the target that falls within the angle range
		rotation_target = _loop_angle(rotation_target)
	
	if is_rotating:
		rotation.y = lerp_angle(rotation.y, rotation_target, rotate_speed)
		if is_equal_approx(rotation.y, rotation_target):
			is_rotating = false
			rotation.y = rotation_target


func get_drain_ratio() -> float:
	return drain_timer.time_left / drain_time


func setup_post_special() -> void:
	camera_animations.play("setup_post_special")


func post_special() -> void:
	camera_animations.play("post_special_zoom")


func resume_normal() -> void:
	_reset_special()
	camera_animations.play("return_to_normal")


func end_level_pose() -> void:
	big_slamma.idle()
	pivot.rotation.y = PI


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
	special_attack.ready()
	camera_animations.play("special_ready")
	drain_timer.start(drain_time)


func _special_activated() -> void:
	# reset special states
	drain_timer.stop()
	
	# attack
	special_activated.emit()
	
	# start chain of animations
	big_slamma.off()
	camera_animations.play("special_focus")
	
	# face character forward
	pivot.rotation.y = 0


func _special_jump() -> void:
	character_animations.play("slamma_stomp")
	camera_animations.play("special_charging")
	character_sfx.activate()


func _special_fire() -> void:
	special_attack.attack()
	special_fired.emit(special_attack.destructables)
	
	character_sfx.stomp()


func _reset_special() -> void:
	special_attack.reset()
	special_ready = false
	special_power = 0.0
	power_updated.emit(0.0)


func _on_drain_timer_timeout() -> void:
	# failed to activate
	_reset_special()
	camera_animations.play_backwards("special_ready")
	character_sfx.fail()
	SpectatorState.current_flags |= SpectatorState.Flags.SPECIAL_FAILED


func _on_camera_animations_animation_finished(anim_name):
	if anim_name == "special_focus":
		_special_jump()
	elif anim_name == "special_charging":
		_special_fire()


func _loop_angle(angle : float) -> float:
	if angle > PI:
		angle -= PI * 2
	elif angle < -PI:
		angle += PI * 2
	return angle
