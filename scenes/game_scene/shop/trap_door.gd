extends AnimatedSprite2D

const TRAPDOOR_OPEN = preload("uid://6iqip6btc1qb")
const TRAPDOOR_CLOSE = preload("uid://yfurfc6tl07b")

@onready var timer : Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
var npc_on_trapdoor : bool = false

func _ready():
	EventBus.interact_lever.connect(open)

func open():
	if not npc_on_trapdoor:
		return
		
	play("open")
	audio_stream_player.stream = TRAPDOOR_OPEN
	audio_stream_player.play()
	timer.start()

func close():
	play("close")
	audio_stream_player.stream = TRAPDOOR_CLOSE
	audio_stream_player.play()


func _on_timer_timeout():
	close()


func _on_area_2d_body_entered(body):
	if body is base_npc:
		EventBus.npc_entered_trapdoor.emit(body)
		npc_on_trapdoor = true

func _on_area_2d_body_exited(body):
	if body is base_npc:
		EventBus.npc_left_trapdoor.emit()
		npc_on_trapdoor = false
