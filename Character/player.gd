extends CharacterBody2D

@export var speed = 4000
var block_input: bool = false

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
