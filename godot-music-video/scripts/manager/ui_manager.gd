class_name UIManager extends Node

#region VARIABLE
@export var label_1: Label
@export var label_2: Label
@export var ui_fade_in_animation: AnimationPlayer

const FADE_IN_UI_ANIMATION = "show_labels_anim"
#endregion

#region METHOD - NATIVE
func _ready():
	set_label_text(str(0), str(0))
#endregion

#region METHOD - SIGNALS
func _on_button_pressed() -> void:
	show_ui()
	SignalManager.request_start_app()
#endregion

#region METHOD - UTIL
func show_ui() -> void:
	ui_fade_in_animation.current_animation = FADE_IN_UI_ANIMATION
	ui_fade_in_animation.play()
	
func set_label_text(text1:String, text2:String) -> void:
	label_1.text = text1
	label_2.text = text2
#endregion
