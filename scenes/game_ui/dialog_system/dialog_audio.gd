class_name DialogAudio
extends AudioStreamPlayer

enum VoiceTypes { HIGH, MEDIUM, LOW }

@export var voice_high: Array[AudioStreamWAV]
@export var voice_medium: Array[AudioStreamWAV]
@export var voice_low: Array[AudioStreamWAV]

var timer: Timer = Timer.new()

var is_playing: bool = false

func _ready() -> void:
	timer.wait_time = .15
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	if is_playing:
		play()

func start_playback(type: VoiceTypes):
	set_voice(type)
	is_playing = true
	timer.start()
	play()

func set_voice(type: VoiceTypes):
	var randomizer: AudioStreamRandomizer = stream
	match type:
		VoiceTypes.HIGH:
			for i in range(randomizer.streams_count):
				randomizer.set_stream(i, voice_high[i])
		VoiceTypes.MEDIUM:
			for i in range(randomizer.streams_count):
				randomizer.set_stream(i, voice_medium[i])
		VoiceTypes.LOW:
			for i in range(randomizer.streams_count):
				randomizer.set_stream(i, voice_low[i])

func stop_playback():
	timer.stop()
	is_playing = false
