class_name TweenManager extends Node

#region VARIABLE
@export var mesh_manager:MeshManager

var scale_tween_normal:Tween
var scale_tween_large:Tween
var rotate_x_left_tween:Tween
var rotate_x_right_tween:Tween
var rotate_y_left_tween:Tween
var rotate_y_right_tween:Tween
var rotate_xy_tween:Tween
#endregion

#region METHOD - INIT
func init(box_mesh:CSGBox3D) -> void:
	init_scale_tween_normal(box_mesh)
	init_scale_tween_large(box_mesh)

	init_rotate_x_left_tween(box_mesh)
	init_rotate_x_right_tween(box_mesh)
	
	init_rotate_y_left_tween(box_mesh)
	init_rotate_y_right_tween(box_mesh)

	init_rotate_xy_tween(box_mesh)

func init_scale_tween_normal(mesh) -> void:
	var scale_val = 1.0
	
	scale_tween_normal = TweenNode.create_reusable_tween()
	scale_tween_normal.tween_property(mesh, "scale", Vector3(scale_val, scale_val, scale_val), 0.1)

func init_scale_tween_large(mesh) -> void:
	var scale_val = 1.25
	
	scale_tween_large = TweenNode.create_reusable_tween()
	scale_tween_large.tween_property(mesh, "scale", Vector3(scale_val, scale_val, scale_val), 0.1)

func init_rotate_x_left_tween(mesh) -> void:
	var x_degrees: float = -360 
	var y_degrees: float = 0
	var z_degrees: float = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_x_left_tween = TweenNode.create_reusable_tween()
	rotate_x_left_tween.tween_property(mesh, "rotation", target_rotation, 0.4).as_relative()

func init_rotate_x_right_tween(mesh) -> void:
	var x_degrees = 180 
	var y_degrees = 0
	var z_degrees = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_x_right_tween = TweenNode.create_reusable_tween()
	rotate_x_right_tween.tween_property(mesh, "rotation", target_rotation, 0.4).as_relative()

func init_rotate_y_left_tween(mesh) -> void:
	var x_degrees = 0 
	var y_degrees = -45
	var z_degrees = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_y_left_tween = TweenNode.create_reusable_tween()
	rotate_y_left_tween.tween_property(mesh, "rotation", target_rotation, 0.4).as_relative()
	
func init_rotate_y_right_tween(mesh) -> void:
	var x_degrees = 0 
	var y_degrees = 45
	var z_degrees = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_y_right_tween = TweenNode.create_reusable_tween()
	rotate_y_right_tween.tween_property(mesh, "rotation", target_rotation, 0.4).as_relative()

func init_rotate_xy_tween(mesh) -> void:
	var x_degrees = -720 
	var y_degrees = 45
	var z_degrees = 45

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_xy_tween = TweenNode.create_reusable_tween()
	rotate_xy_tween.set_trans(Tween.TRANS_SINE)
	rotate_xy_tween.tween_property(mesh, "rotation", target_rotation, 5.0).as_relative()
#endregion

#region METHOD - PLAY
func scale_normal() -> void:
	scale_tween_normal.play()
	
func scale_large() -> void:
	scale_tween_large.play()
	
func rotate_x_left() -> void:
	rotate_x_left_tween.play()
	
func rotate_x_right() -> void:
	rotate_x_right_tween.play()
	
func rotate_y_left() -> void:
	rotate_y_left_tween.play()
	
func rotate_y_right() -> void:
	rotate_y_right_tween.play()
	
func rotate_xy() -> void:
	rotate_xy_tween.play()
#endregion
