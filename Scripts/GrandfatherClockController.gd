extends Node

var timer := 0.5

@export var hour: int = 2
@export var minute: float = 55
@export var pendulum_swing: bool = true
@export var pendulum_speed_multiplier: float = 1.0

@onready var hour_hand := find_child("HourHand")
@onready var minute_hand := find_child("MinuteHand")
@onready var pendulum := find_child("Pendulum")

const pendulum_range := 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_hour_hand()
	rotate_minute_hand()
	if pendulum_swing:
		swing_pendulum(delta)
	pass

func rotate_hour_hand() -> void:
	var base_rotation:float = 360.0 - ( hour / 12.0 * 360.0 )
	var minute_offset:float = 360.0 / 12.0 * (minute/60.0)
	var target_rotation = base_rotation - minute_offset
	hour_hand.rotation_degrees.z = lerp(hour_hand.rotation_degrees.z, target_rotation, 0.1)
	pass

func rotate_minute_hand() -> void:
	var target_rotation = 360 - ( minute / 60 * 360 )
	minute_hand.rotation_degrees.z = lerp(minute_hand.rotation_degrees.z, target_rotation, 0.1)
	pass
	
func swing_pendulum(delta: float) -> void:
	timer += delta
	var mag = cos(PI * timer) * pendulum_range
	pendulum.rotation_degrees.z = mag
	pass
