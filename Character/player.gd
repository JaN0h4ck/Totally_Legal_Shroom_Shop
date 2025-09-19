class_name Player
extends CharacterBody2D

@onready var sprite_animation = $AnimatedSprite2D
var current_direction : GLOBALS.directions = GLOBALS.directions.NONE
var last_direction : GLOBALS.directions = GLOBALS.directions.FRONT

var current_floor: AudioFloor.FloorTypes = AudioFloor.FloorTypes.Wood

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

func _physics_process(delta: float):
	if block_input: return
	var input_direction = get_buffered_direction()
	velocity = input_direction * speed * delta
	move_and_slide()
	
	if velocity.is_zero_approx():
		select_idle()
	else:
		play_walking_animation()
	
	if Input.is_action_just_pressed("drop_object") and carries_object:
		EventBus.drop_object.emit()
		carries_object = false

func get_buffered_direction() -> Vector2:
	match current_direction:
		GLOBALS.directions.NONE:
			if Input.is_action_pressed("move_down"):
				current_direction = GLOBALS.directions.FRONT
				return Vector2.DOWN
			if Input.is_action_pressed("move_up"):
				current_direction = GLOBALS.directions.BACK
				return Vector2.UP
			if Input.is_action_pressed("move_left"):
				current_direction = GLOBALS.directions.LEFT
				return Vector2.LEFT
			if Input.is_action_pressed("move_right"):
				current_direction = GLOBALS.directions.RIGHT
				return Vector2.RIGHT
			return Vector2.ZERO
		GLOBALS.directions.FRONT:
			if(Input.is_action_just_released("move_down")):
				current_direction = GLOBALS.directions.NONE
				return Vector2.ZERO
			else: return Vector2.DOWN
		GLOBALS.directions.BACK:
			if(Input.is_action_just_released("move_up")):
				current_direction = GLOBALS.directions.NONE
				return Vector2.ZERO
			else: return Vector2.UP
		GLOBALS.directions.LEFT:
			if(Input.is_action_just_released("move_left")):
				current_direction = GLOBALS.directions.NONE
				return Vector2.ZERO
			else: return Vector2.LEFT
		GLOBALS.directions.RIGHT:
			if(Input.is_action_just_released("move_right")):
				current_direction = GLOBALS.directions.NONE
				return Vector2.ZERO
			else: return Vector2.RIGHT
		_: 
			return Vector2.ZERO

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

func play_walking_animation():
	match current_direction:
		GLOBALS.directions.FRONT:
			sprite_animation.play("walk_forward")
			last_direction = GLOBALS.directions.FRONT
		GLOBALS.directions.BACK:
			sprite_animation.play("walk_backward")
			last_direction = GLOBALS.directions.BACK
		GLOBALS.directions.RIGHT:
			sprite_animation.play("walk_right")
			last_direction = GLOBALS.directions.RIGHT
		GLOBALS.directions.LEFT:
			sprite_animation.play("walk_left")
			last_direction = GLOBALS.directions.LEFT
