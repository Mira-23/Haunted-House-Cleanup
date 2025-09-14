extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 4

var target_velocity = Vector3.ZERO

@onready var main_hallway_camera: Camera3D = $"../Cameras/Main Hallway Camera"
@onready var main_room_camera: Camera3D = $"../Cameras/Main Room Camera"
@onready var kitchen_camera: Camera3D = $"../Cameras/Kitchen Camera"
@onready var corridor_camera: Camera3D = $"../Cameras/Corridor Camera"
@onready var fridge_camera: Camera3D = $"../Cameras/Fridge Camera"
@onready var fridge_door: Node3D = $"../House/Kitchen/Fridge/FridgeDoor"

var current_camera: Camera3D

func _ready():
	fridge_door.opened_fridge.connect(enter_fridge_mode)
	fridge_door.closed_fridge.connect(close_fridge_mode)
	current_camera = main_hallway_camera


func _on_hallway_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		main_hallway_camera.make_current()
		current_camera = main_hallway_camera


func _on_main_hall_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		main_room_camera.make_current()
		current_camera = main_room_camera


func _on_kitchen_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		kitchen_camera.make_current()
		current_camera = kitchen_camera


func _on_corridor_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		corridor_camera.make_current()
		current_camera = corridor_camera


func enter_fridge_mode() -> void:
	fridge_camera.make_current()
	current_camera = fridge_camera
	speed = 0
	self.visible = false


func close_fridge_mode() -> void:
	kitchen_camera.make_current()
	current_camera = kitchen_camera
	speed = 4
	self.visible = true


func _physics_process(_delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1 
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		var cam_forward = current_camera.global_transform.basis.z
		var cam_right = current_camera.global_transform.basis.x

		cam_forward.y = 0
		cam_right.y = 0
		cam_forward = cam_forward.normalized()
		cam_right = cam_right.normalized()

		var move_dir = (cam_right * direction.x) + (cam_forward * direction.z)
		move_dir = move_dir.normalized()

		var turn_speed: int = 6
		var target_basis = Basis.looking_at(move_dir, Vector3.UP)
		$Pivot.basis = $Pivot.basis.slerp(target_basis, turn_speed * _delta)

		target_velocity.x = move_dir.x * speed
		target_velocity.z = move_dir.z * speed
	else:
		target_velocity.x = 0
		target_velocity.z = 0

	velocity = target_velocity
	move_and_slide()
