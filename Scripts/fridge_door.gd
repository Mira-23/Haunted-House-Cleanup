extends Node3D

signal opened_fridge
signal closed_fridge

@onready var outline: MeshInstance3D = $"Fridge (Main Door)_001/fridge door outline"
@onready var door: MeshInstance3D = $"Fridge (Main Door)_001"

var isInteractable:bool

func _ready():
	isInteractable = false;
	outline.visible = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		isInteractable = true
		outline.visible = true
		print("Press F to interact")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		isInteractable = false
		outline.visible = false


func _input(event):
	if isInteractable and outline.visible == false and event.is_action_pressed("interact"):
			closed_fridge.emit()
			isInteractable = true
			var tween = create_tween()
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(door, "rotation_degrees", Vector3(90.0,90.0,0.0), 0.75)
			await tween.finished
			outline.visible = true
			return
	if isInteractable and event.is_action_pressed("interact"):
		outline.visible = false
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(door, "rotation_degrees", Vector3(90.0,90.0,-90.0), 0.75)
		opened_fridge.emit()
