extends Node3D

@export var mesh: MeshInstance3D
@export var material: Material


func _on_area_3d_mouse_entered() -> void:
	mesh.material_overlay = material


func _on_area_3d_mouse_exited() -> void:
	mesh.material_overlay = null
