extends Node3D

signal began_cleaning
signal finished_cleaning

var isInteractable: bool
var isCleanable: bool
var count: int

func _ready():
	isInteractable = false
	isCleanable = true
	count = 4

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and isCleanable:
		isInteractable = true
		print("Press F to clean")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D and isCleanable:
		isInteractable = false


func _input(event):
	if isInteractable and event.is_action_pressed("interact"):
		if(count == 4):
			began_cleaning.emit()
		if(count == 0):
			finished_cleaning.emit()
			isInteractable = false
			isCleanable = false
			return
		count-=1
		print("im clikin it")
		
