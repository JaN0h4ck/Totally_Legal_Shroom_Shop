class_name FootstepManager
extends Area2D

const FOOTSTEPS_CONCRETE: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Concrete.wav")
const FOOTSTEPS_RUG: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Rug.wav")
const FOOTSTEPS_SOIL: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Soil.wav")
const FOOTSTEPS_STAIRS: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Stairs.wav")
const FOOTSTEPS_WOOD: AudioStreamWAV = preload("res://Audio/Originals/SFX/FOOTSTEPS/Shrooms FX - Footsteps Wood.wav")

@onready var parent: CharacterBody2D = $".."

@onready var footstep_player: AudioStreamPlayer2D = $FootstepPlayer

func _physics_process(delta: float) -> void:
	if footstep_player.playing:
		if parent.velocity.is_zero_approx():
			footstep_player.stop()
		return
	footstep_player.play()

func set_floor_type(type: AudioFloor.FloorTypes):
	footstep_player.stop()
	match type:
		AudioFloor.FloorTypes.Wood:
			footstep_player.stream = FOOTSTEPS_WOOD
		AudioFloor.FloorTypes.Soil:
			footstep_player.stream = FOOTSTEPS_SOIL
		AudioFloor.FloorTypes.Rug:
			footstep_player.stream = FOOTSTEPS_RUG
		AudioFloor.FloorTypes.Concrete:
			footstep_player.stream = FOOTSTEPS_CONCRETE
