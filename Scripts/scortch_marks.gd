extends Node3D

@onready var sponge: MeshInstance3D = $"../../../Sponge"

@onready var area_3d: Area3D = $Area3D
@export var sp_material: Material
@onready var scortch_camera: Camera3D = $"../../../Cameras/Scortch Camera"

@onready var scortch_1: Area3D = $Scortch1
@onready var scortch_2: Area3D = $Scortch2
@onready var scortch_3: Area3D = $Scortch3
@onready var scortch_4: Area3D = $Scortch4

var is_following_mouse

signal began_cleaning
signal finished_cleaning

var isInteractable: bool
var isCleanable: bool
var count: int
var original_sponge_coords: Vector3
var original_sponge_rotation: Vector3

func _ready():
	original_sponge_coords = sponge.position
	original_sponge_rotation = sponge.rotation
	isInteractable = false
	isCleanable = true
	is_following_mouse = false
	count = 4


func _process(_delta: float) -> void:
	if is_following_mouse:
		var pos : Vector3 = scortch_camera.project_position(
			get_viewport().get_mouse_position(),
			0.485
			)
		sponge.position = Vector3(pos.x,pos.y,pos.z)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and isCleanable:
		isInteractable = true
		sponge.material_overlay = sp_material
		print("Press F to clean")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D and isCleanable:
		isInteractable = false
		sponge.material_overlay = null


func _input(event):
	if isInteractable and event.is_action_pressed("interact"):
		is_following_mouse = true
		began_cleaning.emit()
		area_3d.visible = false
		sponge.material_overlay = null
		isInteractable = false
		isCleanable = false


func cleaning_event() -> void:
	if count==0:
		finished_cleaning.emit()
		is_following_mouse = false
		sponge.position = original_sponge_coords
		sponge.rotation = original_sponge_rotation
		self.visible = false


func _on_scortch_1_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	clean_mark(event, scortch_1)


func _on_scortch_2_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	clean_mark(event, scortch_2)


func _on_scortch_3_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	clean_mark(event, scortch_3)


func _on_scortch_4_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	clean_mark(event, scortch_4)


func clean_mark(event: InputEvent, scortch: Area3D):
	if event.is_action_released("mouse_left"):
		count-=1
		scortch.visible = false
		cleaning_event()
