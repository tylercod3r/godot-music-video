class_name MusicManager extends Node

# song length = 704 beats

#region VARIABLE
@export var music_player: AudioStreamPlayer
@export var ui_manager: UIManager
@export var tween_manager: TweenManager
@export var mesh_manager:MeshManager

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

#region METHOD - UTIL
func start_music() -> void:
	sync_source = SyncSource.SYSTEM_CLOCK
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	playing = true
	music_player.play()
	
func handle_beat(beat_number):
	#print(beat_number)
	
	# sanitize
	if beat_number == beat_number_old:
		return
	else:
		beat_number_old = beat_number
	
	var beat_this_bar = beat_number % BARS + 1
	
	# update labels
	ui_manager.set_label_text(str(beat_this_bar), str(beat_number + 1))
	
	# handle empty beats
	if beat_number in range(54, 64):
		return
	if beat_number > 674:
		return
	
	# handle color + scale fx
	var color = Color(0, 0, 0, 1)
	var scaleVal = 1.0
	
	# init random mesh
	var val = randi_range(1, len(mesh_manager.box_meshes))
	tween_manager.init(mesh_manager.box_meshes[val - 1])
	
	# tween + color
	match beat_this_bar:
		1:
			color = Color(0, 0.726, 0.726)
			tween_manager.scale_normal()
		2:
			color = Color(0.5, 0.5, 0.5, 1)
		3:
			color = Color(0, 0, 0, 1)
		4: 
			color = Color(0, 0, 1, 1)
			tween_manager.scale_large()

			if (beat_number + 1) % 32 == 0:
				if randf() < 0.5:
					tween_manager.rotate_x_left()
				else:
					tween_manager.rotate_x_right()
			else:
				if (beat_number + 1) % 16 == 0:
					tween_manager.rotate_xy()
				else:
					if randf() < 0.5:
						tween_manager.rotate_y_left()
					else:
						tween_manager.rotate_y_right()
	
	#mesh_manager.color_box(color)

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
