class_name MeshManager extends Node

#region VARIABLE
@export var box_meshes:Array[CSGBox3D]
#endregion

#region METHOD - UTIL
func color_box(color) -> void:
	box_meshes[0].material.albedo_color = color
#endregion
