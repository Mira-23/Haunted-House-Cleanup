extends Node3D

@onready var main_hallway_camera: Camera3D = $"Main Hallway Camera"
@onready var main_room_camera: Camera3D = $"Main Room Camera"
@onready var corridor_camera: Camera3D = $"Corridor Camera"
@onready var fridge_camera: Camera3D = $"Fridge Camera"
@onready var kitchen_camera: Camera3D = $"Kitchen Camera"
@onready var scortch_camera: Camera3D = $"Scortch Camera"

@onready var fridge_door: Node3D = $"../House/Kitchen/Fridge/FridgeDoor"
@onready var scortch_marks: Node3D = $"../House/Kitchen/Scortch Marks"

@onready var player: CharacterBody3D = $"../Player"


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	fridge_door.opened_fridge.connect(enter_fridge_mode)
	fridge_door.closed_fridge.connect(close_fridge_mode)
	scortch_marks.began_cleaning.connect(enter_scortch_cleaning_mode)
	scortch_marks.finished_cleaning.connect(exit_scortch_cleaning_mode)
	player.current_camera = main_hallway_camera


func _on_hallway_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		main_hallway_camera.make_current()
		player.current_camera = main_hallway_camera
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_main_hall_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		main_room_camera.make_current()
		player.current_camera = main_room_camera
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_kitchen_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		kitchen_camera.make_current()
		player.current_camera = kitchen_camera
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_corridor_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		corridor_camera.make_current()
		player.current_camera = corridor_camera
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func enter_fridge_mode() -> void:
	fridge_camera.make_current()
	player.current_camera = fridge_camera
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.pause_player()
	player.visible = false


func close_fridge_mode() -> void:
	kitchen_camera.make_current()
	player.current_camera = kitchen_camera
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.unpause_player()
	player.visible = true


func enter_scortch_cleaning_mode() -> void:
	scortch_camera.make_current()
	player.current_camera = scortch_camera
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.pause_player()
	player.visible = false


func exit_scortch_cleaning_mode() -> void:
	kitchen_camera.make_current()
	player.current_camera = kitchen_camera
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.unpause_player()
	player.visible = true
