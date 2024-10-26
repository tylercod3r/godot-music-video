class_name MusicManager extends Node

#region VARIABLE
@export var music_player: AudioStreamPlayer
@export var ui_manager: UIManager
@export var animation_manager:AnimationManager

@export var bpm:int

const BARS = 4

const COMPENSATE_FRAMES = 2
const COMPENSATE_HZ = 60.0

enum SyncSource {
	SYSTEM_CLOCK,
	SOUND_CLOCK,
}

var sync_source = SyncSource.SYSTEM_CLOCK
var playing = false
var time_begin
var time_delay
var beat_number_old
#endregion

#region METHOD - NATIVE
func _process(_delta):
	if not playing or not music_player.playing:
		return

	handle_beat(get_beat_number()) 
#endregion

#region METHOD - MUSIC
func start_music() -> void:
	sync_source = SyncSource.SYSTEM_CLOCK
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	playing = true
	music_player.play()
	
func handle_beat(beat_index):
	# debug
	#print(beat_index)
	
	# sanitize
	if beat_index == beat_number_old:
		return
	else:
		beat_number_old = beat_index
	
	# get beat this bar
	var beat_this_bar = beat_index % BARS + 1
	
	# update labels
	ui_manager.set_label_text(str(beat_this_bar), str(beat_index))
	
	# animate
	animation_manager.animate_to_beat(beat_index, beat_this_bar)

#region METHOD - UTIL
func get_beat_number() -> int:
	var time = 0.0
	if sync_source == SyncSource.SYSTEM_CLOCK:
		# Obtain from ticks.
		time = (Time.get_ticks_usec() - time_begin) / 1000000.0
		# Compensate.
		time -= time_delay
	elif sync_source == SyncSource.SOUND_CLOCK:
		time = music_player.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() + (1 / COMPENSATE_HZ) * COMPENSATE_FRAMES

	var beat = int(time * bpm / 60.0)
	var seconds = int(time)
	var seconds_total = int(music_player.stream.get_length())
	
	var printDebug = str("BEAT: ", beat % BARS + 1, "/", BARS, " TIME: ", seconds / 60, ":", str_to_sec(seconds % 60), " / ", seconds_total / 60, ":", str_to_sec(seconds_total % 60))
	#print(printDebug)
	
	return beat
	
func str_to_sec(secs):
	var s = str(secs)
	if (secs < 10):
		s = "0" + s
	return s
#endregion
