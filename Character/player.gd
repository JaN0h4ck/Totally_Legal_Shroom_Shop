class_name Player
extends CharacterBody2D

@onready var sprite_animation = $AnimatedSprite2D
var last_direction : GLOBALS.directions = GLOBALS.directions.FRONT

var current_floor: AudioFloor.FloorTypes = AudioFloor.FloorTypes.Wood
var current_in_shop : bool = true

@export var speed = 4000
var block_input: bool = false
var _is_inside: bool = false

@onready var object_place: Node2D = $object_place
var carries_object : bool = false

var is_inside_interactable: bool:
	get: return _is_inside
	set(value):
		if(not value and interactable_queue.size() > 0):
			if is_instance_valid(interactable_queue[0]):
				var interactable: Interactable = interactable_queue.pop_front()
				if interactable.player_is_inside:
					interactable.emit_inside()
		else:
			_is_inside = value
var interactable_queue: Array[Interactable]

func _ready() -> void:
	EventBus.dialog_started.connect(_on_dialogue_started)
	EventBus.dialog_ended.connect(_on_dialogue_ended)
	EventBus.interact_basement.connect(enter_basement)
	EventBus.interact_shop.connect(enter_shop)

func getInput(delta: float): 
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = input_direction * speed * delta
	return input_direction

func _physics_process(delta: float):
	if block_input: return
	var input_direction = getInput(delta)
	move_and_slide()
	
	if velocity.is_zero_approx():
		select_idle()
	else:
		play_animation(input_direction)
	
	if Input.is_action_just_pressed("drop_object") and carries_object:
		EventBus.drop_object.emit()
		carries_object = false


func _on_dialogue_started():
	block_input = true

func _on_dialogue_ended():
	block_input = false

func select_idle():
	match last_direction:
		GLOBALS.directions.FRONT:
			sprite_animation.play("idle_front")
		GLOBALS.directions.BACK:
			sprite_animation.play("idle_back")
		GLOBALS.directions.RIGHT:
			sprite_animation.play("idle_right")
		GLOBALS.directions.LEFT:
			sprite_animation.play("idle_left")

func play_animation(input_direction):
	if input_direction.y > 0:
		sprite_animation.play("walk_forward")
		last_direction = GLOBALS.directions.FRONT
	elif input_direction.y < 0:
		sprite_animation.play("walk_backward")
		last_direction = GLOBALS.directions.BACK
	elif input_direction.x > 0:
		sprite_animation.play("walk_right")
		last_direction = GLOBALS.directions.RIGHT
	elif input_direction.x < 0:
		sprite_animation.play("walk_left")
		last_direction = GLOBALS.directions.LEFT

func enter_basement():
	current_in_shop = false

func enter_shop():
	current_in_shop = true
