class_name SpectatorAudio
extends AudioStreamPlayer


enum SingleFlags {
	LEVEL_TIME_HALF = 1 << 0,
	LEVEL_TIME_CLOSE = 1 << 1,
	SPECIAL_TIME_HALF_CHARGE = 1 << 2,
	SPECIAL_TIME_HALF_EMPTY = 1 << 3 
}

const HALF_TIME: float = 0.5
const ALMOST_TIME: float = 0.1

const DOWNTIME_MIN: float = 2.2
const DOWNTIME_MAX: float = 4.6

@onready var timer: Timer = $Timer

var should_pause: bool
var single_flags: int = 0


func play_next_audio_segment() -> void:
	if should_pause:
		return
	
	stream = SpectatorState.get_next_sound()
	
	# reset unless intro
	if (SpectatorState.current_flags & SpectatorState.Flags.INTRO
	) && (SpectatorState.current_announcer & SpectatorState.Announcers.WALLY
	):
		SpectatorState.current_flags = SpectatorState.Flags.INTRO
	elif (SpectatorState.current_flags & SpectatorState.Flags.WRAP_UP_PASS
	) || (SpectatorState.current_flags & SpectatorState.Flags.WRAP_UP_FAIL
	):
		pause_when_done() 
	else:
		SpectatorState.current_flags = 0
	
	if stream:
		play()
	else:
		timer.start(randf_range(DOWNTIME_MIN, DOWNTIME_MAX))


func interupt_segment() -> void:
	timer.stop()
	
	if playing:
		stop()
	
	play_next_audio_segment()


func pause_when_done() -> void:
	should_pause = true


func unpause() -> void:
	should_pause = false


func check_level_time(current: float, total: float) -> void:
	if current <= (total * HALF_TIME) && !(single_flags & SingleFlags.LEVEL_TIME_HALF):
		SpectatorState.current_flags |= SpectatorState.Flags.LEVEL_TIME_HALF
		single_flags |= SingleFlags.LEVEL_TIME_HALF
	elif current <= (total * ALMOST_TIME) && !(single_flags & SingleFlags.LEVEL_TIME_CLOSE):
		SpectatorState.current_flags |= SpectatorState.Flags.LEVEL_TIME_CLOSE
		single_flags |= SingleFlags.LEVEL_TIME_CLOSE


func check_special_charge(current: float, total: float) -> void:
	if current > (total * HALF_TIME) && !(single_flags & SingleFlags.SPECIAL_TIME_HALF_CHARGE):
		SpectatorState.current_flags |= SpectatorState.Flags.SPECIAL_HALF_CHARGED
		single_flags |= SingleFlags.SPECIAL_TIME_HALF_CHARGE


func check_special_time(current: float, total: float) -> void:
	if current < (total * HALF_TIME) && !(single_flags & SingleFlags.SPECIAL_TIME_HALF_EMPTY):
		SpectatorState.current_flags |= SpectatorState.Flags.SPECIAL_HALF_EMPTY
		single_flags |= SingleFlags.SPECIAL_TIME_HALF_EMPTY


func clear_special_flags() -> void:
	single_flags ^= SingleFlags.SPECIAL_TIME_HALF_EMPTY
	single_flags ^= SingleFlags.SPECIAL_TIME_HALF_CHARGE


func set_win_state(did_win: bool) -> void:
	if did_win:
		SpectatorState.current_flags = SpectatorState.Flags.WRAP_UP_PASS
	else:
		SpectatorState.current_flags = SpectatorState.Flags.WRAP_UP_FAIL


func _on_finished() -> void:
	play_next_audio_segment()


func _on_timer_timeout() -> void:
	if (SpectatorState.current_flags == 0):
		SpectatorState.current_flags = SpectatorState.Flags.FILLER
	
	play_next_audio_segment()
