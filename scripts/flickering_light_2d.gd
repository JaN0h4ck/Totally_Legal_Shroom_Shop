@tool
extends PointLight2D

@export var noise: NoiseTexture2D
@export var base_energy: float = 1
@export var sample_scale: float = 4
@export var speed: float = 4
var time_passed: float = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	
	if noise == null: return
	var sample = noise.noise.get_noise_1d(time_passed * speed)
	sample = abs(sample)
	
	energy = sample * sample_scale + base_energy

func _notification(what: int) -> void:
	if(what == NOTIFICATION_EDITOR_PRE_SAVE):
		energy = base_energy
