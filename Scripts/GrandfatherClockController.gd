extends Node

@export var hour: int = 2
@export var minute: float = 55
@export var pendulum_swing: bool = true

@onready var hour_hand := find_child("HourHand")
@onready var minute_hand := find_child("MinuteHand")
@onready var anim : AnimationPlayer= find_child("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("PendulumAction")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pendulum_swing and anim.is_playing() == false:
		anim.play("PendulumAction")
	elif not pendulum_swing:
		anim.pause()
	
	rotate_hour_hand()
	rotate_minute_hand()
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
