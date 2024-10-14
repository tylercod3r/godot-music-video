extends Node

#region VARIABLE
signal start_app_signal
#endregion

#region METHOD - GAME
func request_start_app() -> void:
	start_app_signal.emit()
#endregion
