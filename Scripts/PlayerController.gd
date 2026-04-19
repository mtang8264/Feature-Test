class_name PlayerController
extends CharacterBody3D

const SPEED = 2.0
const JUMP_VELOCITY = 10
const TURN_SPEED = 0.25
const NOD_SPEED = 0.1

const INTERACTION_MASK = 16
const INTERACTION_RAY_LENGTH = 2.0

@onready var cam : Camera3D = find_child("Camera3D")

func _physics_process(delta: float) -> void:
	if GameController.current_state == GameController.GAME_STATES.WALKING and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_player_movement(delta)
		
	print(_interactable_check())

func _input(event: InputEvent) -> void:
	# Mouse motion that translates to camera movement
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_camera_move(event.screen_relative)

func _player_movement(delta: float) -> void:
	velocity += basis.z * delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 50

	# Handle jump.
	# Jump is currently disabled.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and false:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_backward")

	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _camera_move(motion: Vector2):
	# Turn the whole player so that the walking is alwasy forward
	var turn := -1 * deg_to_rad(motion.x * TURN_SPEED)
	rotate(up_direction, turn)
	# Nod just the camera so nothing gets weird
	var nod := -1 * deg_to_rad(motion.y * NOD_SPEED)
	cam.rotate_x(nod)
	pass

func _interactable_check() -> Dictionary:
	var space_state = get_world_3d().direct_space_state
	var origin = cam.global_position
	var end = origin - cam.global_basis.z * INTERACTION_RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, INTERACTION_MASK)
	query.collide_with_areas = true
	var results = space_state.intersect_ray(query)
	return results
