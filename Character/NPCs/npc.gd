extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var path : Path2D
@export var path_follow : PathFollow2D
@export var move_speed : float = 60.0
@export var loop_path : bool = false

var last_position : Vector2
var movement : Vector2

var last_direction : String = "f"
var falling : bool = false

func _ready() -> void:
	path_follow.loop = loop_path
	position = path_follow.global_position
	last_position = position
	EventBus.interact_lever.connect(start_falling)


func _physics_process(delta : float) -> void:
	path_follow.progress += move_speed * delta
	position = path_follow.global_position
	
	movement = position - last_position
	last_position = position
	
	play_animation()

func play_animation():
	if falling == true:
		return
	if not movement.x == 0 or not movement.y == 0:
		animated_sprite.play("walk")
	else:
		if last_direction == "f":
			animated_sprite.play("stand_front")
		elif last_direction == "b":
			animated_sprite.play("stand_back")
		elif last_direction == "r":
			animated_sprite.play("stand_right")
		elif last_direction == "l":
			animated_sprite.play("stand_left")
	
	if movement.y > 0:
		last_direction = "f"
	elif movement.y < 0:
		last_direction = "b"
	elif movement.x > 0:
		last_direction = "r"
	elif movement.x < 0:
		last_direction = "l"

func start_falling():
	falling = true
	animated_sprite.play("fall")
	animated_sprite.animation_finished.connect(fall_down)

func fall_down():
	falling = false
	queue_free()
