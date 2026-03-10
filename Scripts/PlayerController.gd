class_name PlayerController
extends CharacterBody3D


const SPEED = 8.5
const JUMP_VELOCITY = 10
const TURN_SPEED = 7.5

func _physics_process(delta: float) -> void:
	velocity += basis.z * delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 50

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and false:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("turn_left", "turn_right", "walk_forward", "walk_backward")
	if abs(input_dir.x) > 0:
		rotate(basis.y, -1 * input_dir.x * deg_to_rad(TURN_SPEED))
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	else:
		var direction := (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
