class_name MeshManager extends Node

#region VARIABLE
@export var box_mesh: CSGBox3D
#endregion

#region METHOD - UTIL
func color_box(color) -> void:
	box_mesh.material.albedo_color = color
#endregion
