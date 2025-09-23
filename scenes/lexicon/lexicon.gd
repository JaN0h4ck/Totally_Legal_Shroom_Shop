extends Node2D

const FIRST_PAGE: int = 0
const LAST_PAGE: int = 8

@onready var anim = $AnimatedSprite2D
@export var count: int = 0
@onready var sub_viewport_container: SubViewportContainer = $"../.."
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	anim.play("Page1")
	get_tree().paused = true

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("ui_left")):
		var old = count
		count -= 1
		count = clampi(count, FIRST_PAGE, LAST_PAGE)
		page()
		play_audio(old)
		return
	if(Input.is_action_just_pressed("ui_right")):
		var old = count
		count += 1
		count = clampi(count, FIRST_PAGE, LAST_PAGE)
		page()
		play_audio(old)
		return
	if(Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("joy_cancel")):
		get_tree().paused = false
		sub_viewport_container.queue_free()

func page():
	match count:
		0: anim.play("Page1")
		1: anim.play("Page2")
		2: anim.play("Page3")
		3: anim.play("Page4")
		4: anim.play("Page5")
		5: anim.play("Page6")
		6: anim.play("Page7")
		7: anim.play("Page8")
		8: anim.play("Page9")

func play_audio(old: int):
	if count == old: return
	audio_stream_player.play()
