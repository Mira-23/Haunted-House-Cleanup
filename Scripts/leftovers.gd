extends Node3D

@onready var leftovers: MeshInstance3D = $model
@export var material: Material
@export var enabled: bool


func _ready():
	leftovers.material_overlay = null


func _on_area_3d_mouse_entered() -> void:
	if enabled:
		leftovers.material_overlay = material


func _on_area_3d_mouse_exited() -> void:
	if enabled:
		leftovers.material_overlay = null


func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if enabled and event is InputEventMouseButton:
		enabled = false
		leftovers.visible = false
