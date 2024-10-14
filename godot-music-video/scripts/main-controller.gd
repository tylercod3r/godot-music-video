class_name GameController extends Node3D

# song length = 704 beats

#region VARIABLE
@onready var audio_stream_player: AudioStreamPlayer = $Music/AudioStreamPlayer
@onready var csg_box_3d: CSGBox3D = $World/CSGBox3D
@onready var label: Label = $UI/CenterContainer/CanvasLayer2/VBoxContainer/Label
@onready var label_2: Label = $UI/CenterContainer/CanvasLayer2/VBoxContainer/Label2
@onready var ui_fade_in_animation: AnimationPlayer = $UI/UIFadeInAnimation

const BPM = 180
const BARS = 4

const COMPENSATE_FRAMES = 2
const COMPENSATE_HZ = 60.0
const FADE_IN_UI_ANIMATION = "show_labels_anim"

enum SyncSource {
	SYSTEM_CLOCK,
	SOUND_CLOCK,
}

var scale_tween_normal:Tween
var scale_tween_large:Tween
var rotate_x_left_tween:Tween
var rotate_x_right_tween:Tween
var rotate_y_left_tween:Tween
var rotate_y_right_tween:Tween
var rotate_xy_tween:Tween

var playing = false
var sync_source = SyncSource.SYSTEM_CLOCK
var time_begin
var time_delay

var material
var material_red

var beat_number_old
#endregion

#region METHOD - NATIVE
func _ready():
	set_label_text(str(0), str(0))
	material = csg_box_3d.material
	init_tweens()

func _process(_delta):
	if not playing or not audio_stream_player.playing:
		return

	handle_beat(get_beat_number()) 
#endregion

#region METHOD - SIGNAL
func _on_PlaySystem_pressed():
	sync_source = SyncSource.SYSTEM_CLOCK
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	playing = true
	audio_stream_player.play()
	intUI()

func _on_PlaySound_pressed():
	sync_source = SyncSource.SOUND_CLOCK
	playing = true
	audio_stream_player.play()
	
func _on_button_pressed() -> void:
	_on_PlaySystem_pressed()
	#_on_PlaySound_pressed()
#endregion

#region METHOD - UTIL
func intUI() -> void:
	ui_fade_in_animation.current_animation = FADE_IN_UI_ANIMATION
	ui_fade_in_animation.play()

func init_tweens() -> void:
	# scale-tween-normal ###########################################
	scale_tween_normal = TweenNode.create_reusable_tween()
	var scale_val = 1.0
	scale_tween_normal.tween_property(csg_box_3d, "scale", Vector3(scale_val, scale_val, scale_val), 0.1)
	
	# scale-tween-large ############################################
	scale_tween_large = TweenNode.create_reusable_tween()
	scale_val = 1.25
	scale_tween_large.tween_property(csg_box_3d, "scale", Vector3(scale_val, scale_val, scale_val), 0.3)

	# rotate-x-left ################################################
	rotate_x_left_tween = TweenNode.create_reusable_tween()
	
	var x_degrees: float = -360 
	var y_degrees: float = 0
	var z_degrees: float = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	rotate_x_left_tween.tween_property(csg_box_3d, "rotation", target_rotation, 0.3).as_relative()
	
	# rotate-x-right ###############################################
	rotate_x_right_tween = TweenNode.create_reusable_tween()
	x_degrees = 360 
	y_degrees = 0
	z_degrees = 0

	target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	rotate_x_right_tween.tween_property(csg_box_3d, "rotation", target_rotation, 0.3).as_relative()

	# rotate-y-left ################################################
	rotate_y_left_tween = TweenNode.create_reusable_tween()
	x_degrees = 0 
	y_degrees = -45
	z_degrees = 0

	target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	rotate_y_left_tween.tween_property(csg_box_3d, "rotation", target_rotation, 0.1).as_relative()
	
	# rotate-y-right ###############################################
	rotate_y_right_tween = TweenNode.create_reusable_tween()
	x_degrees = 0 
	y_degrees = 45
	z_degrees = 0

	target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	rotate_y_right_tween.tween_property(csg_box_3d, "rotation", target_rotation, 0.1).as_relative()
	
	# rotate-xy ####################################################
	rotate_xy_tween = TweenNode.create_reusable_tween()
	x_degrees = -360 
	y_degrees = 45
	z_degrees = 0

	target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	rotate_xy_tween.tween_property(csg_box_3d, "rotation", target_rotation, 0.4).as_relative()

func handle_beat(beat_number):
	print(beat_number)
	
	# sanitize
	if beat_number == beat_number_old:
		return
	else:
		beat_number_old = beat_number
	
	var beat_this_bar = beat_number % BARS + 1
	
	# update labels
	set_label_text(str(beat_this_bar), str(beat_number + 1))
	
	# handle empty beats
	if beat_number in range(54, 64):
		return
	
	# handle color + scale fx
	var color = Color(0, 0, 0, 1)
	var scaleVal = 1.0
	match beat_this_bar:
		1:
			color = Color(0, 0.726, 0.726)
			scale_tween_normal.play()
		2:
			color = Color(0.5, 0.5, 0.5, 1)
		3:
			color = Color(0, 0, 0, 1)
		4: 
			color = Color(0, 0, 1, 1)
			scale_tween_large.play()

			if (beat_number + 1) % 32 == 0:
				if randf() < 0.5:
					rotate_x_left_tween.play()
				else:
					rotate_x_right_tween.play()
			else:
				if (beat_number + 1) % 16 == 0:
					rotate_xy_tween.play()
				else:
					if randf() < 0.5:
						rotate_y_left_tween.play()
					else:
						rotate_y_right_tween.play()
	
	csg_box_3d.material.albedo_color = color

func get_beat_number() -> int:
	var time = 0.0
	if sync_source == SyncSource.SYSTEM_CLOCK:
		# Obtain from ticks.
		time = (Time.get_ticks_usec() - time_begin) / 1000000.0
		# Compensate.
		time -= time_delay
	elif sync_source == SyncSource.SOUND_CLOCK:
		time = audio_stream_player.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() + (1 / COMPENSATE_HZ) * COMPENSATE_FRAMES

	var beat = int(time * BPM / 60.0)
	var seconds = int(time)
	var seconds_total = int(audio_stream_player.stream.get_length())
	#$Label.text = str("BEAT: ", beat % BARS + 1, "/", BARS, " TIME: ", seconds / 60, ":", strsec(seconds % 60), " / ", seconds_total / 60, ":", strsec(seconds_total % 60))
	
	var printDebug = str("BEAT: ", beat % BARS + 1, "/", BARS, " TIME: ", seconds / 60, ":", strsec(seconds % 60), " / ", seconds_total / 60, ":", strsec(seconds_total % 60))
	#print(printDebug)
	
	return beat

func set_label_text(text1:String, text2:String) -> void:
	label.text = text1
	label_2.text = text2

func strsec(secs):
	var s = str(secs)
	if (secs < 10):
		s = "0" + s
	return s
#endregion
