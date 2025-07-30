extends CharacterBody2D

@export var inv: Inv
@export var speed = 400

func getInput(): 
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta):
	getInput()
	move_and_slide()
