extends CharacterBody3D

const SPEED: float = 4

@export var curr_speed: float = SPEED
@export var current_camera: Camera3D

var target_velocity = Vector3.ZERO


func pause_player() -> void:
	curr_speed = 0

func unpause_player() -> void:
	curr_speed = SPEED

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

		target_velocity.x = move_dir.x * curr_speed
		target_velocity.z = move_dir.z * curr_speed
	else:
		target_velocity.x = 0
		target_velocity.z = 0

	velocity = target_velocity
	move_and_slide()
