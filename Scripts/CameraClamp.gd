extends Camera3D

@export var x_min_deg: float = -56
@export var x_max_deg: float = 56

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rotation_degrees.x < x_min_deg:
		rotation_degrees.x = x_min_deg
	if rotation_degrees.x > x_max_deg:
		rotation_degrees.x = x_max_deg
