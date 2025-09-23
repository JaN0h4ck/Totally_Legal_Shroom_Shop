extends Node2D

@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.order_complete.connect(play_audio)

func play_audio():
	audio_stream_player.play()
