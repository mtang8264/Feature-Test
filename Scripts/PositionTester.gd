extends Node3D

@export var node_name: String
@onready var door_node : Node3D = find_child(node_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(door_node.global_position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
