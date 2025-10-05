class_name ScoreMenu
extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sub_viewport = %SubViewport
@onready var damage_lbl: Label = %DamageLbl
@onready var time_lbl: Label = %TimeLbl
@onready var total_lbl: Label = %TotalLbl


func display(score: Score) -> void:
	damage_lbl.text = "%s" % score.damage
	time_lbl.text = "%s" % score.time
	total_lbl.text = "%s" % score.total
	
	animation_player.play("open")
