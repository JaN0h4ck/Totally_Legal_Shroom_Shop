class_name Interactable
extends Area2D

var player_is_inside: bool = false
@export var interact_prompt: String = "Interact"

signal player_interacted
signal player_entered(prompt: String, interactable_name: String)
signal player_left(interactable_name: String)

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
		player_interacted.emit() 
		get_viewport().set_input_as_handled()

func _on_body_entered(body: Node2D):
	if(body.is_in_group(&"player")):
		var player: Player = body
		player_is_inside = true
		if(player.is_inside_interactable):
			player.interactable_queue.push_back(self)
			return
		player_entered.emit(interact_prompt, name)
		player.is_inside_interactable = true

func emit_inside():
	player_entered.emit(interact_prompt, name)

func _on_body_exited(body: Node2D):
	if(body.is_in_group(&"player")):
		player_left.emit(name)
		player_is_inside = false
		body.is_inside_interactable = false
