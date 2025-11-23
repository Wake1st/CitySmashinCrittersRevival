class_name StaminaSystem
extends Node


signal cooldown_activated()

@export var max_amount: float = 60
@export var recharge_rate: float = 14
@export var hit_cost: float = 10
@export var dash_cost: float = 40

var stamina: float
var is_cooling: bool


func reset() -> void:
	stamina = max_amount
	is_cooling = false


func ratio() -> float:
	return stamina/max_amount


func refill(delta: float) -> void:
	stamina = min(max_amount, stamina + recharge_rate * delta)
	
	if is_cooling:
		is_cooling = stamina < max_amount


func try_hit() -> bool:
	# must cover cost
	if hit_cost < stamina:
		stamina -= hit_cost
		return true
	else:
		return false


func try_dash(delta: float) -> bool:
	if is_cooling:
		return false
	
	stamina -= dash_cost * delta
	if stamina < 0:
		is_cooling = true
		cooldown_activated.emit()
		
		stamina = 0
		return false
	else:
		return true
