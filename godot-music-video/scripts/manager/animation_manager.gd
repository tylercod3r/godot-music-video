class_name AnimationManager extends Node

#region VARIABLE
@export var tween_manager: TweenManager
@export var mesh_manager:MeshManager
#endregion

#region METHOD - ANIMATE
func animate_to_beat(beat_number:int, beat_this_bar:int) -> void:
	# init props
	var color = Color(0, 0, 0, 1)
	var scaleVal = 1.0
	
	# handle empties
	# song length = 704 beats
	if beat_number in range(50, 60):
		return
	if beat_number > 654:
		return

	# handle 16-count
	if beat_number % 16 == 0:
		tween_manager.init(mesh_manager.box_meshes[0])
		
		color = Color(0, 1, 0, 1)
		tween_manager.scale_large()
		tween_manager.rotate_x_right()
		#tween_manager.rotate_xy()
	
	# handle 8-count
	elif beat_number % 8 == 0:
		var val = randi_range(2, len(mesh_manager.box_meshes))
		tween_manager.init(mesh_manager.box_meshes[val - 1])
		
		color = Color(0.4, 0.4, 1, 1)
		tween_manager.scale_normal()
		#tween_manager.rotate_x_right()
		tween_manager.rotate_xy()
	
	# finalize fx
	mesh_manager.color_box(color)
#endregion
