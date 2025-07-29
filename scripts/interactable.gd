extends Area2D

var player_is_inside: bool = false

signal player_interacted

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _input(event: InputEvent) -> void:
	if(event.is_action("interact")):
		player_interacted.emit() 

func _on_body_entered(body: Node2D):
	if(body.is_in_group(&"player")):
		player_is_inside = true

func _on_body_exited(body: Node2D):
	if(body.is_in_group(&"player")):
		player_is_inside = false
