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

#region METHOD - NATIVE
func _ready():
	init()
#endregion

#region METHOD - INIT
func init() -> void:
	init_scale_tween_normal()
	init_scale_tween_large()

	init_rotate_x_left_tween()
	init_rotate_x_right_tween()
	
	init_rotate_y_left_tween()
	init_rotate_y_right_tween()

	init_rotate_xy_tween()

func init_scale_tween_normal() -> void:
	scale_tween_normal = TweenNode.create_reusable_tween()
	var scale_val = 1.0
	scale_tween_normal.tween_property(mesh_manager.box_mesh, "scale", Vector3(scale_val, scale_val, scale_val), 0.1)

func init_scale_tween_large() -> void:
	scale_tween_large = TweenNode.create_reusable_tween()
	var scale_val = 1.25
	scale_tween_large.tween_property(mesh_manager.box_mesh, "scale", Vector3(scale_val, scale_val, scale_val), 0.3)

func init_rotate_x_left_tween() -> void:
	rotate_x_left_tween = TweenNode.create_reusable_tween()
	
	var x_degrees: float = -360 
	var y_degrees: float = 0
	var z_degrees: float = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_x_left_tween.tween_property(mesh_manager.box_mesh, "rotation", target_rotation, 0.3).as_relative()

func init_rotate_x_right_tween() -> void:
	rotate_x_right_tween = TweenNode.create_reusable_tween()
	
	var x_degrees = 360 
	var y_degrees = 0
	var z_degrees = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_x_right_tween.tween_property(mesh_manager.box_mesh, "rotation", target_rotation, 0.3).as_relative()

func init_rotate_y_left_tween() -> void:
	rotate_y_left_tween = TweenNode.create_reusable_tween()
	
	var x_degrees = 0 
	var y_degrees = -45
	var z_degrees = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_y_left_tween.tween_property(mesh_manager.box_mesh, "rotation", target_rotation, 0.1).as_relative()
	
func init_rotate_y_right_tween() -> void:
	rotate_y_right_tween = TweenNode.create_reusable_tween()
	
	var x_degrees = 0 
	var y_degrees = 45
	var z_degrees = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_y_right_tween.tween_property(mesh_manager.box_mesh, "rotation", target_rotation, 0.1).as_relative()

func init_rotate_xy_tween() -> void:
	rotate_xy_tween = TweenNode.create_reusable_tween()
	
	var x_degrees = -360 
	var y_degrees = 45
	var z_degrees = 0

	var target_rotation = Vector3(
		deg_to_rad(x_degrees),
		deg_to_rad(y_degrees),
		deg_to_rad(z_degrees)
	)
	
	rotate_xy_tween.tween_property(mesh_manager.box_mesh, "rotation", target_rotation, 0.4).as_relative()
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
