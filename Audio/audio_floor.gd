class_name AudioFloor
extends Area2D

enum FloorTypes { Concrete, Rug, Soil, Wood }

@export var floor_type: FloorTypes = FloorTypes.Wood

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D):
	if area.has_method("set_floor_type"):
		area.set_floor_type(floor_type)
