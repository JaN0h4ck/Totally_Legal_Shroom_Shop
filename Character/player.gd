class_name Player
extends CharacterBody2D

@export var speed = 4000
var block_input: bool = false
var _is_inside: bool = false
var is_inside_interactable: bool:
	get: return _is_inside
	set(value):
		if(not value and interactable_queue.size() > 0):
			var interactable: Interactable = interactable_queue.pop_front()
			if interactable.player_is_inside:
				interactable.emit_inside()
		else:
			_is_inside = value
var interactable_queue: Array[Interactable]

func _ready() -> void:
	EventBus.dialog_started.connect(_on_dialogue_started)
	EventBus.dialog_ended.connect(_on_dialogue_ended)

func getInput(delta: float): 
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = input_direction * speed * delta

func _physics_process(delta: float):
	if block_input: return
	getInput(delta)
	move_and_slide()

func _on_dialogue_started():
	block_input = true

func _on_dialogue_ended():
	block_input = false
