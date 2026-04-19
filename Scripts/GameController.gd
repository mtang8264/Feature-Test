extends Node

var current_state : GAME_STATES = GAME_STATES.WALKING

const MAP_REPEAT_OFFSET : Vector3 = Vector3(17.26285, -0.7112, 0.689834)

enum GAME_STATES {WALKING, PAUSED, EVENT}

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	# Mouse escape
	if event is InputEventKey and Input.is_action_just_pressed("mouse_escape") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	# Mouse recapture
	if event is InputEventMouseButton and Input.is_action_just_pressed("click_primary") and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
