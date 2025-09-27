class_name Player
extends CharacterBody2D

@onready var sprite_animation = $AnimatedSprite2D
var last_direction : GLOBALS.directions = GLOBALS.directions.FRONT

var current_floor: AudioFloor.FloorTypes = AudioFloor.FloorTypes.Wood
var current_in_shop : bool = true

@export var speed = 4000
var block_input: bool = false

@onready var object_place: Node2D = $object_place
var carries_object : bool = false

var _is_inside: bool = false
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
	EventBus.inventory_updated.connect(check_if_still_carring_object)


func _physics_process(delta: float):
	if block_input: return
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	var dir: GLOBALS.directions = get_dir_from_input(input_direction)
	velocity = input_direction * speed * delta
	move_and_slide()
	
	if velocity.is_zero_approx():
		_select_idle_animation(last_direction, dir)
	else:
		play_walking_animation(dir)
	
	if Input.is_action_just_pressed("drop_object") and carries_object:
		EventBus.drop_object.emit()
		carries_object = false

func get_dir_from_input(vec: Vector2) -> GLOBALS.directions:
	if vec.is_zero_approx():
		return GLOBALS.directions.NONE
	var x: float = vec.x
	x = absf(x)
	var y: float = vec.y
	y = absf(y)
	#stick gibt mehr movement auf y
	if y > x:
		if vec.y > 0:
			return GLOBALS.directions.FRONT
		else:
			return GLOBALS.directions.BACK
	else:
		if vec.x > 0:
			return GLOBALS.directions.RIGHT
		else:
			return GLOBALS.directions.LEFT

func _on_dialogue_started():
	block_input = true
	velocity = Vector2.ZERO

func _on_dialogue_ended():
	block_input = false

# Selects the proper Idle Animation based on the last and current direction dir = last_dir, input_dir = current_dir
func _select_idle_animation(dir: GLOBALS.directions, input_dir : GLOBALS.directions = GLOBALS.directions.NONE ):
	if input_dir != GLOBALS.directions.NONE:
		_select_idle_animation(input_dir)
		return
	match dir:
		GLOBALS.directions.FRONT:
			sprite_animation.play("idle_front")
		GLOBALS.directions.BACK:
			sprite_animation.play("idle_back")
		GLOBALS.directions.RIGHT:
			sprite_animation.play("idle_right")
		GLOBALS.directions.LEFT:
			sprite_animation.play("idle_left")
	last_direction = dir

func enter_basement():
	current_in_shop = false

func enter_shop():
	current_in_shop = true

func play_walking_animation(current_dir: GLOBALS.directions):
	match current_dir:
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

func check_if_still_carring_object():
	for child in object_place.get_children():
		if child != null:
			return
	carries_object = false
