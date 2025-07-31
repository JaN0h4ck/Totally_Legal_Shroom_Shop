class_name AudioFloor
extends Area2D

enum FloorTypes { Concrete, Rug, Soil, Wood }

@export var floor_type: FloorTypes = FloorTypes.Wood

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group(&"stepper") and body.has_method("set_floor_type"):
		body.set_floor_type(floor_type)
