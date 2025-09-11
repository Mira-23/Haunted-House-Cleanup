extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 4

var target_velocity = Vector3.ZERO

@onready var main_hallway_camera: Camera3D = $"../Cameras/Main Hallway Camera"
@onready var main_room_camera: Camera3D = $"../Cameras/Main Room Camera"
@onready var kitchen_camera: Camera3D = $"../Cameras/Kitchen Camera"
@onready var corridor_camera: Camera3D = $"../Cameras/Corridor Camera"

var current_camera: Camera3D

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
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		$Pivot.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Moving the Character
	velocity = target_velocity
	move_and_slide()


func _on_hallway_body_entered(_body: Node3D) -> void:
	main_hallway_camera.make_current()
	current_camera = main_hallway_camera


func _on_main_hall_body_entered(_body: Node3D) -> void:
	main_room_camera.make_current()
	current_camera = main_room_camera


func _on_kitchen_body_entered(_body: Node3D) -> void:
	kitchen_camera.make_current()
	current_camera = kitchen_camera


func _on_corridor_body_entered(_body: Node3D) -> void:
	corridor_camera.make_current()
	current_camera = corridor_camera


func _on_kitchen_body_exited(_body: Node3D) -> void:
	main_room_camera.make_current()
	current_camera = main_room_camera
