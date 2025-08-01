class_name PickableObject
extends RigidBody2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var isPickedUp := false
var animationTime := 0.5
var player: Player

func _ready() -> void:
	freeze = true
	collision_shape_2d.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group(&"player"):
		player = null
		
func _input(event: InputEvent) -> void:
	if player != null and player.carried_item == null and event.is_action_pressed("interact"):
		player.carried_item = self
		_pick_up_animation()
		isPickedUp = true
		player = null

func _pick_up_animation():
	player = get_tree().get_first_node_in_group("player")
	
	player.pick_up(animationTime)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", player.global_position + Vector2(0, -14), animationTime)
	await tween.finished
	
#	reparent(player)
