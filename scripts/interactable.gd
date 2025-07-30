class_name Interactable
extends Area2D

var player_is_inside: bool = false
@export var interact_prompt: String = "Interact"

signal player_interacted
signal player_entered(prompt: String)
signal player_left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	var game_manager: GameManager = get_tree().root.get_node("GameUI/GameManager")
	if(game_manager == null): return
	player_entered.connect(game_manager.show_interact_prompt)
	player_left.connect(game_manager.destroy_interact_prompt)

func _input(event: InputEvent) -> void:
	if(event.is_action("interact")):
		player_interacted.emit(interact_prompt) 

func _on_body_entered(body: Node2D):
	if(body.is_in_group(&"player")):
		player_entered.emit(interact_prompt)
		player_is_inside = true

func _on_body_exited(body: Node2D):
	if(body.is_in_group(&"player")):
		player_left.emit()
		player_is_inside = false
