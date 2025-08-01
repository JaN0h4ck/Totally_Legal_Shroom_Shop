extends Node2D

@onready var anim = $AnimatedSprite2D
@export var count: int = 0


func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("ui_left")):
			count -= 1
			page()
	if(Input.is_action_just_pressed("ui_right")):
			count += 1
			page()
	if(Input.is_action_pressed("ui_cancel")):
		EventBus.lexicon_back.emit()
		

func page():
	match count:
		0: anim.play("Page1")
		1: anim.play("Page2")
		2: anim.play("Page3")
		3: anim.play("Page4")
		4: anim.play("Page5")
		5: anim.play("Page6")
