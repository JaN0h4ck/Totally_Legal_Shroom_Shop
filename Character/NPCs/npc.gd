extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var path : Path2D
@export var path_follow : PathFollow2D
@export var move_speed : float = 60.0
@export var loop : bool = false

var last_position : Vector2
var movement : Vector2

func _ready() -> void:
	path_follow.loop = loop
	position = path_follow.global_position
	last_position = position


func _physics_process(delta : float) -> void:
	path_follow.progress += move_speed * delta
	position = path_follow.global_position
	
	movement = position - last_position
	if movement.length() > 0.1:
		animated_sprite.play("walk")
	else:
		animated_sprite.stop()
	
	last_position = position
