extends CharacterBody2D

@export var speed = 4000

func getInput(delta: float): 
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = input_direction * speed * delta

func _physics_process(delta: float):
	getInput(delta)
	move_and_slide()
