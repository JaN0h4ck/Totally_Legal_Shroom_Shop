class_name Player
extends CharacterBody2D

@onready var sprite_animation = $AnimatedSprite2D
var last_direction : String = "f"

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
	return input_direction

func _physics_process(delta: float):
	if block_input: return
	var input_direction = getInput(delta)
	move_and_slide()
	
	play_animation(input_direction)


func _on_dialogue_started():
	block_input = true

func _on_dialogue_ended():
	block_input = false

func play_animation(input_direction):
	if input_direction.y > 0:
		sprite_animation.play("walk_forward")
		last_direction = "f"
	elif input_direction.y < 0:
		sprite_animation.play("walk_backward")
		last_direction = "b"
	elif input_direction.x > 0:
		sprite_animation.play("walk_right")
		last_direction = "r"
	elif input_direction.x < 0:
		sprite_animation.play("walk_left")
		last_direction = "l"
	else:
		if last_direction == "f":
			sprite_animation.play("idle_front")
		elif last_direction == "b":
			sprite_animation.play("idle_back")
		elif last_direction == "r":
			sprite_animation.play("idle_right")
		elif last_direction == "l":
			sprite_animation.play("idle_left")
