class_name LevelMusic
extends AudioStreamPlayer


enum State {
	BEAT,
	MELODY,
	CRESCENDO
}

const BIG_STOMP_BEAT: AudioStreamMP3 = preload("uid://gnh4xa01eshm")
const BIG_STOMP_MELODY: AudioStreamMP3 = preload("uid://m14c532q6fdo")
const BIG_STOMP_CRESCENDO: AudioStreamMP3 = preload("uid://b83v3nwckxy3b")

var expected_state: State
var loop_count: int


func start(loops: int) -> void:
	loop_count = loops
	stream = BIG_STOMP_BEAT
	play()


func check_crescendo(time: float) -> void:
	if time <= BIG_STOMP_CRESCENDO.get_length():
		expected_state = State.CRESCENDO


func pause() -> void:
	stream_paused = true


func unpause() -> void:
	stream_paused = false


func _on_finished() -> void:
	# reduce the loop
	if expected_state == State.BEAT && loop_count == 0:
		expected_state = State.MELODY
	else:
		loop_count -= 1
	
	match expected_state:
		State.BEAT:
			stream = BIG_STOMP_BEAT
		State.MELODY:
			stream = BIG_STOMP_MELODY
		State.CRESCENDO:
			stream = BIG_STOMP_CRESCENDO
	
	play()
