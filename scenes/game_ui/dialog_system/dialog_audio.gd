class_name DialogAudio
extends AudioStreamPlayer

@export var voice_high: Array[AudioStreamWAV]
@export var voice_medium: Array[AudioStreamWAV]
@export var voice_low: Array[AudioStreamWAV]

var timer: Timer = Timer.new()

func _ready() -> void:
	timer.wait_time = .15
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	if is_playing:
		play()

func start_playback(type: GLOBALS.voice_types):
	set_voice(type)
	playing = true
	timer.start()
	play()

func set_voice(type: GLOBALS.voice_types):
	var randomizer: AudioStreamRandomizer = stream
	match type:
		GLOBALS.voice_types.HIGH:
			for i in range(randomizer.streams_count):
				randomizer.set_stream(i, voice_high[i])
		GLOBALS.voice_types.MEDIUM:
			for i in range(randomizer.streams_count):
				randomizer.set_stream(i, voice_medium[i])
		GLOBALS.voice_types.LOW:
			for i in range(randomizer.streams_count):
				randomizer.set_stream(i, voice_low[i])

func stop_playback():
	timer.stop()
	playing = false
