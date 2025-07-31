extends RigidBody2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var isPickedUp := false
var canPickUp := false

func _ready() -> void:
	freeze = true
	collision_shape_2d.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		if not isPickedUp: canPickUp = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == get_tree().get_first_node_in_group("player"):
		canPickUp = false
