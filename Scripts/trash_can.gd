extends Node3D

@onready var trash_can_2: MeshInstance3D = $trash_can/trash_can2
@onready var trash_lid_2: MeshInstance3D = $trash_lid/trash_lid2


var isInteractable:bool

func _ready():
	isInteractable = false;
	trash_can_2.visible = false
	trash_lid_2.visible = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		isInteractable = true
		trash_can_2.visible = true
		trash_lid_2.visible = true
		print("Press F to interact")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		isInteractable = false
		trash_can_2.visible = false
		trash_lid_2.visible = false


func _input(event):
	if isInteractable and event.is_action_pressed("interact"):
		print("It's empty. Like...")
