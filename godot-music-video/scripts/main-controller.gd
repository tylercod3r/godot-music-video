class_name MainController extends Node3D

#region VARIABLE
@export var ui_manager:UIManager 
@export var music_manager:MusicManager
#endregion

#region METHOD - NATIVE
func _ready():
	SignalManager.start_app_signal.connect(handle_start_app_signal)
#endregion

#region METHOD - SIGNAL
func handle_start_app_signal() -> void:
	start_app()
#endregion

#region METHOD - UTIL
func start_app() -> void:
	music_manager.start_music()
#endregion
