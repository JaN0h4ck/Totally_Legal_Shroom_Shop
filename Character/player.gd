class_name Player
extends CharacterBody2D

enum Directions { FRONT, BACK, LEFT, RIGHT }

@onready var sprite_animation = $AnimatedSprite2D
var last_direction : Directions = Directions.FRONT

var current_floor: AudioFloor.FloorTypes = AudioFloor.FloorTypes.Wood
@onready var footstep_player: FootstepPlayer = $FootstepPlayer

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
	
	if velocity.is_zero_approx():
		select_idle()
		if footstep_player.playing:
			footstep_player.stop()
	else:
		play_animation(input_direction)
		if not footstep_player.playing:
			footstep_player.play()


func _on_dialogue_started():
	footstep_player.stop()
	block_input = true

func _on_dialogue_ended():
	block_input = false

func select_idle():
	match last_direction:
		Directions.FRONT:
			sprite_animation.play("idle_front")
		Directions.BACK:
			sprite_animation.play("idle_back")
		Directions.RIGHT:
			sprite_animation.play("idle_right")
		Directions.LEFT:
			sprite_animation.play("idle_left")

func play_animation(input_direction):
	if input_direction.y > 0:
		sprite_animation.play("walk_forward")
		last_direction = Directions.FRONT
	elif input_direction.y < 0:
		sprite_animation.play("walk_backward")
		last_direction = Directions.BACK
	elif input_direction.x > 0:
		sprite_animation.play("walk_right")
		last_direction = Directions.RIGHT
	elif input_direction.x < 0:
		sprite_animation.play("walk_left")
		last_direction = Directions.LEFT

func set_floor_type(type: AudioFloor.FloorTypes):
	current_floor = type
	footstep_player.change_sound(type)
	
func pick_up(duration):
	
	sprite_animation.play("idle")
	
	await get_tree().create_timer(duration).timeout
