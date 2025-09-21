extends CharacterBody2D
class_name base_npc

# Animated Sprite 2D muss folgende Animationen haben:
# "fall_down" "idle_back" "idle_front" "idle_left" "idle_right"
# "walk_left" "walk_right" "walk_forward" "walk_backward"
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var portrait: Texture2D
@export var lines: Array[String]
@export var path : Path2D
@export var path_follow : PathFollow2D
@export var move_speed : float = 40.0
@export var loop_path : bool = false

@export var npc_name : GLOBALS.npc_names

@export var rarity : GLOBALS.rarity

@onready var object_place: Node2D = $object_place

var path_number : int
var last_position : Vector2
var movement : Vector2

var last_direction : String = "f"
var falling : bool = false

var on_trapdoor : bool = false

func _ready() -> void:
	path_follow.loop = loop_path
	global_position = path_follow.global_position
	last_position = global_position
	
	EventBus.npc_entered_trapdoor.connect(enter_trapdoor)
	EventBus.npc_left_trapdoor.connect(exit_trapdoor)
	EventBus.interact_lever.connect(start_falling)


func _physics_process(delta : float) -> void:
	path_follow.progress += move_speed * delta
	global_position = path_follow.global_position
	
	play_animation()

func is_moving() -> bool:
	return not is_zero_approx(movement.length())

func play_animation():
	if falling == true:
		return
	
	movement = global_position - last_position
	last_position = global_position
	
	if is_moving():
		if abs(movement.x) > abs(movement.y):
			if movement.x > 0:
				animated_sprite.play("walk_right")
				last_direction = "r"
			else:
				animated_sprite.play("walk_left")
				last_direction = "l"
		else:
			if movement.y > 0:
				animated_sprite.play("walk_forward")
				last_direction = "f"
			else:
				animated_sprite.play("walk_backward")
				last_direction = "b"
	else:
		if last_direction == "f":
			animated_sprite.play("idle_front")
		elif last_direction == "b":
			animated_sprite.play("idle_back")
		elif last_direction == "r":
			animated_sprite.play("idle_right")
		elif last_direction == "l":
			animated_sprite.play("idle_left")


func enter_trapdoor(_npc: base_npc):
	on_trapdoor = true

func exit_trapdoor():
	on_trapdoor = false

func start_falling():
	if not on_trapdoor:
		return
	
	falling = true
	animated_sprite.play("fall_down")
	animated_sprite.animation_finished.connect(fall_down)

func fall_down():
	falling = false
	EventBus.npc_dropped.emit(npc_name)
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		self.z_index = 1


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		self.z_index = -1
